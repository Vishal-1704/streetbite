import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:streetbite/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bottomNavScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayName = '';
  String currentCity = 'Fetching...';

  final authService = AuthService();
  List<String> availableCities = ['Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Hyderabad'];

  @override
  void initState() {
    super.initState();
    fetchDisplayName();
    fetchLocation();
  }

  Future<void> fetchDisplayName() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final metadata = user.userMetadata;
      setState(() {
        displayName = metadata?['display_name'] ?? '';
      });
    }
  }

  Future<void> fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        currentCity = place.locality ?? place.administrativeArea ?? 'Unknown';
      });
    } catch (e) {
      print('Location fetch failed: $e');
    }
  }

  void showCitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: availableCities.map((city) {
          return ListTile(
            title: Text(city),
            leading: Icon(Icons.location_city),
            onTap: () {
              setState(() {
                currentCity = city;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: showCitySelector,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, color: Colors.white),
              SizedBox(width: 4),
              Text(
                currentCity,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_active),
          ),
        ],
      ),

      body: Center(
        child: Text(
          "Hello, $displayName 👋",
          style: TextStyle(fontSize: 24),
        ),
      ),

      bottomNavigationBar: navBar(),
    );
  }
}

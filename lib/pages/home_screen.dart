import 'package:flutter/material.dart';
import 'package:streetbite/services/location_service.dart';
import 'package:streetbite/services/user_info.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayName = '';
  String currentCity = 'Fetching...';
  List<String> availableCities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Chennai',
    'Hyderabad',
  ];

  @override
  void initState() {
    super.initState();
    displayName = UserInfo.getDisplayName()!;
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    String city = await LocationService.getCurrentCity();
    setState(() {
      currentCity = city;
    });
  }

  void showCitySelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setModalState) {
              bool isLoading = false;

              Future<void> detectLocation() async {
                setModalState(() => isLoading = true);
                try {
                  String detectedCity = await LocationService.getCurrentCity();

                  if (mounted) {
                    setState(() {
                      currentCity = detectedCity;
                    });
                    Navigator.pop(context); // Close modal
                  }
                } catch (e) {
                  print("Error detecting location: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to detect location")),
                  );
                } finally {
                  setModalState(() => isLoading = false);
                }
              }

              return Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.my_location),
                      title:
                          isLoading
                              ? Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text("Detecting..."),
                                ],
                              )
                              : Text("Detect My Location"),
                      onTap: isLoading ? null : detectLocation,
                    ),
                    Divider(),
                    ...availableCities.map((city) {
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
                  ],
                ),
              );
            },
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
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active)),
        ],
      ),
      body: Column(children: [
        Center(
          child: Container(
          child: Text("W E L C O M E  $displayName"),
                ),
        )]),
    );
  }
}

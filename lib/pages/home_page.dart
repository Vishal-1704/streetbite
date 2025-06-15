import 'package:flutter/material.dart';
import 'package:streetbite/auth/auth_service.dart';
import 'package:streetbite/pages/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayName = '';
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchDisplayName();
  }

  Future<void> fetchDisplayName() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      final metadata = user.userMetadata;
      setState(() {
        displayName = metadata!['display_name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $displayName"),
        actions: [
          IconButton(onPressed: ProfilePage(), icon: Icon(Icons.notifications_active))
        ],
      ),
      body: Center(
        child: Text(
          "Hello, $displayName 👋",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

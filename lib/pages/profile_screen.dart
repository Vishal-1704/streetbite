import 'package:flutter/material.dart';
import 'package:streetbite/auth/auth_service.dart';
import 'package:streetbite/services/user_info.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();

 final _displayName = UserInfo.getDisplayName();



  void logout() async{
    await authService.signOut();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: Text("Welcome, $_displayName"),
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
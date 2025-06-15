/*  continue listen for auth state changes
unauthenticated = loginPage
authenticted => homepage

*/



import 'package:flutter/material.dart';
import 'package:streetbite/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:streetbite/pages/login_page.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

      // listen to auth state changes
        stream: Supabase.instance.client.auth.onAuthStateChange,
        // loading screen
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // check if there is valid session currently

          final authState = snapshot.data;
          final session = authState?.session;
           if (session != null) {
            return HomePage();
          }
          else {
            return LoginPage();
          }
        },

    );
  }
}

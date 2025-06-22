import 'package:flutter/material.dart';
import 'package:streetbite/auth/auth_service.dart';
import 'package:streetbite/pages/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final authService = AuthService();

  // text controller

  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  // on signup button pressed
  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final displayName = _displayNameController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords don't match")),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': displayName,
        },
      );

      final user = response.user;

      // Insert into profiles
      await Supabase.instance.client.from('profiles').upsert({
        'id': user!.id,
        'display_name': displayName,
      });

      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }





    @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Sign Up"),),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 50),
          children: [
            // Display name
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 12),


            // email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: "Email"
              ),
            ),

            SizedBox(height: 12),
            // password
            TextField(
              decoration: InputDecoration(
                labelText: "Password" ,
              ),
              controller: _passwordController,
            ),
SizedBox(height: 12,),
// confirm password
            TextField(
              decoration: InputDecoration(
                labelText: "Confirm Password" ,
              ),
              controller: _confirmPasswordController,
            ),

            ElevatedButton(onPressed: signUp, child: const Text("Sign Up"),),

            SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>  LoginScreen(),),),
              child:Center(
                child: Text("Already have an account? Login"),
              ),
            )

          ],

        )
    );
  }
}

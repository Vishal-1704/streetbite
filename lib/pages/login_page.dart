import 'package:flutter/material.dart';
import 'package:streetbite/auth/auth_service.dart';
import 'package:streetbite/pages/register_page.dart';
import 'package:streetbite/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get auth service
  final authService = AuthService();

  // text controller 
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
// login button Pressed 
  
  void login() async{
    final email = _emailController.text;
    final password = _passwordController.text;
    
    // try login attempt 
    
    try{
      await authService.signInWithEmailPassword(email, password);
    }
    catch (e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
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

          ElevatedButton(onPressed:login, child: const Text("LOGIN"),),

          SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>  RegisterPage(),),),
            child:Center(
              child: Text("Don't have an account? Sign Up"),
            ),
          )

        ],

      )
      );
  }
}

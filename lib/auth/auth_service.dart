import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
   final SupabaseClient _supabase = Supabase.instance.client;


   // SignIn with Email & PAssword
Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
  return await _supabase.auth.signInWithPassword(email: email,password: password);
}


// SignUpWith EMail & PAssword

Future<AuthResponse> signUpWithEmailPassword(String email, String password) async{
  return await _supabase.auth.signUp(email: email,password: password);
}

// Signout
Future<void> signOut() async{
  await _supabase.auth.signOut();
}

// Get User email
 String? getCurrentUserEmail(){
  final session = _supabase.auth.currentSession;
  final user = session?.user;
  return user?.email;

 }











}

import 'package:flutter/material.dart';
import 'package:streetbite/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: "https://xejvtlsmyqirfpfgafwo.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhlanZ0bHNteXFpcmZwZmdhZndvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5ODIxMzgsImV4cCI6MjA2NTU1ODEzOH0.QkV6_ynUDtpi7OnT-setx40GFM-YeXLUxIZP92EW8JM",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false
      ,

      home: AuthGate(),
    );
  }
}

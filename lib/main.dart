import 'package:flutter/material.dart';
import 'package:project_admin/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project_admin/user_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xkzgewnbeemjcmzsdfcp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhremdld25iZWVtamNtenNkZmNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA1MjQxMDUsImV4cCI6MjAyNjEwMDEwNX0.jx_rl2nnOG4IT-B7E_PLnrQIrOZEeDPzfhBT52Tsmrs',
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

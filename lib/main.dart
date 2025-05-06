import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/firebase_options.dart';
import 'package:top_ai_assignment/routes/routes.dart';
import 'package:top_ai_assignment/screens/login_screen.dart';
import 'package:top_ai_assignment/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://iejpmpobwmjcontlnuen.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImllanBtcG9id21qY29udGxudWVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxNDQyNDYsImV4cCI6MjA1MTcyMDI0Nn0.3Mb7p2OWTXJW9FekaOMYBMS7wgwhxOlaYMFU9YAJCSU',
  );
  runApp(MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
      initialRoute: SplashScreen.routeName,
    );
  }
}

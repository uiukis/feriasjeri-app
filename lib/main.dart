import 'package:feriasjeri_app/views/home_screen.dart';
import 'package:feriasjeri_app/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MaterialApp(
    home: user != null ? const HomeScreen() : const LoginScreen(),
  ));
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/chat_page.dart';
import 'package:task/screens/forget_password.dart';
import 'package:task/screens/login_screen.dart';
import 'package:task/screens/sign%20up.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        LoginScreen.routename:(context)=> const LoginScreen(),
        ForgetPassword.routeName:(context) => const ForgetPassword(),
        SignUp.routename:(context) => const SignUp(),
        ChatPage.routename:(context) => const ChatPage(),
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flash_chat/welcome_screen.dart';
import 'package:flash_chat/signin.dart';
import 'package:flash_chat/register.dart';
import 'package:flash_chat/login.dart';
import 'package:flash_chat/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignupPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/chat': (context) => const ChatScreen(),
      },
      title: 'Flash Chat',
    );
  }
}

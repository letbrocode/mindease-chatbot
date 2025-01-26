import 'package:flutter/material.dart';
import 'screens/chatbot_screen.dart';
import 'screens/home_screen.dart';

import 'screens/resources_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        // '/mood_log': (context) => const MoodLogScreen(),
        '/resources': (context) => const ResourcesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
      },
    );
  }
}

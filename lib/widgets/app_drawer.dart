import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu',
                style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
          _buildDrawerItem(Icons.home, 'Home', () {
            Navigator.pushReplacementNamed(context, '/home');
          }),
          _buildDrawerItem(Icons.chat, 'Chatbot', () {
            Navigator.pushReplacementNamed(context, '/chatbot');
          }),
          _buildDrawerItem(Icons.mood, 'Mood Log', () {
            Navigator.pushReplacementNamed(context, '/mood_log');
          }),
          _buildDrawerItem(Icons.person, 'Profile', () {
            Navigator.pushReplacementNamed(context, '/profile');
          }),
          _buildDrawerItem(Icons.book, 'Resources', () {
            Navigator.pushReplacementNamed(context, '/resources');
          }),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

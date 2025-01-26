import 'package:chatbot_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('User Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 60)),
            const SizedBox(height: 16),
            _ProfileForm(),
          ],
        ),
      ),
    );
  }
}

class _ProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Name', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Email', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {}, // Save profile logic
          child: const Text('Save Profile'),
        ),
      ],
    );
  }
}

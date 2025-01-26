import 'package:chatbot_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources'), centerTitle: true),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Mental Health Resources',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  _ResourceItem(
                      icon: Icons.book, title: 'Mental Health Articles'),
                  _ResourceItem(icon: Icons.headset, title: 'Podcasts'),
                  _ResourceItem(
                      icon: Icons.local_hospital, title: 'Find a Therapist'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ResourceItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Handle resource navigation or link
        },
      ),
    );
  }
}

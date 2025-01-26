// mood_rating_item.dart
import 'package:flutter/material.dart';

class MoodRatingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap; // Add onTap callback

  const MoodRatingItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap, // Accept onTap as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(), // Call the onTap function
      child: Card(
        elevation: 6,
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NewProjectScreen extends StatelessWidget {
  const NewProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.create_new_folder, size: 64, color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              "Create a New Project",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Start building your next amazing mobile app.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/prompt_panel'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text("Start with AI Prompt"),
            ),
          ],
        ),
      ),
    );
  }
}

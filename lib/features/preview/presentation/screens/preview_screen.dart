import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "App Preview generated successfully!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Your requested UI has been generated. You can now download the source code or preview it interactive inside the studio.",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text("Download Source"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Container(
            width: 320,
            height: 640,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.phone_iphone, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Interactive Mobile Preview", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PromptPanelScreen extends StatefulWidget {
  const PromptPanelScreen({super.key});

  @override
  State<PromptPanelScreen> createState() => _PromptPanelScreenState();
}

class _PromptPanelScreenState extends State<PromptPanelScreen> {
  final TextEditingController _promptController = TextEditingController();

  void _onGenerate(BuildContext context) {
    if (_promptController.text.trim().isNotEmpty) {
      Navigator.pushNamed(context, '/agent_activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Describe your mobile app features, UI style, and backend requirements...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _promptController,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: "E.g. A crypto tracking app with dark mode...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("2,400 tokens left", style: TextStyle(color: Colors.grey)),
                ElevatedButton(
                  onPressed: () => _onGenerate(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text("Generate Architecture"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

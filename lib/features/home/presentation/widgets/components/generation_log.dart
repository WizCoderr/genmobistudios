import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GenerationLog extends StatelessWidget {
  final List<String> logs;

  const GenerationLog({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: logs.isEmpty
          ? Center(
              child: Text(
                "Waiting for logs...",
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
            )
          : Markdown(
              data: logs.join('\n\n'),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
    );
  }
}

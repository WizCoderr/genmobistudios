import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_text_field.dart';

class AppInputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onGenerate;
  final bool isLoading;

  const AppInputBox({
    super.key,
    required this.controller,
    required this.onGenerate,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Describe your app idea",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: controller,
          hintText: "e.g., Create a Todo app with authentication and Supabase backend.",
          isMultiLine: true,
          maxLines: 6,
        ),
      ],
    );
  }
}

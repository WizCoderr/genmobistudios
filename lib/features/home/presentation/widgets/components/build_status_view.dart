import 'package:flutter/material.dart';
import '../../../../../core/models/app_generation_session.dart';

class BuildStatusView extends StatelessWidget {
  final BuildStage currentStage;

  const BuildStatusView({super.key, required this.currentStage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Build Progress",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildStageItem("Planning", BuildStage.planning, theme),
          _buildStageDivider(theme),
          _buildStageItem("Architecture", BuildStage.architecture, theme),
          _buildStageDivider(theme),
          _buildStageItem("Code Generation", BuildStage.generation, theme),
          _buildStageDivider(theme),
          _buildStageItem("Build", BuildStage.build, theme),
        ],
      ),
    );
  }

  Widget _buildStageItem(String title, BuildStage stage, ThemeData theme) {
    bool isCompleted = currentStage.index > stage.index || currentStage == BuildStage.completed;
    bool isActive = currentStage == stage;

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? Colors.green
                : (isActive ? theme.colorScheme.primary : theme.colorScheme.outlineVariant),
          ),
          child: isCompleted
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : (isActive
                  ? const Center(
                      child: SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStageDivider(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(left: 11, top: 4, bottom: 4),
      height: 20,
      width: 2,
      color: theme.colorScheme.outlineVariant,
    );
  }
}

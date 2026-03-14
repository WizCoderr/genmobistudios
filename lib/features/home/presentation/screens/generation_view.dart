import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/app_generation_session.dart';
import '../providers/home_provider.dart';
import '../widgets/components/app_input_box.dart';
import '../widgets/components/build_status_view.dart';
import '../widgets/components/generation_log.dart';
import '../../../../shared/widgets/app_button.dart';

class GenerationView extends StatefulWidget {
  const GenerationView({super.key});

  @override
  State<GenerationView> createState() => _GenerationViewState();
}

class _GenerationViewState extends State<GenerationView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What are we building today?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          AppInputBox(
            controller: _controller,
            onGenerate: () => homeProvider.generateApp(_controller.text),
            isLoading: homeProvider.isLoading,
          ),
          const SizedBox(height: 24),
          AppButton(
            label: "Generate Core Logic",
            isLoading: homeProvider.isLoading,
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                homeProvider.generateApp(_controller.text);
              }
            },
            isFullWidth: true,
          ),
          if (homeProvider.currentSession != null || homeProvider.isLoading) ...[
            const SizedBox(height: 40),
            BuildStatusView(
              currentStage: homeProvider.currentSession?.stage ?? BuildStage.planning,
            ),
            const SizedBox(height: 24),
            const Text(
              "LIVE STREAM LOGS",
              style: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            GenerationLog(logs: homeProvider.currentSession?.logs ?? []),
          ],
          if (homeProvider.error != null) ...[
            const SizedBox(height: 24),
            Text(
              homeProvider.error!,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ],
        ],
      ),
    );
  }
}

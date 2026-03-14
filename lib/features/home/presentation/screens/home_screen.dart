import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/components/app_input_box.dart';
import '../widgets/components/build_status_view.dart';
import '../widgets/components/generation_log.dart';
import '../../../../shared/widgets/app_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GenMobi Studio",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () => Navigator.pushNamed(context, '/generated_apps'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInputBox(
              controller: _controller,
              onGenerate: () => homeProvider.generateApp(_controller.text),
              isLoading: homeProvider.isLoading,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: "Generate App",
              isLoading: homeProvider.isLoading,
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  homeProvider.generateApp(_controller.text);
                }
              },
            ),
            if (homeProvider.currentSession != null || homeProvider.isLoading) ...[
              const SizedBox(height: 40),
              BuildStatusView(
                currentStage: homeProvider.currentSession?.stage ?? BuildStage.planning,
              ),
              const SizedBox(height: 24),
              const Text(
                "Logs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

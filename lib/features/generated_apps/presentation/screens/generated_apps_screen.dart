import 'package:flutter/material.dart';
import '../../../../core/models/app_generation_session.dart';
import '../../../../core/services/api_service.dart';
import '../../../../shared/widgets/loading_indicator.dart';

class GeneratedAppsScreen extends StatefulWidget {
  const GeneratedAppsScreen({super.key});

  @override
  State<GeneratedAppsScreen> createState() => _GeneratedAppsScreenState();
}

class _GeneratedAppsScreenState extends State<GeneratedAppsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<AppGenerationSession>> _appsFuture;

  @override
  void initState() {
    super.initState();
    _appsFuture = _apiService.getGeneratedApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generated Apps"),
      ),
      body: FutureBuilder<List<AppGenerationSession>>(
        future: _appsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator(size: 40));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No apps generated yet."));
          }

          final apps = snapshot.data!;
          return ListView.builder(
            itemCount: apps.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final app = apps[index];
              return Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    app.prompt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text("Status: ${app.stage.name}"),
                      Text("Created: ${app.createdAt.toLocal().toString().split('.')[0]}"),
                    ],
                  ),
                  trailing: app.apkUrl != null
                      ? IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            // Handle download
                          },
                        )
                      : const Icon(Icons.pending_actions),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

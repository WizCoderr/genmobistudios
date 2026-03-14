enum BuildStage { planning, architecture, generation, build, completed, failed }

class AppGenerationSession {
  final String sessionId;
  final String prompt;
  final BuildStage stage;
  final List<String> logs;
  final String? apkUrl;
  final DateTime createdAt;

  AppGenerationSession({
    required this.sessionId,
    required this.prompt,
    required this.stage,
    required this.logs,
    this.apkUrl,
    required this.createdAt,
  });

  factory AppGenerationSession.fromJson(Map<String, dynamic> json) {
    return AppGenerationSession(
      sessionId: json['session_id'],
      prompt: json['prompt'] ?? '',
      stage: BuildStage.values.firstWhere(
        (e) => e.toString().split('.').last == json['stage'],
        orElse: () => BuildStage.planning,
      ),
      logs: List<String>.from(json['logs'] ?? []),
      apkUrl: json['apk_url'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

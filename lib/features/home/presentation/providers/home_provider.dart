import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/models/app_generation_session.dart';
import '../../../../core/services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  AppGenerationSession? _currentSession;
  AppGenerationSession? get currentSession => _currentSession;

  Timer? _statusTimer;

  Future<void> generateApp(String prompt) async {
    _isLoading = true;
    _error = null;
    _currentSession = null;
    notifyListeners();

    try {
      final response = await _apiService.generateApp(prompt);
      final sessionId = response['session_id'];
      
      // Start polling for status
      _startPolling(sessionId);
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startPolling(String sessionId) {
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      try {
        final session = await _apiService.getBuildStatus(sessionId);
        _currentSession = session;
        
        if (session.stage == BuildStage.completed || session.stage == BuildStage.failed) {
          timer.cancel();
          _isLoading = false;
        }
        
        notifyListeners();
      } catch (e) {
        // Handle error or just log it
        print('Polling error: $e');
      }
    });
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }
}

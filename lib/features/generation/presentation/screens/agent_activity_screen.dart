import 'package:flutter/material.dart';
import 'dart:async';

class AgentActivityScreen extends StatefulWidget {
  const AgentActivityScreen({super.key});

  @override
  State<AgentActivityScreen> createState() => _AgentActivityScreenState();
}

class _AgentActivityScreenState extends State<AgentActivityScreen> {
  int _currentStep = 0;
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _simulateAgentProgress();
  }

  void _simulateAgentProgress() async {
    _addLog("Initializing Generation Workflow...");
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _currentStep = 1);

    _addLog("Planner Agent: Defining schema & architecture...");
    await Future.delayed(const Duration(seconds: 2));
    _addLog("System Architect: Mapping Provider states...");
    await Future.delayed(const Duration(seconds: 1));
    _addLog("System Architect: Generating navigation routes...");
    setState(() => _currentStep = 2);

    await Future.delayed(const Duration(seconds: 2));
    _addLog("Core Coder: Writing production code...");
    _addLog("Injecting ThemeTokens into MaterialApp...");
    await Future.delayed(const Duration(seconds: 1));
    _addLog("Building Screen: DashboardScreen.dart...");
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _currentStep = 3);
    _addLog("SUCCESS: Compilation finished.");
    
    // Automatically navigate to preview
    if (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, '/preview');
    }
  }

  void _addLog(String message) {
    if (mounted) {
      setState(() {
        _logs.add("[${TimeOfDay.now().format(context)}] $message");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Agent Orchestrator",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          _buildAgentCard("Planner Agent", "Defining schema & architecture", _currentStep > 0),
          const SizedBox(height: 16),
          _buildAgentCard("System Architect", "Designing Flutter widget tree", _currentStep > 1),
          const SizedBox(height: 16),
          _buildAgentCard("Core Coder", "Writing production code", _currentStep > 2),
          const SizedBox(height: 32),
          const Text("Live Stream Logs", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _logs[index],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.greenAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentCard(String title, String subtitle, bool isCompleted) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted ? Colors.green : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.pending,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Text(
            isCompleted ? "COMPLETED" : "WAITING",
            style: TextStyle(
              color: isCompleted ? Colors.green : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}

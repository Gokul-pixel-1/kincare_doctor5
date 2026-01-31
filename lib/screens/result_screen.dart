import 'package:flutter/material.dart';
import '../services/medical_logic.dart';

class ResultScreen extends StatelessWidget {
  final DiagnosisResult result;
  final int age;
  final int duration;

  const ResultScreen({
    super.key,
    required this.result,
    required this.age,
    required this.duration,
  });

  Color _severityColor() {
    switch (result.severity.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'moderate':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final severityColor = _severityColor();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction Result"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ───────── Clinical Assessment ─────────
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.medical_services, size: 28),
                        SizedBox(width: 8),
                        Text(
                          "Clinical Assessment",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),

                    Text(
                      result.condition,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Chip(
                      label: Text(
                        "Severity: ${result.severity}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: severityColor,
                    ),

                    const SizedBox(height: 16),

                    _infoRow(
                      Icons.person,
                      "Patient Age",
                      "$age years",
                    ),
                    _infoRow(
                      Icons.timer,
                      "Duration",
                      "$duration days",
                    ),
                    _infoRow(
                      Icons.trending_up,
                      "Age Risk",
                      result.ageRisk,
                    ),
                    _infoRow(
                      Icons.bar_chart,
                      "Score",
                      result.score.toStringAsFixed(1),
                    ),
                    _infoRow(
                      Icons.percent,
                      "Confidence",
                      "${result.confidence.toStringAsFixed(0)}%",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ───────── Recommendation ─────────
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.assignment_turned_in, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Clinical Recommendation",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            result.recommendation,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ───────── Disclaimer ─────────
            Card(
              color: severityColor.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.warning_amber,
                      color: Colors.orange,
                      size: 26,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "This is a clinical decision support tool and not a substitute for professional medical diagnosis.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.blueGrey),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
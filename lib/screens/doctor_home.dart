import 'package:flutter/material.dart';
import '../services/medical_logic.dart';
import 'result_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _symptomsCtrl = TextEditingController();

  int _duration = 1;

  final List<String> _allComorbidities = [
    "diabetes",
    "hypertension",
    "asthma",
    "heart disease",
    "obesity",
    "thyroid",
    "kidney disease",
  ];

  final Set<String> _selectedComorbidities = {};

  void _predict() {
    final int age = int.tryParse(_ageCtrl.text) ?? 0;

    final result = MedicalLogic.diagnose(
      age: age,
      symptoms: _symptomsCtrl.text,
    );

   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ResultScreen(
      result: result,
      age: age,
      duration: _duration,
    ),
  ),
);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Panel")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ───────── Patient Details ─────────
            const Text(
              "Patient Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _ageCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _symptomsCtrl,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Symptoms"),
            ),

            const SizedBox(height: 16),

            // ───────── Duration ─────────
            Text("Duration (days): $_duration"),
            Slider(
              value: _duration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: "$_duration days",
              onChanged: (v) => setState(() => _duration = v.toInt()),
            ),

            const SizedBox(height: 16),

            // ───────── Comorbidities ─────────
            const Text(
              "Comorbidities",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: _allComorbidities.map((c) {
                final selected = _selectedComorbidities.contains(c);
                return FilterChip(
                  label: Text(c),
                  selected: selected,
                  onSelected: (v) {
                    setState(() {
                      v
                          ? _selectedComorbidities.add(c)
                          : _selectedComorbidities.remove(c);
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.analytics),
                label: const Text("Predict"),
                onPressed: _predict,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
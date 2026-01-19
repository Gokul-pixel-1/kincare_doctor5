import 'package:flutter/material.dart';
import '../services/medical_logic.dart';
import 'result_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final ageCtrl = TextEditingController();
  final symptomsCtrl = TextEditingController();
  final durationCtrl = TextEditingController();

  String gender = "Male";
  final List<String> selectedComorb = [];

  final List<String> comorbList = [
    "diabetes",
    "hypertension",
    "asthma",
  ];

  void predictCondition() {
    final logic = MedicalLogic();

    final age = int.tryParse(ageCtrl.text.trim()) ?? 25;
    final duration = int.tryParse(durationCtrl.text.trim()) ?? 1;

    final result = logic.diagnose(
      age: age,
      gender: gender,
      symptoms: symptomsCtrl.text,
      durationDays: duration,
      comorbidities: selectedComorb,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Panel"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Age"),
            TextField(
              keyboardType: TextInputType.number,
              controller: ageCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter age",
              ),
            ),
            const SizedBox(height: 20),

            const Text("Gender"),
            DropdownButton<String>(
              value: gender,
              items: ["Male", "Female", "Other"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => gender = v!),
            ),
            const SizedBox(height: 20),

            const Text("Symptoms"),
            TextField(
              controller: symptomsCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Eg: chest pain, sweating",
              ),
            ),
            const SizedBox(height: 20),

            const Text("Duration (days)"),
            TextField(
              keyboardType: TextInputType.number,
              controller: durationCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Eg: 2",
              ),
            ),
            const SizedBox(height: 20),

            const Text("Comorbidity"),
            Wrap(
              spacing: 10,
              children: comorbList.map((c) {
                final isSel = selectedComorb.contains(c);
                return ChoiceChip(
                  selected: isSel,
                  label: Text(c),
                  onSelected: (_) {
                    setState(() {
                      isSel ? selectedComorb.remove(c) : selectedComorb.add(c);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: predictCondition,
                child: const Text("Predict"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
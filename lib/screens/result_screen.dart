import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          result,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
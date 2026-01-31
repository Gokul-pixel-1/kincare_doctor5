import 'package:flutter/material.dart';
import 'screens/doctor_home.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KincareDoctorApp());
}

class KincareDoctorApp extends StatelessWidget {
  const KincareDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kincare Doctor AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DoctorHomeScreen(),
    );
  }
}

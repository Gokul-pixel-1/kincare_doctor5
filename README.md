🩺 Medscope AI
Intelligent Clinical Decision Support System

Medscope AI is a Flutter-based medical decision support application designed to assist healthcare professionals in preliminary clinical assessment based on patient-entered symptoms, age, duration, and comorbidities.
The app uses a rule-based medical reasoning engine to generate disease likelihood, severity, age risk, confidence score, and clinical recommendations.

⚠️ Medscope AI is a clinical support tool, not a replacement for professional medical diagnosis.

🚀 Features
🧑‍⚕️ Doctor Panel

*Patient age input

*Symptom text analysis

*Duration (in days)

*Comorbidity selection (diabetes, hypertension, asthma, etc.)

*Clean, intuitive medical UI

📊 Prediction Result Screen

*Most likely clinical condition (single best match)

*Severity classification (Low / Moderate / High)

*Confidence score (%)

*Age-based risk assessment (dynamic, patient-specific)

*Duration awareness

*Medical-style icons & structured layout

*Clinical recommendations

*Visual disclaimer with warning icon

🎯 Smart Rule Engine

*Rule-based diagnostic logic

*Severity scoring based on:

     *Symptoms
     *Age
     *Duration
    *Comorbidities

*Consistent, explainable results (no black-box AI)

🎨 UI & UX

*Modern Material Design

*Medical-grade color palette

*App launcher icon designed for healthcare branding

*Responsive layout for different screen sizes

🏗️ Tech Stack
Layer	         Technology
Frontend	     Flutter (Dart)
Architecture	 Rule-based clinical logic
UI	           Material Design
Platforms	     Android (iOS ready)
Icons	        flutter_launcher_icons

📁 Project Structure
kincare_doctor5/
├── android/
├── ios/
├── assets/
│   └── icon/
│       └── medscope_ai_icon.png
├── lib/
│   ├── screens/
│   │   ├── doctor_home.dart
│   │   └── result_screen.dart
│   ├── services/
│   │   └── medical_logic.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── main.dart
├── pubspec.yaml
└── README.md

🧠 Medical Logic Overview

Medscope AI uses a deterministic medical rule engine, not machine learning.

The engine evaluates:

*Symptom keywords

*Age thresholds

*Duration patterns

*Selected comorbidities

It then computes:

*Disease likelihood score

*Severity level

*Confidence percentage

*Age-risk relevance

This approach ensures:

*Predictable behavior

*Clinical explainability

*Offline capability

⚠️ Disclaimer

*This application is a clinical decision support tool only.
*It does not provide medical diagnosis or treatment.
*All clinical decisions must be made by a qualified healthcare professional.

🧪 How to Run Locally
*flutter pub get
*flutter run


To generate app launcher icons:

dart run flutter_launcher_icons

📦 Build APK / App Bundle
*flutter build apk
*flutter build appbundle

📌 Future Enhancements

Machine learning-based prediction engine

*Patient history tracking

*Cloud sync & analytics

*Doctor login & role-based access

*FDA-style risk scoring

*Telemedicine integration

👨‍💻 Author

Gokul
Flutter Developer | Medical AI Enthusiast

⭐ Acknowledgement

*Built with a strong focus on medical responsibility, UX clarity, and real-world usability.

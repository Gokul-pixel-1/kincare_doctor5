class DiagnosisResult {
  final String condition;
  final String severity;
  final double score;
  final double confidence;
  final String recommendation;
  final String ageRisk;

  DiagnosisResult({
    required this.condition,
    required this.severity,
    required this.score,
    required this.confidence,
    required this.recommendation,
    required this.ageRisk,
  });
}

class MedicalLogic {
  static DiagnosisResult diagnose({
    required int age,
    required String symptoms,
  }) {
    final text = symptoms.toLowerCase();

    // ───────── Disease Matching ─────────
    String condition = "General Illness";
    String recommendation = "Consult a physician if symptoms persist.";

    if (text.contains("fever")) {
      condition = "Viral Fever";
      recommendation = "Hydration, rest, paracetamol if required.";
    } else if (text.contains("headache") || text.contains("migraine")) {
      condition = "Migraine / Neurological";
      recommendation =
          "Hydration, dark room rest, avoid bright light.";
    } else if (text.contains("chest pain")) {
      condition = "Heart Disease / Angina";
      recommendation =
          "Urgent ECG advised. Avoid exertion. Cardiology consultation required.";
    } else if (text.contains("stomach") || text.contains("acidity")) {
      condition = "Gastric Disorder";
      recommendation = "Avoid spicy food. Antacids if required.";
    }

    // ───────── Severity Logic ─────────
    int severityScore = 0;

    if (age >= 60) severityScore += 2;
    if (text.contains("pain")) severityScore += 2;
    if (text.contains("chest")) severityScore += 3;
    if (text.contains("fever")) severityScore += 1;

    String severity;
    if (severityScore >= 5) {
      severity = "High";
    } else if (severityScore >= 3) {
      severity = "Moderate";
    } else {
      severity = "Low";
    }

    // ───────── Score Calculation (0–10) ─────────
    double score = (severityScore * 1.5).clamp(1.0, 10.0);

    // ───────── Confidence Calculation ─────────
    double confidence = (score * 10).clamp(20, 95);

    // ───────── Age Risk Logic ─────────
    String ageRisk;
    if (age < 18) {
      ageRisk = "LOW (uncommon at this age)";
    } else if (age <= 60) {
      ageRisk = "MODERATE (typical onset range)";
    } else {
      ageRisk = "HIGH (elderly risk group)";
    }

    return DiagnosisResult(
      condition: condition,
      severity: severity,
      score: score,
      confidence: confidence,
      recommendation: recommendation,
      ageRisk: ageRisk,
    );
  }
}
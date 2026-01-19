class MedicalLogic {
  String diagnose({
    required int age,
    required String gender,
    required String symptoms,
    required int durationDays,
    required List<String> comorbidities,
  }) {
    final text = symptoms.toLowerCase();

    double scoreHeart = 0;
    double scoreGastric = 0;
    double scoreViral = 0;
    double scoreMuscle = 0;
    double scoreMigraine = 0;
    double scoreInfection = 0;

    // Symptoms
    if (_hit(text, ["chest pain", "tightness", "breathless", "left arm", "sweating"])) scoreHeart += 4;
    if (_hit(text, ["shoulder", "cramp", "sprain", "joint", "muscle", "back pain"])) scoreMuscle += 3;
    if (_hit(text, ["stomach", "gas", "acidity", "vomit", "diarrhea", "loose motion"])) scoreGastric += 4;
    if (_hit(text, ["fever", "cough", "cold", "throat", "body pain"])) scoreViral += 4;
    if (_hit(text, ["headache", "migraine", "throbbing", "light sensitivity"])) scoreMigraine += 4;
    if (_hit(text, ["rash", "bleeding", "high fever"])) scoreInfection += 5;

    // Age
    if (age >= 45) scoreHeart *= 1.5;
    if (age <= 12) scoreViral *= 1.4;
    if (age >= 18 && age <= 50) scoreMuscle *= 1.2;
    if (age >= 20 && age <= 55) scoreGastric *= 1.2;

    // Gender
    if (gender == "Male") scoreHeart *= 1.2;
    if (gender == "Female") scoreMigraine *= 1.4;

    // Comorbidities
    if (comorbidities.contains("diabetes")) scoreHeart *= 1.4;
    if (comorbidities.contains("hypertension")) scoreHeart *= 1.6;
    if (comorbidities.contains("asthma")) scoreViral *= 1.4;

    // Duration
    if (durationDays >= 7) {
      scoreViral *= 1.3;
      scoreGastric *= 1.2;
      scoreInfection *= 1.5;
    }

    final map = {
      "Cardiac / Angina": scoreHeart,
      "Viral Infection": scoreViral,
      "Gastric / Ulcer": scoreGastric,
      "Muscular Strain": scoreMuscle,
      "Migraine / Neuro": scoreMigraine,
      "Infection (Dengue/Typhoid)": scoreInfection,
    };

    final best = map.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final top = best.first;

    return _report(
      condition: top.key,
      score: top.value,
      age: age,
      gender: gender,
      duration: durationDays,
      comorbidities: comorbidities,
    );
  }

  bool _hit(String text, List<String> words) {
    for (var w in words) {
      if (text.contains(w)) return true;
    }
    return false;
  }

  String _report({
    required String condition,
    required double score,
    required int age,
    required String gender,
    required int duration,
    required List<String> comorbidities,
  }) {
    final severity = score >= 7 ? "High" : score >= 4 ? "Moderate" : "Low";

    return """
🩺 Prediction Result
Condition: $condition
Score: ${score.toStringAsFixed(2)}
Severity: $severity

Patient Details:
Age: $age
Gender: $gender
Duration: $duration days
Comorbidity: ${comorbidities.isEmpty ? "None" : comorbidities.join(", ")}

${_advice(condition)}
""";
  }

  String _advice(String condition) {
    if (condition.contains("Cardiac")) return "🚨 Urgent cardiology evaluation recommended.";
    if (condition.contains("Infection")) return "⚠ CBC test + hydration + rest advised.";
    if (condition.contains("Gastric")) return "Antacid + ORS + avoid oily food.";
    if (condition.contains("Muscular")) return "Analgesic + warm compress suggested.";
    if (condition.contains("Migraine")) return "Hydration + avoid bright light.";
    return "Consult a doctor if symptoms persist.";
  }
}
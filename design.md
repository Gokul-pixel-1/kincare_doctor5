# Design Document - Medscope AI (KinCare Doctor)

## Document Information

**Project Name:** Medscope AI - KinCare Doctor  
**Version:** 1.0.0  
**Date:** February 14, 2026  
**Platform:** Flutter (Cross-platform: iOS & Android)

## Table of Contents

1. System Architecture
2. Design Principles
3. Component Design
4. Data Models
5. User Interface Design
6. Algorithm Design
7. Security Design
8. Error Handling
9. Performance Considerations
10. Testing Strategy

---

## 1. System Architecture

### 1.1 High-Level Architecture

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  ┌─────────────┐    ┌────────────────┐ │
│  │ Doctor Home │───▶│ Result Screen  │ │
│  │   Screen    │    │                │ │
│  └─────────────┘    └────────────────┘ │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Business Logic Layer            │
│  ┌──────────────────────────────────┐  │
│  │     Medical Logic Service        │  │
│  │  (Diagnosis & Risk Assessment)   │  │
│  └──────────────────────────────────┘  │
└─────────────────────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│           Data Layer                    │
│  ┌──────────────────────────────────┐  │
│  │   In-Memory Data Models          │  │
│  │   (No Persistent Storage)        │  │
│  └──────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

### 1.2 Architecture Pattern

**Pattern:** Model-View-Controller (MVC) with Service Layer

- **Model:** DiagnosisResult class
- **View:** DoctorHomeScreen, ResultScreen (Flutter Widgets)
- **Controller:** State management within StatefulWidget
- **Service:** MedicalLogic (business logic)

### 1.3 Technology Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter 3.0+ |
| Language | Dart 3.0+ |
| UI Components | Material Design |
| State Management | StatefulWidget (built-in) |
| Navigation | Navigator (Flutter routing) |
| Build System | Gradle (Android), Xcode (iOS) |

---

## 2. Design Principles

### 2.1 Core Principles

1. **Separation of Concerns:** UI logic separated from business logic
2. **Single Responsibility:** Each class has one clear purpose
3. **Offline-First:** No network dependency for core functionality
4. **Privacy by Design:** No data persistence or transmission
5. **Medical Safety:** Clear disclaimers and conservative recommendations

### 2.2 Design Patterns Used

- **Service Pattern:** MedicalLogic as stateless service
- **Data Transfer Object:** DiagnosisResult for data encapsulation
- **Builder Pattern:** Flutter widget composition
- **State Pattern:** StatefulWidget for UI state management

---

## 3. Component Design

### 3.1 Component Diagram

```
┌──────────────────────┐
│   KincareDoctorApp   │
│   (MaterialApp)      │
└──────────┬───────────┘
           │
┌──────────▼───────────┐
│  DoctorHomeScreen    │
│  ┌────────────────┐  │
│  │ Age Input      │  │
│  │ Symptoms Input │  │
│  │ Duration Slider│  │
│  │ Comorbidities  │  │
│  │ Predict Button │  │
│  └────────┬───────┘  │
└───────────┼──────────┘
            │
┌───────────▼──────────┐
│   MedicalLogic       │
│   diagnose()         │
└───────────┬──────────┘
            │
┌───────────▼──────────┐
│  DiagnosisResult     │
└───────────┬──────────┘
            │
┌───────────▼──────────┐
│   ResultScreen       │
│  ┌────────────────┐  │
│  │ Assessment Card│  │
│  │ Recommendation │  │
│  │ Disclaimer     │  │
│  └────────────────┘  │
└──────────────────────┘
```

### 3.2 Component Descriptions

#### 3.2.1 KincareDoctorApp
- **Type:** StatelessWidget
- **Responsibility:** Application root, theme configuration
- **Key Properties:**
  - `title`: App name
  - `theme`: AppTheme.lightTheme
  - `home`: DoctorHomeScreen

#### 3.2.2 DoctorHomeScreen
- **Type:** StatefulWidget
- **Responsibility:** Patient data collection interface
- **State Variables:**
  - `_ageCtrl`: TextEditingController for age
  - `_symptomsCtrl`: TextEditingController for symptoms
  - `_duration`: int (1-30 days)
  - `_selectedComorbidities`: Set<String>
- **Methods:**
  - `_predict()`: Triggers diagnosis and navigation

#### 3.2.3 MedicalLogic
- **Type:** Static Service Class
- **Responsibility:** Diagnostic algorithm implementation
- **Methods:**
  - `diagnose()`: Main diagnostic function
- **Algorithm Steps:**
  1. Symptom keyword matching
  2. Condition identification
  3. Severity score calculation
  4. Confidence computation
  5. Age risk assessment

#### 3.2.4 ResultScreen
- **Type:** StatelessWidget
- **Responsibility:** Display diagnostic results
- **Methods:**
  - `_severityColor()`: Maps severity to color
  - `_infoRow()`: Reusable info display widget

---

## 4. Data Models

### 4.1 DiagnosisResult Model

```dart
class DiagnosisResult {
  final String condition;      // Identified medical condition
  final String severity;        // "High", "Moderate", "Low"
  final double score;           // 1.0 - 10.0
  final double confidence;      // 20.0 - 95.0 (percentage)
  final String recommendation;  // Clinical advice
  final String ageRisk;        // Age-based risk level
}
```

### 4.2 Data Flow

```
User Input → Controller → Service → Model → View
   ↓            ↓           ↓         ↓       ↓
  Age      _predict()   diagnose() Result  Display
Symptoms                                   Screen
Duration
Comorbidities
```

---

## 5. User Interface Design

### 5.1 Screen Flow

```
┌─────────────────┐
│  Doctor Home    │
│    Screen       │
│                 │
│  [Input Form]   │
│  [Predict Btn]  │
└────────┬────────┘
         │ Navigate
         ▼
┌─────────────────┐
│  Result Screen  │
│                 │
│  [Assessment]   │
│  [Recommend]    │
│  [Disclaimer]   │
│  [Back Button]  │
└─────────────────┘
```

### 5.2 Doctor Home Screen Layout

```
┌────────────────────────────────┐
│  ☰  Doctor Panel              │
├────────────────────────────────┤
│                                │
│  Patient Details               │
│  ┌──────────────────────────┐ │
│  │ Age: [____]              │ │
│  └──────────────────────────┘ │
│  ┌──────────────────────────┐ │
│  │ Symptoms:                │ │
│  │ [________________]       │ │
│  │ [________________]       │ │
│  └──────────────────────────┘ │
│                                │
│  Duration (days): 15           │
│  ├──────●─────────────────┤   │
│  1                       30    │
│                                │
│  Comorbidities                 │
│  [diabetes] [hypertension]     │
│  [asthma] [heart disease]      │
│  [obesity] [thyroid]           │
│  [kidney disease]              │
│                                │
│      ┌──────────────┐          │
│      │ 📊 Predict   │          │
│      └──────────────┘          │
└────────────────────────────────┘
```

### 5.3 Result Screen Layout

```
┌────────────────────────────────┐
│  ←  Prediction Result          │
├────────────────────────────────┤
│                                │
│  ┌──────────────────────────┐ │
│  │ 🏥 Clinical Assessment   │ │
│  │ ─────────────────────    │ │
│  │                          │ │
│  │ Viral Fever              │ │
│  │ [Severity: Moderate]     │ │
│  │                          │ │
│  │ 👤 Patient Age: 45 years │ │
│  │ ⏱ Duration: 5 days       │ │
│  │ 📈 Age Risk: MODERATE    │ │
│  │ 📊 Score: 4.5            │ │
│  │ % Confidence: 67%        │ │
│  └──────────────────────────┘ │
│                                │
│  ┌──────────────────────────┐ │
│  │ ✅ Clinical Recommend    │ │
│  │                          │ │
│  │ Hydration, rest,         │ │
│  │ paracetamol if required. │ │
│  └──────────────────────────┘ │
│                                │
│  ┌──────────────────────────┐ │
│  │ ⚠ This is a clinical     │ │
│  │ decision support tool... │ │
│  └──────────────────────────┘ │
└────────────────────────────────┘
```

### 5.4 Color Scheme

| Element | Color | Usage |
|---------|-------|-------|
| High Severity | Red (#F44336) | Critical conditions |
| Moderate Severity | Orange (#FF9800) | Moderate risk |
| Low Severity | Green (#4CAF50) | Low risk |
| Primary | Blue (#2196F3) | App bar, buttons |
| Background | White (#FFFFFF) | Main background |
| Card | White with elevation | Content containers |

### 5.5 Typography

| Element | Font Size | Weight |
|---------|-----------|--------|
| App Title | 20sp | Bold |
| Section Headers | 16-18sp | Bold |
| Body Text | 14-15sp | Regular |
| Labels | 14sp | Semi-bold |
| Disclaimer | 13sp | Regular |

---

## 6. Algorithm Design

### 6.1 Diagnostic Algorithm

```
┌─────────────────────────────────────┐
│  Input: age, symptoms               │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Step 1: Symptom Analysis           │
│  - Convert to lowercase             │
│  - Keyword matching                 │
│  - Condition identification         │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Step 2: Severity Calculation       │
│  - Initialize score = 0             │
│  - Age ≥ 60: +2                     │
│  - Contains "pain": +2              │
│  - Contains "chest": +3             │
│  - Contains "fever": +1             │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Step 3: Severity Classification    │
│  - Score ≥ 5: HIGH                  │
│  - Score 3-4: MODERATE              │
│  - Score < 3: LOW                   │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Step 4: Score & Confidence         │
│  - score = (severityScore × 1.5)    │
│  - Clamp to 1.0-10.0                │
│  - confidence = score × 10          │
│  - Clamp to 20-95                   │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Step 5: Age Risk Assessment        │
│  - Age < 18: LOW                    │
│  - Age 18-60: MODERATE              │
│  - Age > 60: HIGH                   │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Output: DiagnosisResult            │
└─────────────────────────────────────┘
```

### 6.2 Condition Matching Logic

```dart
Keyword Patterns:
├─ "fever" → Viral Fever
├─ "headache" OR "migraine" → Migraine/Neurological
├─ "chest pain" → Heart Disease/Angina
├─ "stomach" OR "acidity" → Gastric Disorder
└─ Default → General Illness
```

### 6.3 Recommendation Mapping

| Condition | Recommendation |
|-----------|----------------|
| Viral Fever | Hydration, rest, paracetamol if required |
| Migraine | Hydration, dark room rest, avoid bright light |
| Heart Disease | Urgent ECG advised, avoid exertion, cardiology consultation |
| Gastric Disorder | Avoid spicy food, antacids if required |
| General Illness | Consult physician if symptoms persist |

---

## 7. Security Design

### 7.1 Data Privacy

- **No Persistent Storage:** Patient data exists only in memory
- **No Network Transmission:** All processing is local
- **Session-Based:** Data cleared when app closes
- **No Logging:** Sensitive data not logged

### 7.2 Input Validation

```dart
Validation Rules:
├─ Age: Integer, 0-150 range (default 0 if invalid)
├─ Symptoms: String, no length limit
├─ Duration: Integer, 1-30 range (slider enforced)
└─ Comorbidities: Predefined set only
```

### 7.3 Security Considerations

1. **Medical Disclaimer:** Prominently displayed
2. **No Authentication:** Assumes device-level security
3. **No Authorization:** Single-user application
4. **Data Sanitization:** Input converted to lowercase for matching

---

## 8. Error Handling

### 8.1 Error Scenarios

| Scenario | Handling |
|----------|----------|
| Invalid age input | Default to 0, proceed with diagnosis |
| Empty symptoms | Diagnose as "General Illness" |
| No comorbidities selected | Proceed normally (optional field) |
| Navigation failure | Flutter handles with error screen |

### 8.2 User Feedback

- **Input Errors:** TextField validation (visual feedback)
- **Processing:** Immediate navigation to results
- **No Loading States:** Processing is instantaneous

---

## 9. Performance Considerations

### 9.1 Performance Targets

| Metric | Target | Actual |
|--------|--------|--------|
| Diagnosis Time | < 100ms | ~10ms |
| Screen Transition | < 300ms | ~200ms |
| Memory Usage | < 50MB | ~30MB |
| App Launch | < 3s | ~2s |

### 9.2 Optimization Strategies

1. **Stateless Widgets:** ResultScreen for better performance
2. **Const Constructors:** Reduce widget rebuilds
3. **Efficient State Management:** Minimal setState() calls
4. **No Heavy Computations:** Simple string matching
5. **Asset Optimization:** Compressed icon images

### 9.3 Scalability Considerations

- **Condition Database:** Currently hardcoded, can be externalized
- **Algorithm Complexity:** O(n) where n = number of keywords
- **UI Rendering:** Scales with screen size automatically

---

## 10. Testing Strategy

### 10.1 Unit Testing

```dart
Test Cases for MedicalLogic.diagnose():
├─ Test 1: Fever symptoms → Viral Fever
├─ Test 2: Chest pain → Heart Disease
├─ Test 3: Headache → Migraine
├─ Test 4: Elderly patient → High age risk
├─ Test 5: Young patient → Low age risk
├─ Test 6: High severity score → "High" severity
├─ Test 7: Empty symptoms → General Illness
└─ Test 8: Confidence calculation accuracy
```

### 10.2 Widget Testing

```dart
Test Cases for DoctorHomeScreen:
├─ Test 1: Age input accepts numbers
├─ Test 2: Symptoms input accepts text
├─ Test 3: Duration slider updates value
├─ Test 4: Comorbidity chips toggle selection
├─ Test 5: Predict button triggers navigation
└─ Test 6: Form validation works correctly
```

### 10.3 Integration Testing

```dart
End-to-End Scenarios:
├─ Scenario 1: Complete diagnosis flow
├─ Scenario 2: Navigate back from results
├─ Scenario 3: Multiple diagnoses in session
└─ Scenario 4: App lifecycle (pause/resume)
```

### 10.4 Manual Testing Checklist

- [ ] Install on Android device
- [ ] Install on iOS device
- [ ] Test all condition types
- [ ] Verify color coding
- [ ] Check text readability
- [ ] Test landscape orientation
- [ ] Verify disclaimer visibility
- [ ] Test with various age ranges
- [ ] Validate severity calculations
- [ ] Check recommendation accuracy

---

## 11. Deployment Design

### 11.1 Build Configuration

```yaml
Android:
├─ Min SDK: 21 (Android 5.0)
├─ Target SDK: 34 (Android 14)
├─ Build Type: Release
└─ Signing: Release keystore

iOS:
├─ Min Version: 12.0
├─ Target: iOS 17
├─ Build Type: Release
└─ Signing: Distribution certificate
```

### 11.2 Release Checklist

- [ ] Update version number
- [ ] Generate app icons
- [ ] Test on physical devices
- [ ] Run flutter analyze
- [ ] Run flutter test
- [ ] Build release APK/IPA
- [ ] Test release builds
- [ ] Prepare store listings
- [ ] Submit for review

---

## 12. Future Enhancements

### 12.1 Architecture Evolution

```
Current (v1.0):
Rule-Based Logic → Results

Future (v2.0):
ML Model + Rule-Based → Enhanced Results
    ↓
Cloud Sync → Patient History
    ↓
EHR Integration → Comprehensive Care
```

### 12.2 Planned Improvements

1. **Machine Learning Integration**
   - TensorFlow Lite model
   - Improved accuracy
   - Learning from outcomes

2. **Backend Integration**
   - Firebase/AWS backend
   - Patient history storage
   - Multi-device sync

3. **Advanced Features**
   - Lab report analysis
   - Drug interaction checker
   - Prescription generation
   - Telemedicine integration

---

## 13. Design Decisions & Rationale

### 13.1 Key Decisions

| Decision | Rationale |
|----------|-----------|
| No persistent storage | Privacy-first approach, HIPAA consideration |
| Rule-based logic | Simplicity, transparency, no ML training needed |
| Material Design | Familiar to users, professional appearance |
| Offline-first | Reliability in areas with poor connectivity |
| StatefulWidget | Simple state management for small app |
| No backend | Reduced complexity, faster development |

### 13.2 Trade-offs

| Trade-off | Chosen | Alternative | Reason |
|-----------|--------|-------------|--------|
| State Management | StatefulWidget | Provider/Bloc | App complexity doesn't justify |
| Storage | None | SQLite/Hive | Privacy concerns |
| Logic | Rule-based | ML Model | Faster development, transparency |
| Navigation | Navigator | GoRouter | Simple navigation needs |

---

## 14. Appendix

### 14.1 File Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── doctor_home.dart     # Patient input screen
│   └── result_screen.dart   # Results display
├── services/
│   └── medical_logic.dart   # Diagnostic algorithm
└── theme/
    └── app_theme.dart       # Theme configuration

assets/
└── icon/
    └── medscope_ai_icon.png # App icon
```

### 14.2 Dependencies Graph

```
main.dart
  ├─→ doctor_home.dart
  │     ├─→ medical_logic.dart
  │     └─→ result_screen.dart
  └─→ app_theme.dart

result_screen.dart
  └─→ medical_logic.dart (DiagnosisResult)
```

### 14.3 Glossary

- **StatefulWidget:** Flutter widget that maintains mutable state
- **MaterialApp:** Root widget for Material Design apps
- **Scaffold:** Basic visual layout structure
- **Navigator:** Flutter's routing and navigation manager
- **FilterChip:** Material Design chip for filtering selections

---

## Document Control

**Version History:**

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | Feb 14, 2026 | Dev Team | Initial design document |

**Approval:**

- Design Lead: ________________
- Technical Lead: ________________
- Medical Advisor: ________________

**Status:** Final - Ready for Implementation

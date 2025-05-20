<p align="center">
  <img src="https://crewmeister.com/images/logo_crewmeister_without_text.svg" width="100" height="100"/>
</p>

# 🚀 Crewmeister Coding Challenge – Absence Manager (Flutter)

Hi Crewmeister team! 👋  
This is my submission for the **Flutter Absence Manager** challenge. The app meets all the requested features — and goes **well beyond** with bonus features, performance touches, and deployment polish.

---

## ✅ Features Implemented

### 🧾 Core Requirements (All Met)

- ✅ Paginated list of absences (first 10 with load more)
- ✅ Total count of absences
- ✅ Full absence detail:
  - Member name
  - Absence type
  - Period
  - Member note (if available)
  - Status (Requested, Confirmed, Rejected)
  - Admitter note (if available)
- ✅ Filter by absence type
- ✅ Filter by date range
- ✅ Loading, error, and empty states
- ✅ Clean state management with **Flutter BLoC + Provider**
- ✅ Full test suite with `flutter_test`

### ✨ Bonus Features (Extras I Added)

- **Small Dart backend (Dart Frog)** for serving API data
- **CI/CD pipeline setup** using GitHub actions
- **Supports both backend API and local file mode**
- **Deployed on Firebase Hosting**
- **Responsive design** — works seamlessly on:
  - Mobile
  - Tablet
  - Web
- **iCal export** (Bonus)
  - Opens file in mobile
  - Triggers download on web
- **Search by employee name**
- **Filter by absence status**

---

## 📺 Demo

🔗 **Live Web App**: [https://crewmeister-app.firebaseapp.com/](https://crewmeister-app.firebaseapp.com/)  
📹 **Video Walkthrough**: [NA](NA)

---

## 🛠 Getting Started

### 🔧 Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>=3.7.2)
- Dart (comes with Flutter)
- Any IDE (VS Code / Android Studio / IntelliJ)

---

### Run the App Locally (Web Default: Local JSON)

```bash
git clone https://github.com/abdulrehman04/Crewmeister-app.git
cd crewmeister-absence-manager
flutter pub get
flutter run
```
The app runs in local mode by default for Web using the assets/json/absences.json and members.json files — no backend required. Optionally, you can change this behaviour in **blocs/absence_manager/repository** by changing:

```bash
fetchFromLocal: kIsWeb // true or false
```

**P.S: You need to run dart server for Mobile**

### Run Dart from server

If you want to use the Dart Frog server instead of local JSON:

**Install Dart Frog CLI:**

```bash
dart pub global activate dart_frog_cli
cd crewmeister_server/
dart_frog dev
```

---

### Run tests and analyse lint

To execute all unit tests and analyse any linting issues:

```bash
flutter test
flutter analyze
```

## 📁 Project Structure (click to expand)

<details> <summary>(click to view full structure)</summary>

```bash
lib/
├── api/
│   └── api.dart
├── blocs/absence_manager/
│   ├── enums/
│   │   └── absence_type.dart
│   ├── models/
│   │   ├── absence_model.dart
│   │   ├── absentee_item.dart
│   │   ├── member_model.dart
│   │   └── paginated_absence_result.dart
│   ├── states/
│   │   ├── _export_absences_state.dart
│   │   └── _fetch_absentees_state.dart
│   ├── absence_manager_bloc.dart
│   ├── data_provider.dart
│   ├── event.dart
│   ├── repo_interface.dart
│   ├── repository.dart
│   └── state.dart
├── configs/
│   ├── extensions/
│   │   └── color_extensions.dart
│   ├── theme/
│   │   └── _colors.dart
│   └── ui/
│       ├── _breakpoints.dart
│       ├── _media.dart
│       └── configs.dart
├── models/
│   └── absence_filters.dart
├── router/
│   ├── app_router.dart
│   └── routes.dart
├── screens/absence_manager/
│   ├── static/
│   │   └── _keys.dart
│   ├── views/
│   │   ├── desktop.dart
│   │   ├── mobile.dart
│   │   └── tablet.dart
│   └── widgets/
│       ├── _absentee_card.dart
│       ├── _base_view.dart
│       ├── _build_content.dart
│       ├── _build_list.dart
│       ├── _filters_drawer.dart
│       ├── _filters_model_sheet.dart
│       ├── _filters_row.dart
│       ├── _note_widget.dart
│       ├── _search_view.dart
│       ├── _state.dart
│       └── absence_manager.dart
├── services/
│   ├── api_service.dart
│   ├── calender_service.dart
│   └── responsive.dart
├── utils/
│   ├── _ui_utils.dart
│   └── utils.dart
├── widgets/
│   ├── input/
│   │   ├── app_dropdown.dart
│   │   ├── app_text_field.dart
│   │   └── date_picker_button.dart
│   └── ui/
│       ├── app_button.dart
│       └── app_heading.dart
└── main.dart

test/
└── blocs/
    ├── _error_throw_fake_repo.dart
    ├── _success_fake_repo.dart
    └── absence_manager_bloc_test.dart

server/
└── (Dart Frog API server for mock data)
```
</details>
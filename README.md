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

🔗 **Live Web App**: [https://crewmeister-absence-manager.web.app](https://crewmeister-absence-manager.web.app)  
📹 **Video Walkthrough**: [Link to explanation video](#) *(NA)*

---

## 🛠 Getting Started

### 🔧 Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>=3.7.2)
- Dart (comes with Flutter)
- Any IDE (VS Code / Android Studio / IntelliJ)

---

### ▶️ Run the App Locally (Web Default: Local JSON)

```bash
git clone https://github.com/abdulrehman04/Crewmeister-app.git
cd crewmeister-absence-manager
flutter pub get
flutter run
```
The app runs in local mode by default for Web using the assets/json/absences.json and members.json files — no backend required.
**You need to run dart server for Mobile**

### ▶️ Run Dart from server

If you want to use the Dart Frog server instead of local JSON:

**Install Dart Frog CLI:**

```bash
dart pub global activate dart_frog_cli
cd crewmeister_server/
dart_frog dev
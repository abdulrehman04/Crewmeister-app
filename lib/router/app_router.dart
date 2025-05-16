import 'package:crewmeister_app/router/routes.dart';
import 'package:crewmeister_app/screens/absence_manager/absence_manager.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.absenceManager,
    routes: [
      GoRoute(
        path: AppRoutes.absenceManager,
        builder: (context, state) {
          return const AbsenceManagerScreen();
        },
      ),
    ],
  );
}

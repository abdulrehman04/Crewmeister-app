import 'package:crewmeister_app/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part './_state.dart';
part './views/desktop.dart';
part './views/mobile.dart';
part './views/tablet.dart';

class AbsenceManagerScreen extends StatelessWidget {
  const AbsenceManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ScreenState(),
      child: Scaffold(
        body: Responsive(
          mobile: const _Mobile(),
          tablet: const _Tablet(),
          desktop: const _Desktop(),
        ),
      ),
    );
  }
}

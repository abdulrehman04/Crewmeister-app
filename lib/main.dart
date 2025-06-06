import 'package:crewmeister_app/blocs/absence_manager/absence_manager_bloc.dart';
import 'package:crewmeister_app/configs/configs.dart';
import 'package:crewmeister_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppMedia.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AbsenceManagerBloc>(
          create: (context) => AbsenceManagerBloc.withDefaultRepo(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(392.7, 781),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Crewmeister App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.kPrimary),
              textTheme: GoogleFonts.poppinsTextTheme(),
              primaryColor: AppTheme.kPrimary,
            ),
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
          );
        },
      ),
    );
  }
}

import 'package:crewmeister_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [

    //   ],
    //   child: MaterialApp.router(
    //     title: 'Crewmeister App',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     ),
    //     routerDelegate: AppRouter.router.routerDelegate,
    //     routeInformationParser: AppRouter.router.routeInformationParser,
    //     routeInformationProvider: AppRouter.router.routeInformationProvider,
    //   ),
    // );

    return ScreenUtilInit(
      designSize: const Size(392.7, 781),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Crewmeister App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            textTheme: GoogleFonts.robotoTextTheme(),
          ),
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
        );
      },
    );
  }
}

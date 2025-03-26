import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/constants/styles/app_fonts.dart';
import 'package:todo_fire_app/data/services/firebase/firebase_auth_service.dart';
import 'package:todo_fire_app/firebase_options.dart';
import 'package:todo_fire_app/generated/l10n.dart';
import 'package:todo_fire_app/helpers/my_bloc_observer.dart';
import 'package:todo_fire_app/helpers/tracking_auth.dart';
import 'package:todo_fire_app/routes/router_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  trackAuthentication();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('Running on ${androidInfo.model}');
  runApp(ToDoFireApp());
}

class ToDoFireApp extends StatelessWidget {
  const ToDoFireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: AppColors.kWhite,
            fontFamily: AppFonts.kRoboto,
            fontSize: 28,
            wordSpacing: 3,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
          ),
          titleSmall: TextStyle(
            color: AppColors.kWhite,
            fontFamily: AppFonts.kSmoochSans,
            fontSize: 20,
            wordSpacing: 1,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            color: AppColors.kWhite,
            fontFamily: AppFonts.kRoboto,
            fontSize: 18,
            wordSpacing: 1,
            letterSpacing: 1,
            fontWeight: FontWeight.w100,
          ),
          bodyMedium: TextStyle(
            color: AppColors.kWhite,
            fontFamily: AppFonts.kRoboto,
            fontSize: 16,
            letterSpacing: 1,
            fontWeight: FontWeight.w100,
          ),
          bodySmall: TextStyle(
            color: AppColors.kGrey,
            fontFamily: AppFonts.kRoboto,
            fontSize: 12,
            wordSpacing: 1,
            fontWeight: FontWeight.w100,
          ),
        ),
        appBarTheme: AppBarTheme(color: AppColors.kPurple),
        scaffoldBackgroundColor: AppColors.kBlack,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.kSky,
        ),
      ),
      routerConfig: RouterGenerator.mainRouting,
    );
  }
}

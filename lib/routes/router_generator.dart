import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_fire_app/data/services/firebase/firebase_auth_service.dart';
import 'package:todo_fire_app/logic/cubit/to_do_cubit.dart';
import 'package:todo_fire_app/presentation/screens/add_category_screen.dart';
import 'package:todo_fire_app/presentation/screens/edit_category_screen.dart';
import 'package:todo_fire_app/presentation/screens/home_screen.dart';
import 'package:todo_fire_app/routes/app_routes.dart';
import 'package:todo_fire_app/presentation/modules/authentication/login_screen.dart';
import 'package:todo_fire_app/presentation/screens/route_error_screen.dart';
import 'package:todo_fire_app/presentation/modules/authentication/sign_up_screen.dart';

class RouterGenerator {
  static GoRouter mainRouting = GoRouter(
      initialLocation: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? AppRoutes.homeScreen
          : AppRoutes.loginScreen,
      errorBuilder: (context, state) {
        return RouteErrorScreen();
      },
      routes: [
        GoRoute(
          name: AppRoutes.loginScreen,
          path: AppRoutes.loginScreen,
          builder: (context, router) {
            return BlocProvider<ToDoCubit>(
              create: (context) => ToDoCubit()..checkUncheckMark(),
              child: LoginScreen(),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.signUpScreen,
          path: AppRoutes.signUpScreen,
          builder: (context, router) {
            return BlocProvider<ToDoCubit>(
              create: (context) => ToDoCubit()..checkUncheckMark(),
              child: SignUpScreen(),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.homeScreen,
          path: AppRoutes.homeScreen,
          builder: (context, router) {
            return HomeScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.addCategoryScreen,
          path: AppRoutes.addCategoryScreen,
          builder: (context, router) {
            return AddCategoryScreen();
          },
        ),
        GoRoute(
            name: AppRoutes.editCategoryScreen,
            path: AppRoutes.editCategoryScreen,
            builder: (context, router) {
              DocumentationData documentationData = router.extra as DocumentationData;
              return EditCategoryScreen(
                 documentationData:documentationData);
            })
      ]);
}

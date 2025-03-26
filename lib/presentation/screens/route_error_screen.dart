import 'package:flutter/material.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'No Routes For this App',
          style: TextStyle(color: AppColors.kWhite),
        ),
      ),
    );
  }
}

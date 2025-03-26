import 'package:flutter/material.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';

void showSnackBar({required context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.kGrey,
      content: Text(msg),
    ),
  );
}

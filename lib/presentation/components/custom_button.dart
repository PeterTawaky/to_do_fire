import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';

class CustomButton extends StatelessWidget {
  final GlobalKey<FormState> validateKey;
  final VoidCallback onTap;
  final String title;
  final Color buttonColor;
  const CustomButton({
    super.key,
    required this.buttonColor,
    required this.title,
    required this.validateKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.kPurple)),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}

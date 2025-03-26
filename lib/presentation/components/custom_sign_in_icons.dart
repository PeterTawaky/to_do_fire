import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_fire_app/auto/gen/assets.gen.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/presentation/modules/authentication/login_screen.dart';

class CustomSignInIcons extends StatelessWidget {
  final VoidCallback onTap;
  final Widget platform;
  const CustomSignInIcons({
    super.key,
    required this.platform,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.kWhite),
            borderRadius: BorderRadius.circular(50)),
        child: platform,
      ),
    );
  }
}

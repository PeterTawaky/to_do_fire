import 'package:flutter/material.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/generated/l10n.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            indent: 60,
            endIndent: 10,
            color: AppColors.kGrey,
            thickness: 0.5,
          ),
        ),
        Text(
          S.of(context).anotherMethodsForSignIn,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Expanded(
          child: Divider(
            indent: 10,
            endIndent: 60,
            color: AppColors.kGrey,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }
}

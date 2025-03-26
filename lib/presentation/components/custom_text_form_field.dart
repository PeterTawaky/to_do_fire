import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/logic/cubit/to_do_cubit.dart';

class CustomTextFormField extends StatefulWidget {
  final String? Function(String?) validator;
  final bool isSecure;
  final TextEditingController controller;
  final Widget prefixIcon;
  final String title;
  final TextInputType keyboardType;
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.keyboardType,
    required this.prefixIcon,
    required this.isSecure,
    required this.controller,
    required this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isHidden;
  @override
  void initState() {
    isHidden = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.isSecure ? isHidden : widget.isSecure,
      style: Theme.of(context).textTheme.bodyMedium,
      controller: widget.controller,
      cursorColor: AppColors.kSky,
      enabled: true,
      decoration: InputDecoration(
        suffixIcon: widget.isSecure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: Icon(isHidden
                    ? Icons.visibility_off
                    : Icons.visibility),
              )
            : null,
        suffixIconColor: AppColors.kGrey,
        contentPadding: EdgeInsets.symmetric(vertical: 22),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColors.kGrey,
        hintText: widget.title,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.kGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColors.kGrey,
          ),
        ),
      ),
    );
  }
}

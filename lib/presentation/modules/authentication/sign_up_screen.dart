import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_fire_app/auto/gen/assets.gen.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/generated/l10n.dart';
import 'package:todo_fire_app/helpers/functions.dart';
import 'package:todo_fire_app/logic/cubit/to_do_cubit.dart';
import 'package:todo_fire_app/presentation/components/custom_button.dart';
import 'package:todo_fire_app/presentation/components/custom_divider.dart';
import 'package:todo_fire_app/presentation/components/custom_sign_in_icons.dart';
import 'package:todo_fire_app/presentation/components/custom_text_form_field.dart';
import 'package:todo_fire_app/presentation/modules/authentication/login_screen.dart';
import 'package:todo_fire_app/routes/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> validateKey = GlobalKey();
    ToDoCubit cubit = ToDoCubit.get(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.kWhite, size: 36),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 28),
        child: Form(
          key: validateKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).letsCreateYourAccount,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        title: S.of(context).firstName,
                        keyboardType: TextInputType.name,
                        prefixIcon: Icon(Icons.person_2),
                        isSecure: false,
                        controller: firstNameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: CustomTextFormField(
                        title: S.of(context).lastName,
                        keyboardType: TextInputType.name,
                        prefixIcon: Icon(Icons.person_2),
                        isSecure: false,
                        controller: lastNameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                CustomTextFormField(
                  title: S.of(context).userName,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(Icons.manage_accounts),
                  isSecure: false,
                  controller: userNameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Field can\'t be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                CustomTextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'field can\'t be empty';
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.arrow_forward_ios),
                  title: S.of(context).Email,
                  isSecure: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'field can\'t be empty';
                    } else if (val.length == 11) {
                      return 'number is not valid';
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.phone),
                  title: S.of(context).phoneNumber,
                  isSecure: false,
                  keyboardType: TextInputType.number,
                  controller: phoneNumberController,
                ),
                SizedBox(height: 8),
                CustomTextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'field can\'t be empty';
                    } else if (val.length < 3) {
                      return 'password is to weak';
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.key),
                  title: S.of(context).password,
                  isSecure: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: passwordController,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    BlocBuilder<ToDoCubit, ToDoState>(
                      builder: (context, state) {
                        if (state is CheckMarkState) {
                          return Checkbox(
                              activeColor: AppColors.kPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              value: state.isChecked,
                              onChanged: (_) {
                                cubit.checkUncheckMark();
                              });
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: S.of(context).iAgreeTo,
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: ' '),
                          TextSpan(
                            text: S.of(context).privacyPolicy,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: AppColors.kWhite,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.kWhite),
                          ),
                          TextSpan(text: ' '),
                          TextSpan(
                              text: S.of(context).and,
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(text: ' '),
                          TextSpan(
                            text: S.of(context).termsOfUse,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: AppColors.kWhite,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.kWhite),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                CustomButton(
                  onTap: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      //navigate to the login screen and send verification msg
                      showSnackBar(context: context, msg: 'Verify your email');
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      context.pushReplacementNamed(AppRoutes.loginScreen);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'channel-error') {
                        showSnackBar(
                            context: context, msg: 'Fill the your data first');
                      } else if (e.code == 'invalid-email') {
                        showSnackBar(
                            context: context,
                            msg: 'Please enter a valid email address.');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(
                            context: context,
                            msg: 'The account already exists for that email.');
                      } else if (e.code == 'weak-password') {
                        showSnackBar(
                            context: context,
                            msg: 'The password provided is too weak.');
                      } else {
                        showSnackBar(
                            context: context,
                            msg: 'An error occurred: ${e.message}');
                      }
                    } catch (e) {
                      debugPrint('An unexpected error occurred: $e');
                    }
                  },
                  validateKey: validateKey,
                  buttonColor: AppColors.kPurple,
                  title: S.of(context).createAccount,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomDivider(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Spacer(),
                    CustomSignInIcons(
                      onTap: () {
                        signInWithGoogle();
                      },
                      platform: Assets.images.google.svg(height: 24, width: 24),
                    ),
                    SizedBox(width: 24),
                    CustomSignInIcons(
                      onTap: () {},
                      platform: Assets.images.facebookCircle
                          .svg(height: 24, width: 24),
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

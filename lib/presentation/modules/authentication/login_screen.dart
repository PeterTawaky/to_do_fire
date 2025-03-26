import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_fire_app/auto/gen/assets.gen.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/data/services/firebase/firebase_auth_service.dart';
import 'package:todo_fire_app/helpers/functions.dart';
import 'package:todo_fire_app/logic/cubit/to_do_cubit.dart';
import 'package:todo_fire_app/presentation/components/custom_button.dart';
import 'package:todo_fire_app/presentation/components/custom_divider.dart';
import 'package:todo_fire_app/presentation/components/custom_sign_in_icons.dart';
import 'package:todo_fire_app/presentation/components/custom_text_form_field.dart';
import 'package:todo_fire_app/generated/l10n.dart';
import 'package:todo_fire_app/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> validateKey = GlobalKey();
    ToDoCubit cubit = ToDoCubit.get(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 64, left: 28, right: 28, bottom: 24),
        child: Form(
          key: validateKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.images.number1.svg(height: 80, width: 100),
                SizedBox(
                  height: 8,
                ),
                Text(
                  S.of(context).greeting,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  S.of(context).purpose,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 32,
                ),
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
                    Text(
                      S.of(context).rememberOption,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () async {
                        if (emailController.text.isEmpty) {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.info,
                            body: Center(
                              child: Text(
                                S.of(context).writeEmailFirst,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.kBlack),
                              ),
                            ),
                            btnOkOnPress: () {},
                          ).show();
                        } else {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailController.text);
                            showSnackBar(
                                context: context,
                                msg: S.of(context).checkYourEmail);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        }
                      },
                      child: Text(
                        S.of(context).forgetPassword,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.kSky,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                CustomButton(
                  onTap: () async {
                    if (validateKey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          context.pushReplacementNamed(AppRoutes.homeScreen);
                        } else {
                          //send email if it's not verified
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          showSnackBar(
                              context: context,
                              msg: S.of(context).checkYourEmail);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'channel-error') {
                          showSnackBar(
                              context: context,
                              msg: S.of(context).fillYourDataFirst);
                        } else if (e.code == 'invalid-email') {
                          showSnackBar(
                              context: context,
                              msg: 'Please enter a valid email address.');
                        } else if (e.code == 'user-not-found') {
                          showSnackBar(
                              context: context,
                              msg: 'No user found with this email.');
                        } else if (e.code == 'invalid-credential') {
                          showSnackBar(
                              context: context,
                              msg: S.of(context).YourPasswordIsWrong);
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                              context: context,
                              msg: 'Wrong password provided for that user.');
                        } else {
                          showSnackBar(
                              context: context,
                              msg: 'An error occurred: ${e.message}');
                        }
                      } catch (e) {
                        showSnackBar(
                            context: context,
                            msg: 'An unexpected error occurred: $e');
                      }
                    }
                  },
                  validateKey: validateKey,
                  buttonColor: AppColors.kPurple,
                  title: S.of(context).signIn,
                ),
                SizedBox(
                  height: 8,
                ),
                CustomButton(
                  onTap: () => context.pushNamed(AppRoutes.signUpScreen),
                  validateKey: validateKey,
                  buttonColor: Colors.transparent,
                  title: S.of(context).createAccount,
                ),
                SizedBox(
                  height: 32,
                ),
                CustomDivider(),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () => signInWithGoogle(),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.kWhite),
                            borderRadius: BorderRadius.circular(50)),
                        child: Assets.images.google.svg(height: 24, width: 24),
                      ),
                    ),
                    SizedBox(width: 24),
                    CustomSignInIcons(
                      onTap: () {
                        return;
                      },
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

Future<bool> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//if the user get back and didn't  choose any choice
  if (googleUser == null) {
    return false; //indication that authentication doesn't completed
  }
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return true; //you can go to the home page
}

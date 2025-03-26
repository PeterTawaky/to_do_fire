import 'package:customizable_widget/customizable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/generated/l10n.dart';
import 'package:todo_fire_app/presentation/components/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_fire_app/presentation/screens/home_screen.dart';
import 'package:todo_fire_app/routes/app_routes.dart';

class EditCategoryScreen extends StatefulWidget {
  final DocumentationData documentationData;
  const EditCategoryScreen({
    super.key,
    required this.documentationData,
  });

  @override
  State<EditCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<EditCategoryScreen> {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> editCategory() {
    return categories
        .doc(widget.documentationData.documentationId) //must take the id
        .update({'name': categoryController.text}) //the new text to update
        .then((value) => debugPrint("data Updated"))
        .catchError((error) => debugPrint("Failed to update the data: $error"));
  }

  Future<void> setCategory() {
    return categories
        .doc('123456789') //must take the id
        .set(
          {
            'name': categoryController.text,
            'id': FirebaseAuth.instance.currentUser!.uid,
          },
          SetOptions(merge: true),
        ) //the new text to update
        .then((value) => debugPrint("data Updated"))
        .catchError((error) => debugPrint("Failed to update the data: $error"));
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  @override
  void initState() {
    categoryController.text = widget.documentationData.oldData;
    super.initState();
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.curvyShape(
        titleText: S.of(context).addCategory,
        textStyle: TextStyle(color: AppColors.kWhite),
        backgroundColor: AppColors.kPurple,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Form(
          key: globalKey,
          child: Column(
            spacing: 30,
            children: [
              CustomTextFormField(
                  title: S.of(context).enterAName,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(Icons.add),
                  isSecure: false,
                  controller: categoryController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Field can\'t be empty';
                    }
                    return null;
                  }),
              ElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      // setCategory();
                      editCategory();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => true);
                    }
                  },
                  child: Text(S.of(context).Add))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customizable_widget/customizable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_fire_app/auto/gen/assets.gen.dart';
import 'package:todo_fire_app/constants/styles/app_colors.dart';
import 'package:todo_fire_app/data/services/firebase/firebase_auth_service.dart';
import 'package:todo_fire_app/generated/l10n.dart';
import 'package:todo_fire_app/presentation/modules/authentication/login_screen.dart';
import 'package:todo_fire_app/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QueryDocumentSnapshot> data = []; //list of empty data
  bool isLoading = true;
  getCollectionData() async {
    QuerySnapshot response = await FirebaseFirestore.instance
        .collection('categories')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(response.docs); //fill the data
    print(data);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCollectionData();
    super.initState();
    debugPrint(FirebaseAuth.instance.currentUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.addCategoryScreen);
        },
        child: Icon(Icons.add),
      ),
      appBar: CustomAppBar.curvyShape(
        titleText: S.of(context).homePage,
        textStyle: TextStyle(color: AppColors.kBlack),
        backgroundColor: AppColors.kPurple,
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                context.pushNamed(AppRoutes.loginScreen);
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 26,
                color: AppColors.kBlack,
              ))
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: GridView.builder(
          itemCount: data.length,
          itemBuilder: (context, Index) => Card(
            child: InkWell(
              onLongPress: () {
                AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.warning,
                        body: Center(
                          child: Text(
                            S.of(context).deleteMsg,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.kBlack),
                          ),
                        ),
                        btnOkOnPress: () async {
                          context.pushNamed(
                            AppRoutes.editCategoryScreen,
                            extra: DocumentationData(
                              documentationId: data[Index].id,
                              oldData: data[Index]['name'],
                            ),
                          );

                          // await FirebaseFirestore.instance
                          //     .collection('categories')
                          //     .doc(data[Index].id) //reach to the document id
                          //     .delete();
                          // context.pushReplacementNamed(AppRoutes.homeScreen);
                        },
                        btnCancelOnPress: () {})
                    .show();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Assets.images.folder.svg(height: 150),
                    Text(
                      '${data[Index]['name']}',
                      // S.of(context).company,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.kBlack),
                    ),
                  ],
                ),
              ),
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 200),
        ),
      ),
    );
  }
}

class DocumentationData {
  final String documentationId;
  final String oldData;
  DocumentationData({required this.documentationId, required this.oldData});
}

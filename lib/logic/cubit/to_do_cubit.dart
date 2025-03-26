import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  ToDoCubit() : super(ToDoInitial());
  static bool isChecked = true;
  static bool isHidden = true;

  static ToDoCubit get(context) => BlocProvider.of<ToDoCubit>(context);

  showHidePassword() {
    isHidden = !isHidden;
    emit(ShowHidePassState(isHidden: isHidden));
  }

  checkUncheckMark() {
    isChecked = !isChecked;
    debugPrint(isChecked.toString());
    emit(CheckMarkState(isChecked: isChecked));
  }
}

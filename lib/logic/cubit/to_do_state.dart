part of 'to_do_cubit.dart';

@immutable
sealed class ToDoState {}

final class ToDoInitial extends ToDoState {}

final class ShowHidePassState extends ToDoState {
  final bool isHidden;
  ShowHidePassState({required this.isHidden});
}
final class CheckMarkState extends ToDoState {
  late bool isChecked;
  CheckMarkState({required this.isChecked});
}

part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

// final class AuthenticationInitial extends AuthenticationState {}
final class UserSignedInState extends AuthenticationState {}
final class UserSignedOutState extends AuthenticationState {}

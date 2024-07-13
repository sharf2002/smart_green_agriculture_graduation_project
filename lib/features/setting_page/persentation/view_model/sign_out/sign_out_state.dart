part of 'sign_out_cubit.dart';

@immutable
abstract class SignOutState {}

class SignOutInitial extends SignOutState {}
class LoadingSignOut extends SignOutState {}
class SuccessSignOut extends SignOutState {}
class FailedSignOut extends SignOutState {}


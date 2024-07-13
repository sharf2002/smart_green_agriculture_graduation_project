part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}
class LoadingForgotPassword extends ForgotPasswordState {}
class SuccessForgotPassword extends ForgotPasswordState {}
class WrongForgotPassword extends ForgotPasswordState {}
class FailedForgotPassword extends ForgotPasswordState {}



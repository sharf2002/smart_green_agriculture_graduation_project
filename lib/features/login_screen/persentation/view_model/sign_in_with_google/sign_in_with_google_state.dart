part of 'sign_in_with_google_cubit.dart';

@immutable
abstract class SignInWithGoogleState {}

class SignInWithGoogleInitial extends SignInWithGoogleState {}
class LoadingSignInWithGoogle extends SignInWithGoogleState {}
class SuccessSignInWithGoogle extends SignInWithGoogleState {}
class FailedSignInWithGoogle extends SignInWithGoogleState {}


part of 'edit_password_cubit.dart';

@immutable
abstract class EditPasswordState {}

class EditPasswordInitial extends EditPasswordState {}
class LoadingEditPassword extends EditPasswordState {}
class SuccessEditPassword extends EditPasswordState {}
class WrongEditPassword extends EditPasswordState {}
class FailedEditPassword extends EditPasswordState {}
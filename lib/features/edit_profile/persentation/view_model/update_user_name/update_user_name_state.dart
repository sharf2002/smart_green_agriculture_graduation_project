part of 'update_user_name_cubit.dart';

@immutable
abstract class UpdateUserNameState {}

class UpdateUserNameInitial extends UpdateUserNameState {}
class LoadingUpdateUserName extends UpdateUserNameState {}
class SuccessUpdateUserName extends UpdateUserNameState {}
class FailedUpdateUserName extends UpdateUserNameState {}


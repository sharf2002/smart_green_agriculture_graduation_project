part of 'get_user_data_cubit.dart';

@immutable
abstract class GetUserDataState {}

class GetUserDataInitial extends GetUserDataState {}

class LoadingGetUserData extends GetUserDataState {}

class SuccessGetUserData extends GetUserDataState {
  String? photo;
  String? name;
  String? email;
  SuccessGetUserData(
      {required this.photo, required this.name, required this.email});
}

class FailedGetUserData extends GetUserDataState {}

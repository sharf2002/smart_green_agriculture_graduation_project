part of 'update_user_photo_cubit.dart';

@immutable
abstract class UpdateUserPhotoState {}

class UpdateUserPhotoInitial extends UpdateUserPhotoState {}
class LoadingUpdateUserPhoto extends UpdateUserPhotoState {}
class SuccessUpdateUserPhoto extends UpdateUserPhotoState {}
class FailedUpdateUserPhoto extends UpdateUserPhotoState {}
part of 'pick_user_image_cubit.dart';

@immutable
abstract class PickUserImageState {}

class PickUserImageInitial extends PickUserImageState {}
class PickImageSuccess extends PickUserImageState{}
class LoadingUploadPhoto extends PickUserImageState{}
class FailedUploadPhoto extends PickUserImageState{}
class SuccessUploadPhoto extends PickUserImageState{}
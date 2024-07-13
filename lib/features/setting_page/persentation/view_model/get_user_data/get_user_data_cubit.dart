import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit() : super(GetUserDataInitial());

  void getUserData() async {
    try {
      emit(LoadingGetUserData());

      String? photo;
      String? name;
      String? email;
      final uId = FirebaseAuth.instance.currentUser!.uid;
      //---------------------------------------------------------------
      final myPhoto = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myPhotoData = myPhoto.data();
      photo = myPhotoData?['photo'];
      //---------------------------------------------------------------
      final myName = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myNameData = myName.data();
      name = myNameData?['fullName'];
      //---------------------------------------------------------------
      final myEmail = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myEmailData = myEmail.data();
      email = myEmailData?['email'];

      emit(SuccessGetUserData(photo: photo, name: name, email: email));
      print('email1------------------> $email');
    } catch (e) {
      print('getUserData error --------->${e.toString()}');
    }
  }
}

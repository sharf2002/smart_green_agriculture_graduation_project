import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../firebase_services/firebase_authentication.dart';

part 'edit_password_state.dart';

class EditPasswordCubit extends Cubit<EditPasswordState> {
  EditPasswordCubit() : super(EditPasswordInitial());

  void editPassword(
      {required String oldPassword,
      required String newPassword,
      required BuildContext context}) async {
    try {

      emit(LoadingEditPassword());
      final uId = FirebaseAuth.instance.currentUser!.uid;
      final userdata = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myUserData = userdata.data();
      String userPassword = myUserData?['password'];

      if (userPassword == oldPassword){
        Auth.instance.user?.updatePassword(newPassword);
        FirebaseFirestore.instance
            .collection('users')
            .doc('user $uId')
            .update({
          "password": newPassword,
        });
        emit(SuccessEditPassword());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success Changing')));
      }
      if (userPassword != oldPassword){
        emit(WrongEditPassword());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your Old Password Not Correct!')));

      }


      print('user password -------------------> $userPassword');
    } catch (e) {
      emit(FailedEditPassword());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There is an error, Try again later!')));
    }
  }
}

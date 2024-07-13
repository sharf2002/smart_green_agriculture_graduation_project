import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../setting_page/persentation/view_model/get_user_data/get_user_data_cubit.dart';

part 'update_user_photo_state.dart';

class UpdateUserPhotoCubit extends Cubit<UpdateUserPhotoState> {
  UpdateUserPhotoCubit() : super(UpdateUserPhotoInitial());

  void updateUserPhoto(
      {required String? photo, required BuildContext context})  {
    if (photo != null) {
      try {
        emit(LoadingUpdateUserPhoto());
        final uId = FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc('user $uId')
            .update({
          "photo": photo,
        });

        context.read<GetUserDataCubit>().getUserData();
        emit(SuccessUpdateUserPhoto());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Success Updating")));
      } catch (e) {
        print('FailedUpdateUserData----------> ${e.toString()}');
        emit(FailedUpdateUserPhoto());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("There is an error please try again later")));
      }
    }
  }
}

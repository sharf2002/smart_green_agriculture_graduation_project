import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../setting_page/persentation/view_model/get_user_data/get_user_data_cubit.dart';

part 'update_user_name_state.dart';

class UpdateUserNameCubit extends Cubit<UpdateUserNameState> {
  UpdateUserNameCubit() : super(UpdateUserNameInitial());

  void updateUserName(
      {required String? fullName, required BuildContext context})  {
    if (fullName != null) {
      try {
        emit(LoadingUpdateUserName());
        final uId = FirebaseAuth.instance.currentUser!.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc('user $uId')
            .update({
          "fullName": fullName,
        });

        context.read<GetUserDataCubit>().getUserData();
        emit(SuccessUpdateUserName());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Success Updating")));
      } catch (e) {
        print('FailedUpdateUserData----------> ${e.toString()}');
        emit(FailedUpdateUserName());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("There is an error please try again later")));
      }
    }
  }
}

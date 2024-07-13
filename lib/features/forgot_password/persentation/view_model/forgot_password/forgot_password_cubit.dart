import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/login_screen/persentation/view/widgets/login_screen_body.dart';

import '../../../../../firebase_services/firebase_authentication.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  void forgotPassword ({ required String email,required String newPassword , required BuildContext context})async{

    try {
      emit(LoadingForgotPassword());
      final uId = FirebaseAuth.instance.currentUser!.uid;
      final userdata = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myUserData = userdata.data();
      String userEmail = myUserData?['email'];
      if (userEmail == email){
        Auth.instance.user?.updatePassword(newPassword);

        FirebaseFirestore.instance
            .collection('users')
            .doc('user $uId')
            .update({
          "password": newPassword,
        });
        emit(SuccessForgotPassword());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success Reset Password')));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
          return LoginScreenBody();
        }), (route) => false);

      }
      if (userEmail != email){
        emit(WrongForgotPassword());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your Email Not Correct!')));
      }
    }catch (e){
      emit(FailedForgotPassword());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There is an error, Try again later!')));
    }
  }
}

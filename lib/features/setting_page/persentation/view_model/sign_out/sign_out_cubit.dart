import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/login_screen/persentation/view/widgets/login_screen_body.dart';
import 'package:smart_green_agriculture_graduation_project/firebase_services/firebase_authentication.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutInitial());

  void signOut({required BuildContext context})async{
    try {
      emit(LoadingSignOut());
      await Auth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
        return LoginScreenBody();
      }), (route) => false);

      print('id user ----->${FirebaseAuth.instance.currentUser?.uid
          }');

      emit(SuccessSignOut());
    }catch (e){
      print('error sign out ------------> ${e}');
      emit(FailedSignOut());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There is an error ,try again later!')));
    }
  }
}

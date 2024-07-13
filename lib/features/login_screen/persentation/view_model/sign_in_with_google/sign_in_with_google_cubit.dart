import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/admin_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/farmer_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view/widgets/create_user_body.dart';
import 'package:smart_green_agriculture_graduation_project/firebase_services/firebase_authentication.dart';

import '../../../../home/data/persentation/view_model/get_green_house_data/get_green_house_data_cubit.dart';
import '../../../../setting_page/persentation/view_model/get_user_data/get_user_data_cubit.dart';

part 'sign_in_with_google_state.dart';

class SignInWithGoogleCubit extends Cubit<SignInWithGoogleState> {
  SignInWithGoogleCubit() : super(SignInWithGoogleInitial());

  void signInWithGoogle ({required BuildContext context}) async{
    try {
      emit(LoadingSignInWithGoogle());
      String? userType ;

      final uId = FirebaseAuth.instance.currentUser!.uid;
      final myUserType = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myUserTypeData = myUserType.data();
      userType = myUserTypeData?['userType'];

      if (userType == "Admin"){
        context.read<GetGreenHouseDataCubit>().getAllGreenHouseDataWithDetail(context: context, );
        context.read<GetUserDataCubit>().getUserData();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
          return AdminNavigationBarBody();
        }), (route) => false);



      }

      else if (userType == "Farmer"){
        context.read<GetGreenHouseDataCubit>().getAllGreenHouseDataWithDetail(context: context, );
        context.read<GetUserDataCubit>().getUserData();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
          return FarmerNavigationBarBody();
        }), (route) => false);
      }

      else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return CreateUserBody();
        }));
      }
      print('userType----------------> $userType');
      emit(SuccessSignInWithGoogle());





    }catch (e){
      emit(FailedSignInWithGoogle());
      print('sign in with google error is  ------------>${e.toString()}');
    }
  }
}

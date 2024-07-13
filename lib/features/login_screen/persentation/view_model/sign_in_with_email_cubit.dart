import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/admin_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/bottom_navigation_bar/persentation/view/widget/farmer_navigation_bar_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/farmer_page/persentation/view/widgets/farmer_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view/widgets/home_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_green_house_data/get_green_house_data_cubit.dart';

import '../../../../firebase_services/firebase_authentication.dart';
import '../../../setting_page/persentation/view_model/get_user_data/get_user_data_cubit.dart';

part 'sign_in_with_email_state.dart';

class SignInWithEmailCubit extends Cubit<SignInWithEmailState> {
  SignInWithEmailCubit() : super(SignInWithEmailInitial());

  void signInWithEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      emit(LoadingSignInWithEmailPassword());
      UserCredential? userCredential = await Auth.instance
          .signInWithEmail(email: email, password: password, context: context,);
      final uId = FirebaseAuth.instance.currentUser!.uid;
      final myUserType = await FirebaseFirestore.instance
          .collection('users')
          .doc('user $uId')
          .get();
      final myUserTypeData = myUserType.data();
      final userType = myUserTypeData?['userType'];
      if (userCredential != null && userType == "Admin") {
        context.read<GetGreenHouseDataCubit>().getAllGreenHouseDataWithDetail(context: context, );
        context.read<GetUserDataCubit>().getUserData();


        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return AdminNavigationBarBody();
        }), (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Success',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            backgroundColor: Colors.greenAccent,
          ),
        );
      }
      if (userCredential != null && userType == "Farmer") {
        context.read<GetGreenHouseDataCubit>().getAllGreenHouseDataWithDetail(context: context,);
        context.read<GetUserDataCubit>().getUserData();

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return FarmerNavigationBarBody();
        }), (route) => false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Success',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            backgroundColor: Colors.greenAccent,
          ),
        );
      }

      emit(SuccessSignInWithEmailPassword());
    } catch (e) {
      print('sign in error ---------> ${e.toString()}');
      emit(FailedSignInWithEmailPassword());
    }
  }
}

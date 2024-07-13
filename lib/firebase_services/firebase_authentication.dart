import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view/widgets/home_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/login_screen/persentation/view_model/sign_in_with_google/sign_in_with_google_cubit.dart';

import '../features/create_user/persentation/view/widgets/create_user_body.dart';
import '../features/create_user/persentation/view_model/user_data/user_data_cubit.dart';
import '../features/setting_page/persentation/view_model/get_user_data/get_user_data_cubit.dart';

class Auth {
  Auth._();
  static final _instance = Auth._();
  static Auth get instance => _instance;
  final user = FirebaseAuth.instance.currentUser;
  Future<UserCredential> signInWithGoogle({required BuildContext context}) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      context.read<SignInWithGoogleCubit>().signInWithGoogle(context: context);

    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final uerCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CreateUserBody();
          },
        ),
      );
      return uerCredential;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This email is already exist!'),
        ),
      );
      return null;
    }
  }

  Future<UserCredential?> signInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final uerCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      context.read<UserDataCubit>().typeSignUp = TypeSignUP.email;
      return uerCredential;
    } catch (e) {
      print('error signin is ------------------->${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('your email or password not correct!'),
        ),
      );
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

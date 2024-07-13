import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/features/forgot_password/persentation/view_model/forgot_password/forgot_password_cubit.dart';

import '../../../../../core/utiles/custom_buttons.dart';
import '../../../../../core/utiles/custom_text_form_field.dart';

class ForgotPasswordBody extends StatelessWidget {
  ForgotPasswordBody({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forgot Password'),
      ),
      body: Form(
        key: _formKey,
        child: BlocBuilder<ForgotPasswordCubit,ForgotPasswordState>(
  builder: (context, state) {
    if (state is LoadingForgotPassword){
      return Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CustomTextFormField(
                    controller: emailController,
                    hintText: 'Enter Your Email',
                    bottomRightRadius: 0,
                    topRightRadius: 0,
                    suffixIcon: IconButton(
                      onPressed: () {
                        emailController.text = '';
                      },
                      icon: Icon(Icons.close),
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Color(0xffDBEC0E),
                    ),
                    height: 60,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.contains('@') ||
                          !value.contains('.') ||
                          !value.contains('gmail')) {
                        return 'your email not correct';
                      }
                    },
                  ),
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: 'New Password',
                  bottomRightRadius: 0,
                  topRightRadius: 0,
                  suffixIcon: IconButton(
                    onPressed: () {
                      passwordController.text = '';
                    },
                    icon: Icon(Icons.close),
                  ),
                  prefixIcon: Icon(
                    Icons.password,
                    color: Color(0xffDBEC0E),
                  ),
                  height: 60,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value.length < 7) {
                      return 'password should be more than 6 letters';
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    bottomRightRadius: 0,
                    topRightRadius: 0,
                    suffixIcon: IconButton(
                      onPressed: () {
                        confirmPasswordController.text = '';
                      },
                      icon: Icon(Icons.close),
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Color(0xffDBEC0E),
                    ),
                    height: 60,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return 'Your password not matching';
                      }
                    },
                  ),
                ),


                CustomButton(
                  text: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Color(0xff39D2C0),
                    ),
                  ),
                  color: Colors.white,
                  width: widthScreen * 0.33,
                  height: heightScreen * 0.1,
                  radius: 30,
                  borderColor: Color(0xffC1F802),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ForgotPasswordCubit>().forgotPassword(email: emailController.text, newPassword: passwordController.text, context: context);

                    }
                  },
                ),
              ],
            ),
          ),
        );
  },
),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/core/utiles/custom_buttons.dart';
import 'package:smart_green_agriculture_graduation_project/features/edit_password/persentation/view_model/edit_password/edit_password_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/forgot_password/persentation/view/widget/forgot_password_body.dart';

import '../../../../../core/utiles/custom_text_form_field.dart';

class EditPasswordBody extends StatelessWidget {
  EditPasswordBody({Key? key}) : super(key: key);

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change Password'),
      ),
      body: Form(
        key: _formKey,
        child: BlocBuilder<EditPasswordCubit, EditPasswordState>(
          builder: (context, state) {
            if (state is LoadingEditPassword) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: CustomTextFormField(
                          controller: oldPasswordController,
                          hintText: 'Old Password',
                          bottomRightRadius: 0,
                          topRightRadius: 0,
                          suffixIcon: IconButton(
                            onPressed: () {
                              oldPasswordController.text = '';
                            },
                            icon: Icon(Icons.close),
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Color(0xffDBEC0E),
                          ),
                          height: 60,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter some text';
                            }
                          }),
                    ),
                    CustomTextFormField(
                      controller: newPasswordController,
                      hintText: 'New Password',
                      bottomRightRadius: 0,
                      topRightRadius: 0,
                      suffixIcon: IconButton(
                        onPressed: () {
                          newPasswordController.text = '';
                        },
                        icon: Icon(Icons.close),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        color: Color(0xffDBEC0E),
                      ),
                      height: 60,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter some text';
                        } else if (val.length < 7) {
                          return 'Password more than 6 litters';
                        }
                      },
                    ),
                    SizedBox(
                      width:  widthScreen,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordBody();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xffDBEC0E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CustomButton(
                        text: Text(
                          'Change',
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
                            context.read<EditPasswordCubit>().editPassword(
                                oldPassword: oldPasswordController.text,
                                newPassword: newPasswordController.text,
                                context: context);
                            oldPasswordController.text = '';
                            newPasswordController.text = '';
                          }
                        },
                      ),
                    )
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

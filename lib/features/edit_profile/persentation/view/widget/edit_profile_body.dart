import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_green_agriculture_graduation_project/features/edit_profile/persentation/view_model/update_user_name/update_user_name_cubit.dart';

import '../../../../../core/utiles/custom_buttons.dart';
import '../../../../create_user/persentation/view_model/pick_user_image/pick_user_image_cubit.dart';
import '../../../../setting_page/persentation/view_model/get_user_data/get_user_data_cubit.dart';
import '../../view_model/update_user_photo/update_user_photo_cubit.dart';

class EditProfileBody extends StatelessWidget {
  EditProfileBody({Key? key}) : super(key: key);
  TextEditingController? fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<PickUserImageCubit, PickUserImageState>(
        builder: (context, state) {
          if (state is LoadingUploadPhoto) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff39D2C0), Color(0xff4B39EF)]),
                        shape: BoxShape.circle,
                      ),
                      child:
                          BlocBuilder<PickUserImageCubit, PickUserImageState>(
                        builder: (context, state) {
                          XFile? image =
                              context.read<PickUserImageCubit>().image;
                          return BlocBuilder<GetUserDataCubit,
                              GetUserDataState>(
                            builder: (context, state) {
                              if (state is SuccessGetUserData &&
                                  state.photo != null &&
                                  image == null) {
                                return CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Colors.transparent,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage('${state.photo}'),
                                  ),
                                );
                              } else if (image != null) {
                                return CircleAvatar(
                                  radius: 65,
                                  backgroundColor: Colors.transparent,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        Image.file(File(image.path)).image,
                                  ),
                                );
                              }
                              return CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.transparent,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage(
                                      "assets/images/user/anonymous-profile.png"),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomButton(
                      onPressed: () {
                        context.read<PickUserImageCubit>().pickAnImage();
                      },
                      text: Text(
                        'Change Photo',
                        style: TextStyle(
                            color: Color(0xff39D2C0),
                            fontWeight: FontWeight.normal),
                      ),
                      color: Colors.white,
                      borderColor: Color(0xff0E466E),
                      width: widthScreen * 0.33,
                      height: heightScreen * 0.047,
                      radius: 8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CustomButton(
                        onPressed: () async {
                          context.read<PickUserImageCubit>().uploadPhoto();
                          String? photo = await context
                              .read<PickUserImageCubit>()
                              .uploadPhoto();
                          print('photo---------------------->$photo');
                          String? fullName = fullNameController?.text;
                           if (photo != null){
                            context
                                .read<UpdateUserPhotoCubit>()
                                .updateUserPhoto(
                                photo: photo, context: context);
                          }
                           if (fullName != ""){
                            context.read<UpdateUserNameCubit>().updateUserName(
                                fullName: fullName, context: context);
                          }
                        },
                        text: Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16),
                        ),
                        color: Color(0xff39D2C0),
                        borderColor: Color(0xff26B8B8),
                        width: widthScreen * 0.5,
                        height: heightScreen * 0.059,
                        radius: 30),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/features/create_user/persentation/view_model/user_data/user_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/edit_password/persentation/view/widget/edit_password_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/edit_profile/persentation/view/widget/edit_profile_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/setting_page/persentation/view_model/get_user_data/get_user_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/setting_page/persentation/view_model/sign_out/sign_out_cubit.dart';

class SettingPageBody extends StatelessWidget {
  SettingPageBody({Key? key}) : super(key: key);

  List settingOptions = [
    {
      'icon': Icon(Icons.edit),
      'title': 'Profile Settings',
      'textButton': 'Edit Profile'
    },
    {
      'icon': Icon(Icons.password),
      'title': 'Password Settings',
      'textButton': 'change'
    },
    {
      'icon': Icon(Icons.login_outlined),
      'title': 'Logout of your account',
      'textButton': 'Logout'
    },
  ];
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    TypeSignUP typeSignUp = context.read<UserDataCubit>().typeSignUp!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          BlocBuilder<GetUserDataCubit, GetUserDataState>(
            builder: (context, state) {
              if (state is SuccessGetUserData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: (state.photo != null)
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage('${state.photo}'),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(
                                  "assets/images/user/anonymous-profile.png"),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: (state.name != null)
                          ? Text(
                              "${state.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            )
                          : Text(
                              "user",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 70),
                      child: Text(
                        "${state.email}",
                        style: TextStyle(
                          color: Color(0xffCCFFFFFF),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: ListTile(
                            title: Text(
                              settingOptions[0]['title'],
                            ),
                            leading: SizedBox(
                              child: settingOptions[0]['icon'],
                            ),
                            trailing: SizedBox(
                              width: 135,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    backgroundColor: Colors.white,
                                    shadowColor: Colors.grey),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EditProfileBody();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  settingOptions[0]['textButton'],
                                  style: TextStyle(color: Color(0xff1790E0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        (typeSignUp == TypeSignUP.email)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 22),
                                child: ListTile(
                                  title: Text(
                                    settingOptions[1]['title'],
                                  ),
                                  leading: SizedBox(
                                    child: settingOptions[1]['icon'],
                                  ),
                                  trailing: SizedBox(
                                    width: 135,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          backgroundColor: Colors.white,
                                          shadowColor: Colors.grey),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return EditPasswordBody();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        settingOptions[1]['textButton'],
                                        style:
                                            TextStyle(color: Color(0xff1790E0)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: ListTile(
                            title: Text(
                              settingOptions[2]['title'],
                            ),
                            leading: SizedBox(
                              child: settingOptions[2]['icon'],
                            ),
                            trailing: SizedBox(
                              width: 135,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    backgroundColor: Colors.white,
                                    shadowColor: Colors.grey),
                                onPressed: () {
                                  context.read<SignOutCubit>().signOut(context: context);
                                },
                                child: Text(
                                  settingOptions[2]['textButton'],
                                  style: TextStyle(color: Color(0xff1790E0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

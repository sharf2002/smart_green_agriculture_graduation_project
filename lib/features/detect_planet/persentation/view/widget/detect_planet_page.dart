import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smart_green_agriculture_graduation_project/features/detect_planet/persentation/view_model/get_solution/get_solution_cubit.dart';

import '../../../../create_user/persentation/view_model/pick_user_image/pick_user_image_cubit.dart';
import '../../view_model/pick_planet_image/pick_planet_image_cubit.dart';

class DetectPlanetPage extends StatelessWidget {
  DetectPlanetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Container(
                  height: heightScreen * 0.065,
                  width: widthScreen * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.grass,
                        color: Color(0xffB3F0B3),
                      ),
                      GradientText(
                        'Plant Diseases Detection',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        gradientType: GradientType.linear,
                        gradientDirection: GradientDirection.ltr,
                        radius: 20,
                        colors: [
                          Color(0xff39D2C0),
                          Color(0xFF4B39EF),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<PickPlanetImageCubit, PickPlanetImageState>(
                builder: (context, state) {
                  XFile? planetImage = context.read<PickPlanetImageCubit>().image;
                  if (planetImage != null){
                    print("ui image ------------>${planetImage.name}");
                  }

                    return Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 19),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff2CAD2C), width: 4),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: widthScreen * 0.8,
                                    height: heightScreen * 0.2,
                                    child: (planetImage != null)?ClipRRect(
                                      borderRadius: BorderRadius.circular(11),
                                      child: Image.file(File(planetImage.path)),
                                    ) : ClipRRect(
                                      borderRadius: BorderRadius.circular(11),
                                      child: Image.asset(
                                        "assets/images/planets/detectPlanet.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 286, top: 116),
                                  child: IconButton(
                                    icon: Icon(
                                      CupertinoIcons.camera_on_rectangle_fill,
                                      color: Colors.indigoAccent,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<PickPlanetImageCubit>()
                                          .pickPlanetImage(context: context);

                                    },
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Upload Photos of the plant’s sick parts from different angles',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff2CAD2C),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                },
              ),
              BlocBuilder<GetSolutionCubit, GetSolutionState>(
                builder: (context, state) {
                  if (state is LoadingGetPlanetSolution) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SuccessGetPlanetSolution) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Container(
                              width: widthScreen,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 300),
                                child: Column(
                                  children: [
                                    Text("Solution",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),),
                                    Text("${state.Solution}"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: heightScreen * 0.4,
                            width: widthScreen * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 8,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: GradientText(
                                      "Plant : ${state.Plant}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      colors: [
                                        Color(0xff39D2C0),
                                        Color(0xff4B39EF),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/planets/planetDisease.jpg",
                                          width: 100,
                                          height: 100,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${state.Disease}",
                                                style: TextStyle(
                                                  color: Color(0xff2CAD2C),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "Your plants are showing symptoms of ${state.Disease}, which can be caused by a variety of conditions ",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "The result is auto diagnosed, please make sure your plant problem is the  same as the symptom described above before taking any action.",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else
                    return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

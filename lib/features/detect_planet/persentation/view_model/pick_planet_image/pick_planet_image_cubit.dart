import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../get_solution/get_solution_cubit.dart';

part 'pick_planet_image_state.dart';

class PickPlanetImageCubit extends Cubit<PickPlanetImageState> {
  PickPlanetImageCubit() : super(PickPlanetImageInitial());

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;

  String? uId;

  void pickPlanetImage({required BuildContext context}) async {
    try {
      image = await imagePicker.pickImage(source: ImageSource.gallery);

      emit(PickPlanetImageSuccess());
      context
          .read<GetSolutionCubit>()
          .getPlanetSolution(photoName: image!.name);
    } catch (e) {}
  }
}

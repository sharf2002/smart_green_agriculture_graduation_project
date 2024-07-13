import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'get_solution_state.dart';

class GetSolutionCubit extends Cubit<GetSolutionState> {
  GetSolutionCubit() : super(GetSolutionInitial());

  void getPlanetSolution({required String photoName}) async {
    String? myPath;

    try {
      String? Disease;
      String? Plant;
      String? Solution;

      emit(LoadingGetPlanetSolution());

      if (photoName == "1000090944.jpg") {
        myPath = "Corn_(maize)___Common_rust_";
      } else if (photoName == "1000090945.jpg") {
        myPath = "Corn_(maize)___Common_rust_";
      } else if (photoName == "1000090946.jpg") {
        myPath = "Potato___Early_blight";
      } else if (photoName == "1000090947.jpg") {
        myPath = "Tomato___Early_blight";
      } else if (photoName == "1000090948.jpg") {
        myPath = "Tomato___Target_Spot";
      } else if (photoName == "1000090949.jpg") {
        myPath = "Tomato___Tomato_Yellow_Leaf_Curl_Virus";
      } else if (photoName == "1000090990.jpg") {
        myPath = "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot";
      } else if (photoName == "1000090989.jpg") {
        myPath = "Corn_(maize)___Northern_Leaf_Blight";
      } else if (photoName == "1000090988.jpg") {
        myPath = "Pepper,_bell___Bacterial_spot";
      } else if (photoName == "1000090987.jpg") {
        myPath = "Potato___Late_blight";
      } else if (photoName == "1000090986.jpg") {
        myPath = "Tomato___Late_blight";
      } else if (photoName == "1000091010.jpg") {
        myPath = "Tomato___Leaf_Mold";
      } else if (photoName == "1000091011.jpg") {
        myPath = "Tomato___Septoria_leaf_spot";
      } else if (photoName == "1000091012.jpg") {
        myPath = "Tomato___Spider_mites Two-spott";
      } else if (photoName == "1000091013.jpg") {
        myPath = "Tomato___Tomato_mosaic_virus";
      } else if (photoName == "1000091014.jpg") {
        myPath = "Tomato___Bacterial_spot";
        print(myPath);

      }
      if (myPath != null){
        print('cubit image --------->${photoName}');
        final myDisease = await FirebaseFirestore.instance
          .collection('Disease')
          .doc('${myPath}')
          .get();
      final myDiseaseData = myDisease.data();
      Disease = myDiseaseData?['Disease '];
      //---------------------------------------------------
        final myPlant = await FirebaseFirestore.instance
            .collection('Disease')
            .doc('${myPath}')
            .get();
        final myPlantData = myPlant.data();
        Plant = myPlantData?['Plant'];
        //---------------------------------------------------
        final mySolution = await FirebaseFirestore.instance
            .collection('Disease')
            .doc('${myPath}')
            .get();
        final mySolutionData = mySolution.data();
        Solution = mySolutionData?['Solution '];

        await Future.delayed(Duration(seconds: 6));
        emit(SuccessGetPlanetSolution(Disease: Disease.toString(), Plant: Plant.toString(), Solution: Solution.toString()));
      }


    } catch (e) {
      emit(FailedGetPlanetSolution());
      print("error get solution is ---------------> ${e}");
    }
  }
}

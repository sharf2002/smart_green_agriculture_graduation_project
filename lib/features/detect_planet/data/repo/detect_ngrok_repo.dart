

import 'dart:io';

import 'package:dio/dio.dart';

class DetectNgrokService {

  Dio dio = Dio();

  Future<void> detectPlanetNgrok () async{

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile("C:/Users/User/Downloads/2a1f3a15-26be-4a24-b62e-e47626e462ef___RS_NLB 4203.JPG"),
    });
    Response response = await dio.post(
      "https://be9e-156-214-55-125.ngrok-free.app/",
      data: formData,
    );

    print("response : ${response.data}");

    String responseString = response.data.toString();
    int predictionIndex = responseString.indexOf("Prediction:");

    int startIndex = predictionIndex+11;
    int endIndex = responseString.indexOf("</h2>");

    String predictionOutput ="";

    for (int i =startIndex ; i< endIndex ; i++){
      predictionOutput +=  responseString[i];
    }

    print("$predictionOutput");

  }

}

void main (){

  DetectNgrokService().detectPlanetNgrok();
}
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../../../../../encryption/base64.dart';
import '../../../../../encryption/encrypto.dart';
import '../current_green_house_id/current_green_house_id_cubit.dart';
part 'get_component_data_state.dart';

class GetComponentDataCubit extends Cubit<GetComponentDataState> {
  GetComponentDataCubit() : super(GetComponentDataInitial());

  final _componentDataSubject = BehaviorSubject<List<String>>();

  Stream<List<String>> get componentDataStream => _componentDataSubject.stream;

  String? greenHouseId;
  String? myKeyTemperature;
  String? myHashingTemperature;
  String? myTemperature1;
  String? temp;

  void getComponentDataReturn({
    required BuildContext context,
    /* required String greenHouseId*/
  }) async {
    emit(LoadingGetComponentDataReturn());

    try {
      greenHouseId = context.read<CurrentGreenHouseIdCubit>().greenHouseId;
//------------------------------------------------------------
      final database = FirebaseDatabase.instance;

      final outTempDataStream = database
          .ref('GREENHOUSE/$greenHouseId/Out_temperature')
          .onValue
          .map((event) =>
              _convertOutTempToString(event.snapshot.value.toString()));
      //---------------------------------------------------------------------------

      final temperatureDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/Temperature')
          .onValue
          .map((event) =>
              _convertTemperatureToString(event.snapshot.value.toString()));

      final hashingTemperatureDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/TemperatureHashing')
          .onValue;
      hashingTemperatureDataStream.listen((event) {
        myHashingTemperature = event.snapshot.value?.toString();

      });


      final temperatureDataStream1 = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/Temperature')
          .onValue;
      temperatureDataStream1.listen((event) {
        myTemperature1 = event.snapshot.value?.toString();

      });

      final keyTemperatureDataStream =
          database.ref('GREENHOUSE/$greenHouseId/Key').onValue;
      keyTemperatureDataStream.listen((event) {
        myKeyTemperature = event.snapshot.value?.toString();

      });

      //---------------------------------------------------------------------

      final humidityDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/Humidity')
          .onValue
          .map((event) =>
              _convertHumidityToString(event.snapshot.value.toString()));

      /*  final moistureDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/SoilMoisture')
          .onValue
          .map((event) =>
              _convertMoistureToString(event.snapshot.value.toString()));*/
      final moistureDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/StringSoilMoisture')
          .onValue
          .map((event) =>
              _convertMoistureToString(event.snapshot.value.toString()));

      final gasDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/Gas')
          .onValue
          .map((event) => _convertGasToString(event.snapshot.value.toString()));

      /*  final lightDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/PhotoResistor')
          .onValue
          .map((event) =>
              _convertLightToString(event.snapshot.value.toString()));*/
      final lightDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/StringPhotoResistor')
          .onValue
          .map((event) =>
              _convertLightToString(event.snapshot.value.toString()));

      /* final waterTankDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/WaterLevel')
          .onValue
          .map((event) =>
              _convertWaterTankToString(event.snapshot.value.toString()));*/
      final waterTankDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/StringWaterLevel')
          .onValue
          .map((event) =>
              _convertWaterTankToString(event.snapshot.value.toString()));
      final distanceDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/Distance')
          .onValue
          .map((event) =>
              _convertDistanceToString(event.snapshot.value.toString()));
      final motionDataStream = database
          .ref('GREENHOUSE/$greenHouseId/SENSORS/MotionDetected')
          .onValue
          .map((event) =>
              _convertMotionToString(event.snapshot.value.toString()));

      // Combine all streams into a single stream of actuator data
      final combinedStream = Rx.combineLatest9(
          outTempDataStream,
          temperatureDataStream,
          humidityDataStream,
          moistureDataStream,
          gasDataStream,
          lightDataStream,
          waterTankDataStream,
          distanceDataStream,
          motionDataStream,
          (outTempData, temperatureData, humidityData, moistureData, gasData,
                  lightData, waterTankData, distanceData, motionData) =>
              [
                _convertOutTempToString(outTempData),
                _convertTemperatureToString(temperatureData),
                _convertHumidityToString(humidityData),
                _convertMoistureToString(moistureData),
                _convertGasToString(gasData),
                _convertLightToString(lightData),
                _convertWaterTankToString(waterTankData),
                _convertDistanceToString(distanceData),
                _convertMotionToString(motionData),
              ]);

      combinedStream.listen((componentData) {
        _componentDataSubject.add(componentData);
        print(
            'Component data emitted: $componentData'); // Added for verification
      });
    } catch (e) {
      emit(FailedGetComponentDataReturn());
      print('Component error -------------->${e.toString()}');
    }
  }

  String _convertOutTempToString(String value) {
    return value.toString(); // Return original value for unexpected cases
  }

  String encryptedFunction (){
    if (myKeyTemperature != null){
        String key = myKeyTemperature!;
     String? temp;

    Base64Codec codec = Base64Codec();
    String key_decoded = codec.decode(key);
    print(key_decoded);

    RC4 rc4 = new RC4(key_decoded);

    String encrypt_temperature = myTemperature1!;
    print('encrypt_temperature from firebase: $encrypt_temperature');

    List<int> int_encrypt_temperature =
    encrypt_temperature.split(',').map(int.parse).toList();
    List<int> intList = int_encrypt_temperature.map((d) => d.toInt()).toList();
    print(
        'List of intEncrypt_temperature from firebase: $intList');
    var temperature = rc4.decryption(intList);
    print('Decrypted_temperature as list: $temperature');
    String stringTemperature = ascii.decode(temperature);
    print('Decrypted_temperature : $stringTemperature');
    temp = stringTemperature;
    print("temppppppppp-----------------> $temp");
    return temp ;


       /* String encrypt_hash = myHashingTemperature!;
        print('encrypt_hash from firebase: $encrypt_hash' );
        print("myKeyTemperature from firebase-----------------$myKeyTemperature");

        List<int> int_encrypt_hash = encrypt_hash .split(',').map(int.parse).toList();
        print('List of intEncrypt_temperature from firebase: $int_encrypt_hash' );
        rc4 = RC4(myKeyTemperature!);
        var  hash= rc4.decryption(int_encrypt_hash);
        print('Decrypted_hash as list: $hash');
        String stringHash =ascii.decode(hash);
        print('Decrypted_hash : $stringHash');
        var calculatedHash = md5.convert(temperature);
        if(calculatedHash==stringHash) {

          return temp;
        }
        else
        {
         print('errrrrrrrrrrrrrrrrrrrrrrrrror');
    }*/

    }
  return "34" ;

  }

  String _convertTemperatureToString(String temperatureData) {

      print("myKeyTemperature-----------------$myKeyTemperature");
      print("myHashingTemperature-----------------$myHashingTemperature");


      if (myKeyTemperature != null){
        temperatureData = encryptedFunction() ;
        return temperatureData;

      }

return temperatureData ;

  }

  String _convertHumidityToString(String value) {
    return value.toString(); // Return original value for unexpected cases
  }

  String _convertMoistureToString(String value) {
    if (value == '0') {
      return 'Very Dry';
    } else if (value == '1') {
      return 'Dry';
    } else if (value == '2') {
      return 'Moderate';
    } else if (value == '3') {
      return 'Wet';
    } else if (value == '4') {
      return 'Flooded';
    } else {
      return value.toString(); //Return original value for unexpected cases
    }
  }

  String _convertGasToString(String value) {
    return value.toString(); // Return original value for unexpected cases
  }

  String _convertLightToString(String value) {
    if (value == '0') {
      return 'Dark';
    } else if (value == '1') {
      return 'Moderate';
    } else if (value == '2') {
      return 'Bright';
    } else if (value == '3') {
      return 'Sunlight';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertWaterTankToString(String value) {
    if (value == '0') {
      return 'Empty';
    } else if (value == '1') {
      return 'Low';
    } else if (value == '2') {
      return 'Medium';
    } else if (value == '3') {
      return 'High';
    } else {
      return value; // Return original value for unexpected cases
    }
  }

  String _convertDistanceToString(String value) {
    return value.toString(); // Return original value for unexpected cases
  }

  String _convertMotionToString(String value) {
    if (value == '0') {
      return 'No';
    } else if (value == '1') {
      return 'Yes';
    } else {}
    return value.toString(); // Return original value for unexpected cases
  }

  @override
  Future<void> close() async {
    _componentDataSubject.close();
    super.close();
  }
}

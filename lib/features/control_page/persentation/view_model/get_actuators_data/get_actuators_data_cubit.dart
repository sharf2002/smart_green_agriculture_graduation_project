

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../current_green_house_id/current_green_house_id_cubit.dart';

part 'get_actuators_data_state.dart';

class GetActuatorsDataCubit extends Cubit<GetActuatorsDataState> {
  GetActuatorsDataCubit() : super(GetActuatorsDataInitial());

  final _actuatorDataSubject = BehaviorSubject<List<String>>();

  Stream<List<String>> get actuatorDataStream => _actuatorDataSubject.stream;

  String? greenHouseId;

  void getAcDataReturn({required BuildContext context}) async {
    emit(LoadingGetAcDataReturn());

    try {
      greenHouseId = context.read<CurrentGreenHouseIdCubit>().greenHouseId;
//------------------------------------------------------------
      final database = FirebaseDatabase.instance;

      final fanDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Fan_state_return')
          .onValue
          .map((event) => _convertFanToString(event.snapshot.value));

      final thermoDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Thermo_state_return')
          .onValue
          .map((event) => _convertThermoToString(event.snapshot.value));

      final pumpDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Pump_state_return')
          .onValue
          .map((event) => _convertPumpToString(event.snapshot.value));

      final lampDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Lamp_state_return')
          .onValue
          .map((event) => _convertLampToString(event.snapshot.value));

      final doorDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Door_state_return')
          .onValue
          .map((event) => _convertDoorData(event.snapshot.value));

      final buzzerDataStream = database
          .ref('GREENHOUSE/$greenHouseId/ACTUATORS/Buzzer_state_return')
          .onValue
          .map((event) => _convertBuzzerToString(event.snapshot.value));

      // Combine all streams into a single stream of actuator data
      final combinedStream = Rx.combineLatest6(
          fanDataStream,
          thermoDataStream,
          pumpDataStream,
          lampDataStream,
          doorDataStream,
          buzzerDataStream,
          (fanData, thermoData, pumpData, lampData, doorData, buzzerData) => [
                _convertFanToString(fanData),
                _convertThermoToString(thermoData),
                _convertPumpToString(pumpData),
                _convertLampToString(lampData),
                _convertDoorData(doorData),
                _convertBuzzerToString(buzzerData),
              ]);

      combinedStream.listen((actuatorData) {
        _actuatorDataSubject.add(actuatorData);
        print('Actuator data emitted: $actuatorData'); // Added for verification
      });
    } catch (e) {
      emit(FailedGetAcDataReturn());
      print('actuator error -------------->${e.toString()}');
    }
  }

  String _convertFanToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertThermoToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertPumpToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertLampToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertBuzzerToString(dynamic value) {
    if (value == '0') {
      return 'OFF';
    } else if (value == '1') {
      return 'ON';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  String _convertDoorData(dynamic value) {
    if (value == '3') {
      return 'CLOSE';
    } else if (value == '2') {
      return 'MEDIUM';
    } else if (value == '1') {
      return 'OPEN';
    } else {
      return value.toString(); // Return original value for unexpected cases
    }
  }

  @override
  Future<void> close() async {
    _actuatorDataSubject.close();
    super.close();
  }
}



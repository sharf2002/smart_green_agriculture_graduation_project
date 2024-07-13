import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_green_house_id_state.dart';

class CurrentGreenHouseIdCubit extends Cubit<CurrentGreenHouseIdState> {
  CurrentGreenHouseIdCubit() : super(CurrentGreenHouseIdInitial());
  String? greenHouseId;
  String? greenHouseName;
  String? selectedPlanetId;
  String? sunLight;
  String? wateringFactor;


  void catchGreenHouseId({
    required String? greenHouseId,
    required String? greenHouseName,
    required String? selectedPlanetId,
    required String? sunLight,
    required String? wateringFactor,


  }) {
    this.greenHouseId = greenHouseId;
    this.greenHouseName = greenHouseName;
    this.selectedPlanetId = selectedPlanetId;
    this.sunLight = sunLight;
    this.wateringFactor = wateringFactor;

    print('iddddddd--------> ${this.greenHouseId}');
    print('iddddddd--------> ${this.greenHouseId}');


    emit(SuccessCatchGreenHouseId());

  }
}

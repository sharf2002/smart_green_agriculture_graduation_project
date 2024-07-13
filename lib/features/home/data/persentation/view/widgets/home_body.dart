import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view/widgets/control_page_body.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/current_green_house_id/current_green_house_id_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/control_page/persentation/view_model/get_actuators_data/get_actuators_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_green_house_data/get_green_house_data_cubit.dart';
import 'package:smart_green_agriculture_graduation_project/features/home/data/persentation/view_model/get_green_house_data_model/get_green_house_data_model.dart';

import '../../../../../control_page/persentation/view_model/buzzer_control/buzzer_control_cubit.dart';
import '../../../../../control_page/persentation/view_model/manual_auto/manual_auto_cubit.dart';
import '../../../../../controls/cooling_control/persentation/view_model/fan_control/fan_control_cubit.dart';
import '../../../../../controls/cooling_control/persentation/view_model/fan_speed/fan_speed_cubit.dart';
import '../../../../../controls/cooling_control/persentation/view_model/thermo_control/thermo_control_cubit.dart';
import '../../../../../controls/lighting_control/persentation/view_model/door_control/door_control_cubit.dart';
import '../../../../../controls/lighting_control/persentation/view_model/lamp_control/lamp_control_cubit.dart';
import '../../../../../controls/watering_control/persentation/view_model/watering_control/pump_control_cubit.dart';
import '../../view_model/get_temperature_data/get_temperature_data_cubit.dart';
import 'bottom_sheet.dart';

class HomeBody extends StatelessWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          showBottomSheetPlanet(context: context);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Smart green house',
                  style: TextStyle(
                    color: Color(0xff160953),
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Agriculture is under control',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              BlocBuilder<GetGreenHouseDataCubit, GetGreenHouseDataState>(
                builder: (context, state) {
                  List<GetGreenHouseDataModel> lisOGreenHouses = [];
                  if (state is LoadingGetAllGreenhouseState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SuccessGetAllGreenHouseDataWithDetail) {
                    lisOGreenHouses = state.listOfGreenHouseDataModel;
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lisOGreenHouses.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<CurrentGreenHouseIdCubit>()
                                  .catchGreenHouseId(
                                    greenHouseId:
                                        lisOGreenHouses[index].greenHouseId,
                                    greenHouseName:
                                        lisOGreenHouses[index].greenHouseName,
                                    selectedPlanetId:
                                        lisOGreenHouses[index].selectedPlanetId,
                                sunLight: lisOGreenHouses[index].sunLight,
                                wateringFactor: lisOGreenHouses[index].wateringFactor,

                                  );


                              context
                                  .read<ManualAutoCubit>()
                                  .getControlTypeReturn(context: context);
                              context
                                  .read<BuzzerControlCubit>()
                                  .getbuzzerControlReturn(context: context);
                              context
                                  .read<LampControlCubit>()
                                  .getLampControlTypeReturn(context: context);
                              context
                                  .read<DoorControlCubit>()
                                  .getDoorControlTypeReturn(context: context);
                              context
                                  .read<FanControlCubit>()
                                  .getFanControlTypeReturn(context: context);
                              context
                                  .read<FanSpeedCubit>()
                                  .getFanSpeedValueReturn(context: context);
                              context
                                  .read<ThermoControlCubit>()
                                  .getThermoControlTypeReturn(context: context);
                              context
                                  .read<PumpControlCubit>()
                                  .getPumpControlTypeReturn(context: context);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ControlPageBody();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xff39D2C0),
                                    Color(0xFF4B39EF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${lisOGreenHouses[index].greenHousePhoto}'),
                                  radius: 30,
                                ),
                                title: Text(
                                  '${lisOGreenHouses[index].greenHouseName}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${lisOGreenHouses[index].selectedPlanet}',
                                  style: TextStyle(color: Colors.white60),
                                ),
                                trailing: Text(
                                  '${lisOGreenHouses[index].greenHouseId}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ErrorGetAllGreenhouseState) {
                    return Center(child: Text('There is an error! Try again'));
                  }
                  else return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

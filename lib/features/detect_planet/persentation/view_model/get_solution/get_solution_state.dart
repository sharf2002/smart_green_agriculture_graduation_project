part of 'get_solution_cubit.dart';

@immutable
abstract class GetSolutionState {}

class GetSolutionInitial extends GetSolutionState {}

class LoadingGetPlanetSolution extends GetSolutionState {}

class SuccessGetPlanetSolution extends GetSolutionState {
  String Disease;
  String Plant;
  String Solution;

  SuccessGetPlanetSolution({
    required this.Disease,
    required this.Plant,
    required this.Solution,
  });
}

class FailedGetPlanetSolution extends GetSolutionState {}

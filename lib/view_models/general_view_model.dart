import 'package:search_case_project/models/exercise.dart';
import 'package:search_case_project/services/general_service.dart';

class GeneralViewModel {

  
  List<Exercise> exercises = [];


 String selectedMuscle = "";

  String selectedType = "";

  List<String> types = [
    "cardio",
    "olympic_weightlifting",
    "plyometrics",
    "powerlifting",
    "strength",
    "stretching",
    "strongman"
  ];

  List<String> muscles = [
    "abdominals",
    "abductors",
    "adductors",
    "biceps",
    "calves",
    "chest",
    "forearms",
    "glutes",
    "hamstrings",
    "lats",
    "lowerback middleback",
    "neck",
    "quadriceps",
    "traps",
    "triceps"
  ];



  Future<void> getExercises({String type = "", String muscle = "", String name = ""}) async {
    
    exercises = await GeneralService().getExercises(type: type, muscle: muscle,name:name );
  }





}

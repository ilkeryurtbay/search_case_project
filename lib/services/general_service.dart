import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_case_project/models/exercise.dart';

class GeneralService {



  Future<List<Exercise>> getExercises(
      {String muscle = "", String type = "" ,  String name = ""}) async {

        
    List<Exercise> exercises = [];

    Uri myUri = Uri.https("exercises-by-api-ninjas.p.rapidapi.com",
        "/v1/exercises", {'muscle': muscle, "type": type, "name": name });

    http.Response response = await http.get(myUri, headers: {
      'X-RapidAPI-Key': 'b9e70ee0e3msh7f63fc96cfbec5cp1d23b6jsn7b27e57b39b9',
      'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com'
    });

    response.body;

    var bodyAsJson = json.decode(response.body);

    for (var element in bodyAsJson) {
      Exercise exercise = Exercise.fromJson(element);

      exercises.add(exercise);
    }

    print(response.body);

    return exercises;
  }

}

// To parse this JSON data, do
//
//     final exercise = exerciseFromJson(jsonString);

import 'dart:convert';

Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));

String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {
  Exercise({
    this.name = "",
    this.type = "",
    this.muscle = "",
  });

  String name;
  String type;
  String muscle;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        type: json["type"],
        muscle: json["muscle"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "muscle": muscle,
      };
}

import 'dart:convert';

BoidList boidListFromJson(String str) => BoidList.fromJson(json.decode(str));

String boidListToJson(BoidList data) => json.encode(data.toJson());

class BoidList {
  BoidList({
    this.boid,
    this.name,
  });

  String boid;
  String name;

  factory BoidList.fromJson(Map<String, dynamic> json) => BoidList(
    boid: json["boid"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "boid": boid,
    "name": name,
  };
}

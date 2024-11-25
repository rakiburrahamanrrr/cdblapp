import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile(
      {this.boid,
      this.name,
      this.phonenum,
      this.email,
      this.address,
      this.bank,
      this.status,
      this.botype});

  String boid;
  String name;
  String phonenum;
  String email;
  String address;
  String bank;
  String status;
  String botype;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      boid: json["boid"].toString(),
      name: json["name"].toString(),
      phonenum: json["phonenum"].toString(),
      email: json["email"].toString(),
      address: json["address"].toString(),
      bank: json["bank"].toString(),
      status: json["status"].toString(),
      botype: json["botype"].toString());

  Map<String, dynamic> toJson() => {
        "boid": boid.toString(),
        "name": name.toString(),
        "phonenum": phonenum.toString(),
        "email": email.toString(),
        "address": address,
        "bank": bank,
        "status": status,
        "botype": botype
      };
}

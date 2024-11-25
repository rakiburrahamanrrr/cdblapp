
import 'dart:convert';

Isin isinFromJson(String str) => Isin.fromJson(json.decode(str));

String isinToJson(Isin data) => json.encode(data.toJson());

class Isin {
  Isin({
    this.isinName,
  });

  String isinName;

  factory Isin.fromJson(Map<String, dynamic> json) => Isin(
    isinName: json["isin_name"],
  );

  Map<String, dynamic> toJson() => {
    "isin_name": isinName,
  };
}

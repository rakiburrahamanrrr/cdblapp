import 'dart:convert';

import 'package:intl/intl.dart';

Value valueFromJson(String str) => Value.fromJson(json.decode(str));

String valueToJson(Value data) => json.encode(data.toJson());

class Value {
  Value({
    this.value,
    this.cdate,
  });

  String value;
  String cdate;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    value: json["value"],
    //cdate: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["cdate"])),
    cdate: json["cdate"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "cdate": cdate,
  };
}
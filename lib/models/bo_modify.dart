import 'dart:convert';

import 'package:intl/intl.dart';

BoModify boModifyFromJson(String str) => BoModify.fromJson(json.decode(str));

String boModifyToJson(BoModify data) => json.encode(data.toJson());

class BoModify {
  BoModify({
    this.field,
    this.oldvalue,
    this.newvalue,
    this.modifyDate,
  });

  String field;
  String oldvalue;
  String newvalue;
  String modifyDate;

  factory BoModify.fromJson(Map<String, dynamic> json) => BoModify(
    field: json["field"],
    oldvalue: json["oldvalue"],
    newvalue: json["newvalue"],
    modifyDate: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["modify_date"])),
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "oldvalue": oldvalue,
    "newvalue": newvalue,
    "modify_date": modifyDate,
  };
}

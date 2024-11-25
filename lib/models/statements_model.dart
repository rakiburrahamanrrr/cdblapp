import 'dart:convert';
import 'package:intl/intl.dart';

Statement statementFromJson(String str) => Statement.fromJson(json.decode(str));

String statementToJson(Statement data) => json.encode(data.toJson());

class Statement {
  Statement({
    this.boid,
    this.isinName,
    this.trnDate,
    this.trnDesc,
    this.qty,
    this.trnType,
  });

  String boid;
  String isinName;
  String trnDate;
  String trnDesc;
  String qty;
  String trnType;

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
    boid: json["boid"],
    isinName: json["isin_name"],
    trnDate: DateFormat('dd-MM-yyyy ').format(DateTime.parse(json["trn_date"])),
    trnDesc: json["trn_desc"],
    qty: json["qty"],
    trnType: json["trn_type"],
  );

  Map<String, dynamic> toJson() => {
    "boid": boid,
    "isin_name": isinName,
    "trn_date": trnDate,
    "trn_desc": trnDesc,
    "qty": qty,
    "trn_type": trnType,
  };
}
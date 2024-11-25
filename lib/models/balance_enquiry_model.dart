import 'dart:convert';

import 'package:intl/intl.dart';

BalanceEnquiry balanceEnquiryFromJson(String str) => BalanceEnquiry.fromJson(json.decode(str));

String balanceEnquiryToJson(BalanceEnquiry data) => json.encode(data.toJson());

class BalanceEnquiry {
  BalanceEnquiry({
    this.boid,
    this.name,
    this.dpAddCcyCode,
    this.isinShortName,
    this.dpAdTotalBalance,
    this.closeRate,
    this.value,
    this.dpId,
    this.currDate,
  });

  String boid;
  String name;
  String dpAddCcyCode;
  String isinShortName;
  String dpAdTotalBalance;
  String closeRate;
  String value;
  String dpId;
  String currDate;

  factory BalanceEnquiry.fromJson(Map<String, dynamic> json) => BalanceEnquiry(
    boid: json["boid"],
    name: json["name"],
    dpAddCcyCode: json["dp_add_ccy_code"],
    isinShortName: json["isin_short_name"],
    dpAdTotalBalance: json["dp_ad_total_balance"],
    closeRate: json["close_rate"],
    value: json["value"],
    dpId: json["dp_id"],
    currDate: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["curr_date"])),
    //currDate: json["curr_date"],
  );

  Map<String, dynamic> toJson() => {
    "boid": boid,
    "name": name,
    "dp_add_ccy_code": dpAddCcyCode,
    "isin_short_name": isinShortName,
    "dp_ad_total_balance": dpAdTotalBalance,
    "close_rate": closeRate,
    "value": value,
    "dp_id": dpId,
    "curr_date": currDate,
  };
}

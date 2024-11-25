import 'dart:convert';
import 'package:cdbl/models/isin_name.dart';
import 'package:http/http.dart' as http;
import 'config/contants.dart';
import 'models/balance_enquiry_model.dart';
import 'models/bo_modify.dart';
import 'models/boid_list.dart';
import 'models/isin.dart';
import 'models/statements_model.dart';

class AuthApi {
  // ignore: missing_return
  Future<Map> getUserData(String boid) async {
    String responseString = "";
    final String apiUrl = "$API_URI/profile.php";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "boid": boid,
    });

    if (response.statusCode == 200) {
      responseString = response.body;
      if (responseString.isNotEmpty) {
        Map info = jsonDecode(responseString);
        return info;
      }
    } else {
      responseString = response.body;
      Map info = jsonDecode(responseString);
      print(info["message"]);
      return info;
    }
  }

  // ignore: missing_return
  Future<Map> getValue(String boid) async {
    String responseString = "";
    final String apiUrl = "$API_URI/value.php";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "boid": boid,
    });

    if (response.statusCode == 200) {
      responseString = response.body;
      if (responseString.isNotEmpty) {
        Map info = jsonDecode(responseString);
        return info;
      } else {}
    } else {
      responseString = response.body;
      Map info = jsonDecode(responseString);
      print(info["message"]);
      return info;
    }
  }

  Future<List<BalanceEnquiry>> getBalanceData(String boid) async {
    final String apiUrl = "$API_URI/balance.php";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "boid": boid,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((balanceEnquiry) => BalanceEnquiry.fromJson(balanceEnquiry))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<BoModify>> getModificationData(String boid) async {
    final String apiUrl = "$API_URI/bomodify.php";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "boid": boid,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((boModify) => BoModify.fromJson(boModify))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Statement>> getStatementData(IsinName isinName) async {
    final String apiUrl = "$API_URI/statement.php";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "boid": isinName.dataa,
      "isinname": isinName.isinname,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((statement) => Statement.fromJson(statement))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Isin>> getIsinStatementData(String boid) async {
    final String apiUrl = "$API_URI/isin_statement.php";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "boid": boid,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((isin) => Isin.fromJson(isin)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<BoidList>> getBoidList(String username) async {
    final String apiUrl = "$API_URI/boid_list.php";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "username": username,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((boidList) => BoidList.fromJson(boidList))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}

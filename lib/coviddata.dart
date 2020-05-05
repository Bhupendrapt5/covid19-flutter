import 'package:covid_19_flutter/model/pastdata.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import './model/state_model.dart';

class CovidData {

  Future<States> fetchNewData() async {

    final response =
        await http.get('https://api.covid19india.org/v2/state_district_wise.json');
    
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return States.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<PastData> fetchOldData() async {

    final response =
        await http.get('https://api.covid19india.org/states_daily.json');
    
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return PastData.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  
}
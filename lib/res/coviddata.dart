import 'package:http/http.dart' as http;

import 'dart:async';

import './responsemodel.dart';


class CovidData {

  Future<ResponseModel> fetchNewAlbum() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      return ResponseModel.successWithData(data: response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw ResponseModel.failed(message: "Failed to loadAlbum");
    }
  }

  //National Level :Time series, State-wise stats and Test counts
  Future<ResponseModel> fetchAllData() async {
    final response =
        await http.get('https://api.covid19india.org/data.json');

    if (response.statusCode == 200) {
      return ResponseModel.successWithData(data: response.body);
    } else {
      return ResponseModel.failed(message: 'Failed to load album');
    }
  }

  //State Level : has district-wise info 
  Future<ResponseModel> fetchNewData() async {
    final response =
        await http.get('https://api.covid19india.org/v2/state_district_wise.json');

    if (response.statusCode == 200) {
      return ResponseModel.successWithData(data: response.body);
    } else {

      return ResponseModel.failed(message: 'Failed to load album');
    }
  }

  //State Level : has district-wise info 
  Future<ResponseModel> fetchPastDataState() async {
    final response =
        await http.get('https://api.covid19india.org/states_daily.json');

    if (response.statusCode == 200) {
      return ResponseModel.successWithData(data: response.body);
    } else {

      return ResponseModel.failed(message: 'Failed to load album');
    }
  }

  //State Level : has district-wise info 
  Future<ResponseModel> fetchPastDataDistrict() async {
    final response =
        await http.get('https://api.covid19india.org/districts_daily.json');

    if (response.statusCode == 200) {
      return ResponseModel.successWithData(data: response.body);
    } else {

      return ResponseModel.failed(message: 'Failed to load album');
    }
  }

  //worldCovidData : has worldCovidData info 
  Future<ResponseModel> worldCovidData() async {
    final response =
        await http.get('https://api.covid19api.com/summary');

    if (response.statusCode == 200) {
      return ResponseModel.successWithData(data: response.body);
    } else {

      return ResponseModel.failed(message: 'Failed to load album');
    }
  }
 
  //worldCovidData : has worldCovidData info 
  Future<ResponseModel> worldCountryInfo() async {
    final response =
        await http.get('https://restcountries.eu/rest/v2/all');

    if (response.statusCode == 200) {
      return ResponseModel.successWithData(data: response.body);
    } else {

      return ResponseModel.failed(message: 'Failed to load album');
    }
  }
 
  
}
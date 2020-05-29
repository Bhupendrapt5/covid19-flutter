import 'package:http/http.dart' as http;

import 'dart:async';

import '../res/responsemodel.dart';


class CovidData {

  Future<GetResponse> fetchNewAlbum() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      return GetResponse.successWithData(data: response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw GetResponse.failed(message: "Failed to loadAlbum");
    }
  }

  //National Level :Time series, State-wise stats and Test counts
  Future<GetResponse> fetchAllData() async {
    final response =
        await http.get('https://api.covid19india.org/data.json');

    if (response.statusCode == 200) {
      return GetResponse.successWithData(data: response.body);
    } else {
      return GetResponse.failed(message: 'Failed to load album');
    }
  }

  //State Level : has district-wise info 
  Future<GetResponse> fetchNewData() async {
    final response =
        await http.get('https://api.covid19india.org/v2/state_district_wise.json');

    if (response.statusCode == 200) {
      
      return GetResponse.successWithData(data: response.body);
    } else {

      return GetResponse.failed(message: 'Failed to load album');
    }
  }

  //State Level : has district-wise info 
  Future<GetResponse> fetchPastDataState() async {
    final response =
        await http.get('https://api.covid19india.org/states_daily.json');

    if (response.statusCode == 200) {
      return GetResponse.successWithData(data: response.body);
    } else {

      return GetResponse.failed(message: 'Failed to load album');
    }
  }

  //State Level : has district-wise info 
  Future<GetResponse> fetchPastDataDistrict() async {
    final response =
        await http.get('https://api.covid19india.org/districts_daily.json');

    if (response.statusCode == 200) {
      return GetResponse.successWithData(data: response.body);
    } else {

      return GetResponse.failed(message: 'Failed to load album');
    }
  }

  //worldCovidData : has worldCovidData info 
  Future<GetResponse> worldCovidData() async {
    final response =
        await http.get('https://api.covid19api.com/summary');

    if (response.statusCode == 200) {
      return GetResponse.successWithData(data: response.body);
    } else {

      return GetResponse.failed(message: 'Failed to load album');
    }
  }
}
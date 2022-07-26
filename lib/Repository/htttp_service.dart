import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../Globals/Widgets/custom_snackbar.dart';

class RestConnector {
  String url;
  String requestType;
  var data;
  int talepId;
  String token;
  RestConnector(
    this.url,
    this.token, {
    this.requestType = "GET",
    this.data = "",
    this.talepId = 0,
  });

  getData() async {
    var response;
    var parsedResponse;
    if (requestType == 'GET') {
      response = await http.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': token,
        },
      );
    } else if (requestType == 'POST') {
      response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          'content-type': 'application/json',
          'Authorization': token,
        },
      );
    } else if (requestType == "PUT") {
      response = await http.put(
        Uri.parse(url),
        body: data,
        headers: {
          'content-type': 'application/json',
          'Authorization': token,
        },
      );
    } else if (requestType == "MEDIA") {
      Dio dio = Dio();
      dio.options.headers["authorization"] = token;
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.headers['talepid'] = talepId;
      response = await dio.post(
        url,
        data: data,
      );
    }
    if (response.statusCode == 401) {
      errorSnackBar("Yeninden giriş yapın");
    }
    if (requestType == "MEDIA") {
      parsedResponse = response.data;
    } else {
      parsedResponse = json.decode(response.body);
    }

    return parsedResponse;
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Globals/Widgets/custom_snackbar.dart';

enum RequestType {
  get,
  post,
  put,
  media,
  pathch,
}

class RestConnector {
  String url;
  RequestType requestType;
  var data;
  int talepId;
  String token;
  RestConnector(
    this.url,
    this.token, {
    this.requestType = RequestType.get,
    this.data = "",
    this.talepId = 0,
  });

  getData() async {
    var response;
    var parsedResponse;
    if (requestType == RequestType.get) {
      response = await http.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': "Bearer " + token,
        },
      );
    } else if (requestType == RequestType.post) {
      response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          'content-type': 'application/json',
          'Authorization': "Bearer " + token,
        },
      );
    } else if (requestType == RequestType.put) {
      response = await http.put(
        Uri.parse(url),
        body: data,
        headers: {
          'content-type': 'application/json',
          'Authorization': "Bearer " + token,
        },
      );
    } else if (requestType == RequestType.media) {
      Dio dio = Dio();
      dio.options.headers["authorization"] = token;
      dio.options.headers['content-Type'] = 'multipart/form-data';
      response = await dio.post(
        url,
        data: data,
      );
    } else if (requestType == RequestType.pathch) {
      response = await http.patch(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'Authorization': "Bearer " + token,
        },
      );
    }
    if (response.statusCode == 401) {
      errorSnackBar("Yeninden giriş yapın");
    }
    if (requestType == RequestType.media) {
      parsedResponse = response.data;
    } else {
      parsedResponse = json.decode(response.body);
    }

    return parsedResponse;
  }
}

import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

final dio = d.Dio();

class Requete extends GetConnect {
  //String url = "http://10.0.2.2:8080/";
  //static String urlSt = "http://10.0.2.2:8080/";
  //String url = "https://kimia-med-spa-5ffea57b1ff0.herokuapp.com/";
  //static String urlSt = "https://kimia-med-spa-5ffea57b1ff0.herokuapp.com/";
  //String url = "http://192.168.0.101:8080/";
  //static String urlSt = "http://192.168.0.101:8080/";
  //
  String url = "http://192.168.43.7:8080/";
  static String urlSt = "http://192.168.43.7:8080/";

  Future<d.Response> getE(
    String path,
  ) async {
    print("la route get: $url$path");
    return dio.get("$url$path");
  }

  //
  Future<d.Response> postE(String path, var object) async {
    print("$url$path");
    return dio.post("$url$path", data: object);
  }

  //
  Future<d.Response> putE(String path, var object) async {
    return dio.put("$url$path", data: object);
  }

  //
  Future<d.Response> deleteE(String path) async {
    return dio.delete("$url$path");
  }
}

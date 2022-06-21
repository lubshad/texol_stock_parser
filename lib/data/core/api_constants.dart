import 'package:flutter/foundation.dart';

class ApiConstants {
  ApiConstants._();
  // local
  static String get domainUrl =>
      kDebugMode ? "http://localhost" : "https://api.jsonbin.io";

  static const String slugUrl = "/b";

  static String get baseUrl =>
      kDebugMode ? "$domainUrl:8000$slugUrl" : domainUrl + slugUrl;

  static const String getStockDetailsUrl = "/6297363b402a5b3802181620";
}

getImageUrl(String url) {
  return ApiConstants.domainUrl + url;
}

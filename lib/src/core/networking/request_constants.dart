// import '../Env/env.dart';

class RequestConstant {
  static final Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 100;
  static late final int commpanyId;
  static String? commpanyPath;
}

class ResponseConstant {
  static const int successCode = 200;
  static const int unAuthorized = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;
  static const String success = "Success";
}

// // var Imn = 9;
// var rh = Env.tmdbApiKey;
// enum HiveSessionName {
//   AppSectionConfig,
// }

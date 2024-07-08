// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// import 'network_exception.dart';
// import 'request_constants.dart';


//todo Currently, the APIManager class is not being used in the project,just left for firebase
// final dio = Dio();

// class ApiManager {
//   ApiManager._();

//   static final _logger = Logger(
//     printer: PrettyPrinter(
//       colors: true,
//       printTime: true,
//       printEmojis: false,
//     ),
//     filter: DevelopmentFilter(),
//   );

//   static final Dio _dio = Dio(BaseOptions(
//       // baseUrl: ApiConstant.baseUrl,
//       connectTimeout: const Duration(
//     seconds: RequestConstant.connectionTimeout,
//   )))
//     // ..interceptors.add(InterceptorsWrapper(
//     //   onRequest: (options, handler) {
//     //     TColorPrint.green("Request 123: ${options.uri}");
//     //     options.headers.addAll(RequestConstant.headers);
//     //     return handler.next(options);
//     //   },
//     // ))
//     ..interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) {
//         TColorPrint.green("Request: ${options.uri}");
//         options.headers.addAll(RequestConstant.headers);
//         return handler.next(options);
//       },
//       onResponse: (response, handler) {
//         TColorPrint.green("Response: $response");
//         return handler.next(response);
//       },
//       onError: (DioException e, handler) {
//         TColorPrint.red("Error: ${e.message}");
//         return handler.next(e);
//       },
//     ));
//   // ..interceptors.add(TalkerDioLogger(
//   //     settings: const TalkerDioLoggerSettings(
//   //   printRequestHeaders: false,
//   //   printResponseHeaders: false,
//   //   printResponseMessage: false,
//   //   printResponseData: false,
//   //   printRequestData: true,
//   //   // requestPen: AnsiPen()..yellow(),
//   //   // errorPen: AnsiPen()..red()
//   // )));

//   static Future<dynamic> get(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     TColorPrint.yellow("Calling API: $url");
//     _logger.t(
//       "Calling API: $url",
//       stackTrace: StackTrace.empty,
//     );

//     try {
//       final Response<dynamic> response = await _dio.get(
//         url,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );

//       _logger.w(
//         'Calling API: $url,\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}',
//         stackTrace: StackTrace.empty,
//       );
//       _logger.i("Response: $response", stackTrace: StackTrace.empty);

//       return response.data;
//     } catch (e) {
//       if (e is DioException) {
//         _logger.e("DioException: ${e.message}", error: e);

//         throw DioExceptions.fromDioError(e);
//       }
//       rethrow;
//     }
//   }

//   static Future<dynamic> post(
//     String uri, {
//     required dynamic body,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     _logger.t("""
//     Calling API: $uri
//     Calling parameters: $body""", stackTrace: StackTrace.empty);

//     try {
//       final Response<dynamic> response = await _dio.post(
//         uri,
//         data: body,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       _logger.w('Calling API: $uri,\nCalling parameters: $body",\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}', stackTrace: StackTrace.empty);
//       _logger.i("Response: $response", stackTrace: StackTrace.empty);

//       return response.data;
//     } catch (e) {
//       if (e is DioException) {
//         _logger.e("DioException: ${e.message}", error: e);
//         throw DioExceptions.fromDioError(e);
//       }
//       rethrow;
//     }
//   }

//   static Future<Response<dynamic>> put(
//     String uri, {
//     dynamic body,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     _logger.t("Calling API: $uri", stackTrace: StackTrace.empty);
//     try {
//       final Response<dynamic> response = await _dio.put(
//         uri,
//         data: body,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       _logger.w('Calling API: $uri,\nCalling parameters: $body",\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}', stackTrace: StackTrace.empty);
//       _logger.i("Response: $response", stackTrace: StackTrace.empty);
//       return response;
//     } catch (e) {
//       if (e is DioException) {
//         _logger.e("DioException: ${e.message}", error: e);
//         throw DioExceptions.fromDioError(e);
//       }
//       rethrow;
//     }
//   }

//   static Future<dynamic> delete(
//     String uri, {
//     dynamic body,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     _logger.t("Calling API: $uri");
//     try {
//       final Response<dynamic> response = await _dio.delete(
//         uri,
//         data: body,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       _logger.w('Calling API: $uri,\nCalling parameters: $body",\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}', stackTrace: StackTrace.empty);
//       _logger.i("Response: $response", stackTrace: StackTrace.empty);
//       return response.data;
//     } catch (e) {
//       if (e is DioException) {
//         _logger.e("DioException: ${e.message}", error: e);
//         throw DioExceptions.fromDioError(e);
//       }
//       rethrow;
//     }
//   }

//   static Future<void> downloadFile(
//     String url,
//     String savePath, {
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     _logger.t("Downloading file from: $url");
//     try {
//       await _dio.download(
//         url,
//         savePath,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );

//       _logger.w("File downloaded successfully to: $savePath", stackTrace: StackTrace.current);
//     } catch (e) {
//       if (e is DioException) {
//         _logger.e("DioError during file download: ${e.message}", error: e);
//         throw DioExceptions.fromDioError(e);
//       }
//       rethrow;
//     }
//   }
// }

// class TColorPrint {
//   TColorPrint._();
//   static void yellow(String text) {
//     debugPrint('\x1B[33m$text\x1B[0m');
//   }

//   static void red(String text) {
//     debugPrint('\x1B[31m$text\x1B[0m');
//   }

//   static void green(String text) {
//     debugPrint('\x1B[92m$text\x1B[0m');
//   }

//   static void brightWhite(String text) {
//     debugPrint('\x1B[97m$text\x1B[0m');
//   }

//   static void cyan(String text) {
//     debugPrint('\x1B[36m$text\x1B[0m');
//   }
// }

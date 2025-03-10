import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class ApiLog extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = "";
    options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    try {} catch (_) {}
    try {
      final String prettyJson = _getDataAsString(options.data);
      log.d(
        // ignore: unnecessary_null_comparison
        "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}\n"
        "Headers:\n"
        "$headerMessage\n"
        "❖ QueryParameters :\n${_buildQueryParametersString(options.queryParameters)}\n"
        "Body: $prettyJson",
      );
    } catch (e, stackTrace) {
      log.e("Failed to extract json request $e");
      log.e("Stack trace: $stackTrace");
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.e(
      "<-- ${err.message} ${err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL'}\n\n"
      "${err.response != null ? err.response!.data : 'Unknown Error'}",
    );
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    log.d(
      // ignore: unnecessary_null_comparison
      "◀ ︎RESPONSES ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Responses: $prettyJson",
    );

    super.onResponse(response, handler);
  }

  String _getDataAsString(dynamic data) {
    if (data is FormData) {
      // Handle FormData differently
      final fields = data.fields
          .map((entry) => '► ${entry.key}: ${entry.value}')
          .join('\n');
      final files = data.files
          .map((entry) => '► ${entry.key}: ${entry.value}')
          .join('\n');
      return '\n► Fields: \n$fields\n► Files: $files\n';
    } else {
      // Convert other types to JSON
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    }
  }

  String _buildQueryParametersString(Map<String, dynamic> queryParameters) {
    if (queryParameters.isEmpty) {
      return 'No query parameters';
    } else {
      return queryParameters.entries
          .map((entry) => '► ${entry.key}: ${entry.value}')
          .join('\n');
    }
  }

  String queryParamBuilder(Map<String, dynamic> params) {
    String param = '?';
    params.forEach((key, value) {
      if (value is List) {
        for (var element in value) {
          param += '$key=${Uri.encodeQueryComponent(element.toString())}&';
        }
      } else {
        param += '$key=${Uri.encodeQueryComponent(value.toString())}&';
      }
    });
    return param;
  }
}

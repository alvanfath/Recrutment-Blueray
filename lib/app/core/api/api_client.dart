import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recrutment_blueray/app/core/core.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class ApiClient with StorageProvider {
  String baseUrl = dotenv.env['BASE_URL'] as String;
  late Dio _dio;
  ApiClient() {
    _dio = _createDio();
    _dio.interceptors.add(ApiLog());
  }
  Dio get dio {
    try {} catch (_) {}

    final dio = _createDio();

    dio.interceptors.add(ApiLog());

    return dio;
  }

  Dio _createDio() => Dio(
        BaseOptions(
          headers: {},
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          validateStatus: (int? status) {
            return true;
          },
          baseUrl: baseUrl,
        ),
      );

  Future<Either<FailureModel, T>> getRequest<T>(
    String url, {
    required Map<String, dynamic> queryParam,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParam,
        options: Options(headers: headers),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return Right(converter(response.data));
    } on DioException catch (e, stackTrace) {
      log.d('stacktrace: $stackTrace');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left(
          FailureModel(
            statusCode: 504,
            detail: Constants.get.errorTitle504,
            message: Constants.get.errorSubtitle504,
          ),
        );
      } else {
        if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitle500,
              message: Constants.get.errorSubtitle500,
            ),
          );
        }
        if (e.response?.statusCode == 404) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 403) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 429) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleManyRequest,
              message: Constants.get.errorSubtileManyRequest,
            ),
          );
        }
        return Left(
          FailureModel(
            statusCode: e.response?.statusCode,
            detail: Constants.get.errorTitleGeneral,
            message: e.response?.data['message'] as String?,
            data: e.response?.data['data'],
          ),
        );
      }
    }
  }

  Future<Either<FailureModel, T>> postRequest<T>(
    String url, {
    required Map<String, dynamic> data,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return Right(converter(response.data));
    } on DioException catch (e, stackTrace) {
      log.d('stacktrace: $stackTrace');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left(
          FailureModel(
            statusCode: 504,
            detail: Constants.get.errorTitle504,
            message: Constants.get.errorSubtitle504,
          ),
        );
      } else {
        if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitle500,
              message: Constants.get.errorSubtitle500,
            ),
          );
        }
        if (e.response?.statusCode == 404) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 403) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 429) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleManyRequest,
              message: Constants.get.errorSubtileManyRequest,
            ),
          );
        }
        return Left(
          FailureModel(
            statusCode: e.response?.statusCode,
            detail: Constants.get.errorTitleGeneral,
            message: e.response?.data['message'] as String?,
            data: e.response?.data['data'],
          ),
        );
      }
    }
  }

  Future<Either<FailureModel, T>> putRequest<T>(
    String url, {
    required Map<String, dynamic> data,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await dio.put(
        url,
        data: data,
        options: Options(headers: headers),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return Right(converter(response.data));
    } on DioException catch (e, stackTrace) {
      log.d('stacktrace: $stackTrace');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left(
          FailureModel(
            statusCode: 504,
            detail: Constants.get.errorTitle504,
            message: Constants.get.errorSubtitle504,
          ),
        );
      } else {
        if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitle500,
              message: Constants.get.errorSubtitle500,
            ),
          );
        }
        if (e.response?.statusCode == 404) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 403) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 429) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleManyRequest,
              message: Constants.get.errorSubtileManyRequest,
            ),
          );
        }
        return Left(
          FailureModel(
            statusCode: e.response?.statusCode,
            detail: Constants.get.errorTitleGeneral,
            message: e.response?.data['message'] as String?,
            data: e.response?.data['data'],
          ),
        );
      }
    }
  }

  Future<Either<FailureModel, T>> deleteRequest<T>(
    String url, {
    required Map<String, dynamic> data,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> headers,
  }) async {
    try {
      final response = await dio.delete(
        url,
        data: data,
        options: Options(headers: headers),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return Right(converter(response.data));
    } on DioException catch (e, stackTrace) {
      log.d('stacktrace: $stackTrace');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left(
          FailureModel(
            statusCode: 504,
            detail: Constants.get.errorTitle504,
            message: Constants.get.errorSubtitle504,
          ),
        );
      } else {
        if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitle500,
              message: Constants.get.errorSubtitle500,
            ),
          );
        }
        if (e.response?.statusCode == 404) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 403) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 429) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleManyRequest,
              message: Constants.get.errorSubtileManyRequest,
            ),
          );
        }
        return Left(
          FailureModel(
            statusCode: e.response?.statusCode,
            detail: Constants.get.errorTitleGeneral,
            message: e.response?.data['message'] as String?,
            data: e.response?.data['data'],
          ),
        );
      }
    }
  }

  Future<Either<FailureModel, T>> postFormData<T>(
    String url, {
    required Map<String, String> data,
    required Map<String, dynamic> queryParam,
    required ResponseConverter<T> converter,
    Map<String, dynamic>? headers,
    bool isIsolate = true,
  }) async {
    try {
      final header = headers ?? {};

      final FormData formData = FormData.fromMap({});
      await Future.forEach(
        data.entries,
        (MapEntry<String, dynamic> entry) async {
          final String key = entry.key;
          final String value = entry.value.toString();
          if (File(value).existsSync() || value is File) {
            formData.files.add(
              MapEntry(
                key,
                await MultipartFile.fromFile(
                  value,
                  filename: value.split('/').last,
                ),
              ),
            );
          } else {
            formData.fields.add(MapEntry(key, value));
          }
        },
      );

      final response = await dio.post(
        url,
        data: formData,
        queryParameters: queryParam,
        options: Options(
          headers: header,
        ),
      );
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      return Right(converter(response.data));
    } on DioException catch (e, stackTrace) {
      log.d('stacktrace: $stackTrace');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left(
          FailureModel(
            statusCode: 504,
            detail: Constants.get.errorTitle504,
            message: Constants.get.errorSubtitle504,
          ),
        );
      } else {
        if (e.response?.statusCode == 500 || e.response?.statusCode == 502) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitle500,
              message: Constants.get.errorSubtitle500,
            ),
          );
        }
        if (e.response?.statusCode == 404) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 403) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleGeneral,
              message: Constants.get.errorSubtitleGeneral,
            ),
          );
        }
        if (e.response?.statusCode == 429) {
          return Left(
            FailureModel(
              statusCode: e.response?.statusCode,
              detail: Constants.get.errorTitleManyRequest,
              message: Constants.get.errorSubtileManyRequest,
            ),
          );
        }
        return Left(
          FailureModel(
            statusCode: e.response?.statusCode,
            detail: Constants.get.errorTitleGeneral,
            message: e.response?.data['message'] as String?,
            data: e.response?.data['data'],
          ),
        );
      }
    }
  }
}

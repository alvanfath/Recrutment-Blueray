import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class PutUsecase with StorageProvider {
  final ApiClient client;
  const PutUsecase(this.client);

  Future<Either<FailureModel, T>> call<T>({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String> moreHeader = const {},
    bool isUseToken = true,
    required ResponseConverter<T> converter,
  }) async {
    Map<String, String> header = {};
    String accessToken = dotenv.env['ACCESS_TOKEN'].toString();

    if (isUseToken) {
      final String token = await getData(KeyStorage.token);

      header['Authorization'] = 'Token $token';
    } else {
      header['AccessToken'] = accessToken;
    }
    final headers = {
      ...header,
      ...moreHeader,
    };
    final response = client.putRequest(
      url,
      data: body,
      converter: converter,
      headers: headers,
    );
    return response;
  }
}

import 'package:injectable/injectable.dart';
import 'package:kailasha/core/network/dio/dio_api_client.dart';

@LazySingleton()
class AuthRepository {
  static final dio = DioUtil();

  // Future<ResponseModel> validateVerificationCode({
  //   required String email,
  //   required String deviceUuid,
  //   required String verificationId,
  // }) async {
  //   final params = {
  //     "email": email,
  //     'deviceUuid': deviceUuid,
  //     'verificationId': verificationId,
  //   };
  //   final response = await dio.post(
  //     ApiConstant.validateVerificationCode,
  //     queryParams: params,
  //   );
  //   final model = ResponseModel.fromJson(response);
  //   return model;
  // }
}

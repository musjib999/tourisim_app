import 'package:dio/dio.dart';

Future<dynamic> postRequest({
  required String url,
  FormData? formData,
}) async {
  dynamic response;
  try {
    Response response = await Dio().post(url, data: formData);
    response = response;
    print(response.data);
  } on DioError catch (e) {
    response = e.message;
    print(e.message);
  }
  return response;
}

import 'package:dio/dio.dart';

class DogsApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://random.dog/woof.json';
  Future<String> fetchUrl() async {
    try {
      Response response = await _dio.get(_url);
      return response.data['url'];
    } catch (error, stacktrace) {
      return ("Data not found / Connection issue");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:musicgo/core/config/const.dart';

class Bilibili {
  static final Dio _dio = Dio();

  static Future<String> search(String keyword) async {
    final Map<String, String> params = {
      'keyword': keyword,
      'search_type': 'video',
      'order': 'totalrank',
      'duration': '0',
      'tids': '0',
      'page': '1',
    };

    try {
      final res = await _dio.get(
        Constant.searchUrl,
        queryParameters: params,
        options: Options(
          headers: {
            'Cookie': Constant.defaultCookie,
          },
        ),
      );

      return res.data.toString();
    } catch (e) {
      return 'Error searching: $e';
    }
  }
}

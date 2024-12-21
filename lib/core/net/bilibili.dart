import 'package:dio/dio.dart';
import 'package:musicgo/core/config/const.dart';
import 'package:musicgo/models/bilibili.dart';

class Bilibili {
  static final Dio _dio = Dio();

  static Future<List<SearchResponse>> search(String keyword) async {
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
          headers: Constant.searchHeaders,
        ),
      );

      final List<SearchResponse> searchList = [];
      for (final item in res.data['data']['result']) {
        searchList.add(SearchResponse.fromJson(item));
      }
      return searchList;
    } catch (e) {
      // TODO: add log
      return [];
    }
  }
}

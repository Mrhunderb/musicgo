import 'package:dio/dio.dart';
import 'package:musicgo/core/config/const.dart';
import 'package:musicgo/models/bilibili.dart';

class Bilibili {
  static final Dio _dio = Dio();

  static Future<List<SearchResponse>> searchByPage(
      String keyword, int page) async {
    final Map<String, String> params = {
      'keyword': keyword,
      'search_type': 'video',
      'order': 'totalrank',
      'duration': '0',
      'tids': '0',
      'page': '$page',
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

  static Future<String> getPlayUrl(String bvid) async {
    final Map<String, String> params = {
      'qn': '0',
      'bvid': bvid,
      'fnval': '16',
      'fnver': '0',
      'fourk': '1',
    };

    try {
      final cid = await _getCid(bvid);
      params['cid'] = cid;
      final res = await _dio.get(
        Constant.playUrl,
        queryParameters: params,
        options: Options(
          headers: Map.from({
            'Referer': 'https://www.bilibili.com',
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
            'Cookie': Constant.defaultCookie,
          }),
        ),
      );

      return res.data['data']['dash']['audio'][0]['baseUrl'];
    } catch (e) {
      //TODO: add log
      return '';
    }
  }

  static Future<String> _getCid(String bvid) async {
    final Map<String, String> params = {
      'bvid': bvid,
    };

    try {
      final res = await _dio.get(
        Constant.cidUrl,
        queryParameters: params,
      );

      return res.data['data']['cid'].toString();
    } catch (e) {
      //TODO: add log
      return '';
    }
  }
}

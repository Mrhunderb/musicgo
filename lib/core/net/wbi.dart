import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:musicgo/core/config/const.dart';

class Wbi {
  final Dio _dio = Dio();

  Future<String> getWWebId() async {
    // TODO
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final wWebId = md5.convert(utf8.encode(timeStamp.toString())).toString();
    return wWebId;
  }

  Future<String> getCookie() async {
    try {
      final response = await _dio.get(
        Constant.fingerUrl,
        options: Options(headers: Constant.defaultHeaders),
      );
      return response.data['data'];
    } catch (e) {
      // Use a logging framework instead of print
      // For example, using the logging package
      // Logger().severe('Request failed: $e');
    }

    return '';
  }

  Future<String> getWRid(Map<String, String> params) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    params['wts'] = timeStamp.toString();
    print('wts: $timeStamp');
    final mixinKey = await getMixinKey();
    final wRid = encodeSortedQuery(params) + mixinKey;
    final wRidMd5 = md5.convert(utf8.encode(wRid)).toString();
    return wRidMd5;
  }

  Future<String> getMixinKey() async {
    final rawWbiKey = await _getWbiKey();
    List<int> wbiKeyBytes = utf8.encode(rawWbiKey);
    List<int> mixinKeyBytes =
        Constant.mixinKeyEncTab.map((index) => wbiKeyBytes[index]).toList();
    String mixinKey = utf8.decode(mixinKeyBytes);
    return mixinKey.substring(0, 32);
  }

  Future<String> _getWbiKey() async {
    try {
      Response response = await _dio.get(
        Constant.navUrl,
        options: Options(
          headers: Constant.searchHeaders,
        ),
      );
      final imgUrl = Uri.parse(response.data['data']['wbi_img']['img_url'])
          .pathSegments
          .last;
      final imgKey = imgUrl.split('.').first;
      final subUrl = Uri.parse(response.data['data']['wbi_img']['sub_url'])
          .pathSegments
          .last;
      final subKey = subUrl.split('.').first;

      return "$imgKey$subKey";
    } catch (e) {
      // Use a logging framework instead of print
      // For example, using the logging package
      // Logger().severe('Request failed: $e');
      print(e);
    }
    return '';
  }

  String encodeSortedQuery(Map<String, String> params) {
    final sortedKeys = params.keys.toList()..sort();

    final query = sortedKeys.map((key) {
      final encodedKey = Uri.encodeQueryComponent(key);
      final encodedValue = Uri.encodeQueryComponent(params[key]!);
      return '$encodedKey=$encodedValue';
    }).join('&');

    return query;
  }
}

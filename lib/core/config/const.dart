class Constant {
  static const String appName = 'Music';
  static const String _baseUrl = 'https://api.bilibili.com/x/web-interface';
  static const String navUrl = '$_baseUrl/nav';
  static const String cidUrl = '$_baseUrl/view';
  static const String fingerUrl =
      'https://api.bilibili.com/x/frontend/finger/spi';
  static const String searchUrl = '$_baseUrl/wbi/search/type';
  static const String playUrl = 'https://api.bilibili.com/x/player/wbi/playurl';
  static const String defaultCookie = 'SESSDATA=xxx';
  static const String defaultUA =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36 Edg/89.0.774.63";

  static const Map<String, String> defaultHeaders = {
    "user-agent": defaultUA,
    'accept': "application/json, text/plain, */*",
    "accept-encoding": "gzip, deflate, br",
    "sec-fetch-site": "same-site",
    "sec-fetch-mode": "cors",
    "sec-fetch-dest": "empty",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
    "cookie": defaultCookie,
  };

  static const Map<String, String> searchHeaders = {
    ...defaultHeaders,
    'origin': "https://search.bilibili.com",
    "referer": "https://search.bilibili.com/",
  };

  static const List<int> mixinKeyEncTab = [
    46,
    47,
    18,
    2,
    53,
    8,
    23,
    32,
    15,
    50,
    10,
    31,
    58,
    3,
    45,
    35,
    27,
    43,
    5,
    49,
    33,
    9,
    42,
    19,
    29,
    28,
    14,
    39,
    12,
    38,
    41,
    13,
    37,
    48,
    7,
    16,
    24,
    55,
    40,
    61,
    26,
    17,
    0,
    1,
    60,
    51,
    30,
    4,
    22,
    25,
    54,
    21,
    56,
    59,
    6,
    63,
    57,
    62,
    11,
    36,
    20,
    34,
    44,
    52
  ];
}

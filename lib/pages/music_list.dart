import 'package:flutter/material.dart';
import 'package:musicgo/weigets/search_list.dart';

class MusicListPage extends StatelessWidget {
  final String keyWord;
  const MusicListPage({super.key, required this.keyWord});

  static Route<dynamic> router(String keyWord) {
    return MaterialPageRoute(builder: (_) {
      return MusicListPage(keyWord: keyWord);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索结果'),
      ),
      body: SearchList(keyWord: keyWord),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:musicgo/weigets/search_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Center(
        child: SearchList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:musicgo/pages/music_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static Route<dynamic> router() {
    return MaterialPageRoute(builder: (_) {
      return const SearchPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controler = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              SizedBox(width: 8),
              Flexible(
                child: SizedBox(
                  height: 30, // Set the desired height here
                  child: TextField(
                    controller: controler,
                    decoration: InputDecoration(
                      hintText: '搜索歌曲',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MusicListPage.router(controler.text));
            },
            icon: const Icon(Icons.search, color: Colors.black87),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Text("Search Page"),
      ),
    );
  }
}

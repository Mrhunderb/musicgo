import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:musicgo/core/net/bilibili.dart';
import 'package:musicgo/models/bilibili.dart';
import 'package:musicgo/pages/music_play.dart';

class SearchList extends StatefulWidget {
  final String keyWord;
  const SearchList({super.key, required this.keyWord});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  static const _pageSize = 50;

  final PagingController<int, SearchResponse> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Bilibili.searchByPage(widget.keyWord, pageKey);
      final isLastPage = pageKey >= _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      PagedListView<int, SearchResponse>(
        pagingController: _pagingController,
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        builderDelegate: PagedChildBuilderDelegate<SearchResponse>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item.title
                .replaceAll('<em class="keyword">', '')
                .replaceAll('</em>', '')),
            subtitle: Text(item.author),
            onTap: () {
              Navigator.of(context).push(
                MusicPlayPage.router(item.bvid),
              );
            },
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

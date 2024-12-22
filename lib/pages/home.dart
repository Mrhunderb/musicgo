import 'package:flutter/material.dart';
import 'package:musicgo/pages/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black87),
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return const SearchPage();
            }));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.black54),
                SizedBox(width: 8),
                Text(
                  '搜索歌曲',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Icon(Icons.headphones, color: Colors.black87),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 推荐功能区域
          _buildFeatureSection(),
          // 我的歌单和收藏歌单
          _buildPlaylistSection(),
          _buildBottomPlayer(),
        ],
      ),
    );
  }

  // 推荐功能按钮区域
  Widget _buildFeatureSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFeatureButton(Icons.whatshot, '推荐歌单'),
          _buildFeatureButton(Icons.emoji_events, '榜单'),
          _buildFeatureButton(Icons.history, '播放记录'),
          _buildFeatureButton(Icons.library_music, '本地音乐'),
        ],
      ),
    );
  }

  Widget _buildFeatureButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black87, size: 28),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  // 我的歌单和收藏歌单区域
  Widget _buildPlaylistSection() {
    return Expanded(
      child: Column(
        children: [
          // 切换标签栏
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '我的歌单 (1)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          // 歌单列表
          Expanded(
            child: ListView(
              children: [
                _buildPlaylistItem('我喜欢', '1首', Icons.favorite, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistItem(
      String title, String subtitle, IconData icon, bool isFavorite) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[200],
        child:
            isFavorite ? const Icon(Icons.favorite, color: Colors.red) : null,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        // 点击事件
      },
    );
  }

  // 底部播放器区域
  Widget _buildBottomPlayer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '“斯是陋室，有猫就行”',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '《陋室铭》',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.playlist_play),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

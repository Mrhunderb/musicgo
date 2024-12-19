import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayPage extends StatefulWidget {
  const MusicPlayPage({super.key});

  @override
  _MusicPlayPageState createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  late AudioPlayer _audioPlayer;
  int _currentIndex = 0;

  final List<Map<String, String>> _playlist = [
    {
      'title': 'Song 1',
      'artist': 'Artist 1',
      'url':
          'https://upos-hz-mirrorakam.akamaized.net/upgcxcode/49/83/1316078349/1316078349-1-30232.m4s?e=ig8euxZM2rNcNbdlhoNvNC8BqJIzNbfqXBvEqxTEto8BTrNvN0GvT90W5JZMkX_YN0MvXg8gNEV4NC8xNEV4N03eN0B5tZlqNxTEto8BTrNvNeZVuJ10Kj_g2UB02J0mN0B5tZlqNCNEto8BTrNvNC7MTX502C8f2jmMQJ6mqF2fka1mqx6gqj0eN0B599M=&uipk=5&nbs=1&deadline=1734548026&gen=playurlv2&os=akam&oi=3528431107&trid=a3e671f2453248e29bb61f3aed516ca5u&mid=0&platform=pc&og=cos&upsig=95dfbd8a68eb34c7a4c542eae5a8f0b7&uparams=e,uipk,nbs,deadline,gen,os,oi,trid,mid,platform,og&hdnts=exp=1734548026~hmac=9bc2c518e81c57eac675019be99e141e74dd1a7eca5e1b457cad45c41de6e1f1&bvc=vod&nettype=0&orderid=1,2&buvid=&build=0&f=u_0_0&agrr=0&bw=13349&logo=40000000',
    },
    {
      'title': 'Song 2',
      'artist': 'Artist 2',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    },
    {
      'title': 'Song 3',
      'artist': 'Artist 3',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _loadCurrentSong();
  }

  Future<void> _loadCurrentSong() async {
    try {
      final file = await DefaultCacheManager().getSingleFile(
        _playlist[_currentIndex]['url']!,
        headers: {
          'Referer': 'https://www.bilibili.com',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36',
        },
      );
      await _audioPlayer.setFilePath(file.path);
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void _play() {
    _audioPlayer.play();
  }

  void _pause() {
    _audioPlayer.pause();
  }

  void _next() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    });
    _loadCurrentSong();
    _play();
  }

  void _previous() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    });
    _loadCurrentSong();
    _play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = _playlist[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentSong['title']!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            currentSong['artist']!,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous),
                iconSize: 48,
                onPressed: _previous,
              ),
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final playing = playerState?.playing ?? false;
                  if (playing) {
                    return IconButton(
                      icon: Icon(Icons.pause),
                      iconSize: 64,
                      onPressed: _pause,
                    );
                  } else {
                    return IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 64,
                      onPressed: _play,
                    );
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                iconSize: 48,
                onPressed: _next,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

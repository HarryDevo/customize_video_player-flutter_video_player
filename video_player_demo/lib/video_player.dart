import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_border_style.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_position.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_demo/video_player_pro_indicator.dart';

class VideoPlayerPage extends StatefulWidget {
  final String title;
  const VideoPlayerPage({Key? key, required this.title}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Video Player Demo', style: TextStyle(color: Colors.white),),
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => const PlayingPage(),
                ),
              );
            },
            child: const Text(
              'Play Video',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayingPage extends StatefulWidget {
  const PlayingPage({Key? key}) : super(key: key);

  @override
  _PlayingPageState createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  static const String _video = 'asset/video/sin_sisamuth.mp4';
  final VideoPlayerController _playerController =
      VideoPlayerController.asset(_video);

  bool _isPlaying = true;
  bool _isHide = false;
  bool _isSubtitle = false;
  bool _isFit = false;

  _init() async {
    await _playerController.initialize();
    setState(() {
      _playerController.play();
    });
  }

  _orientationMode() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void initState() {
    _orientationMode();
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
            overlays: []);
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isHide = !_isHide;
          });
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: _playerController.value.isInitialized
              ? Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio:
                            _isFit ? 2.0 : _playerController.value.aspectRatio,
                        child: SubTitleWrapper(
                          videoChild: VideoPlayer(_playerController),
                          subtitleController: SubtitleController(
                            subtitleUrl:
                                'https://www57.uptobox.com/dl/rO1XsLec0OhA-SSxBfns616iuEruvSHA2ovQDGCAAEWmh1nML2LiJ15ZrZNOG8WBISxgcOSEPK_TJwCkXHIesf6FAh2_1eL8F3rXo7jwRfMoXKQio4_PT6vOXS04WHJmhW1W6AnY3EBUrhFmPsElxg/The-Weeknd-Blinding-Lights-%28Audio%29.srt',
                            subtitleType: SubtitleType.srt,
                            showSubtitles: _isSubtitle,
                          ),
                          subtitleStyle: const SubtitleStyle(
                            borderStyle: SubtitleBorderStyle(
                              strokeWidth: 3.0,
                              color: Colors.black87,
                            ),
                            hasBorder: true,
                            fontSize: 18,
                            textColor: Color(0xE0FFFFFF),
                            position: SubtitlePosition(
                              bottom: 20.0,
                            ),
                          ),
                          videoPlayerController: _playerController,
                        ),
                      ),
                    ),
                    _isHide
                        ? const SizedBox()
                        : Stack(
                            children: [
                              Container(
                                height: _size.height,
                                width: _size.width,
                                color: Colors.black45,
                              ),
                              Positioned(
                                top: 8.0,
                                left: 0.0,
                                right: 0.0,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        SystemChrome.setPreferredOrientations([
                                          DeviceOrientation.portraitDown,
                                          DeviceOrientation.portraitUp,
                                        ]);
                                        SystemChrome.setEnabledSystemUIMode(
                                            SystemUiMode.immersiveSticky,
                                            overlays: []);
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      splashRadius: 1.0,
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isFit = !_isFit;
                                            });
                                          },
                                          icon: _isFit? const Icon(CupertinoIcons.arrow_left_right_square_fill,
                                              color: Colors.white) : const Icon(CupertinoIcons.arrow_left_right_square,
                                              color: Colors.white),
                                          splashRadius: 1.0,
                                        ),

                                        const SizedBox(
                                          width: 14.0,
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isSubtitle = !_isSubtitle;
                                            });

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: const Duration(
                                                    milliseconds: 1400),
                                                content: Text(
                                                  _isSubtitle
                                                      ? 'Subtitle On'
                                                      : 'Subtitle Off',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: _isSubtitle? const Icon(CupertinoIcons.chat_bubble_text_fill,
                                              color: Colors.white) : const Icon(CupertinoIcons.chat_bubble_text,
                                              color: Colors.white),
                                          splashRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: _size.height * 0.08,
                                left: _size.width * 0.05,
                                right: _size.width * 0.05,
                                child: VideoProIndicator(
                                  _playerController,
                                  allowScrubbing: true,
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () => _rewind5Second(),
                                      icon: const Icon(
                                        Icons.replay_5,
                                        size: 38,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40.0,
                                    ),
                                    IconButton(
                                      onPressed: ()=> _playPause(),
                                      icon: _isPlaying
                                          ? const Icon(
                                              CupertinoIcons.pause_solid,
                                              color: Colors.white,
                                              size: 38,
                                            )
                                          : const Icon(
                                              CupertinoIcons.play_arrow_solid,
                                              color: Colors.white,
                                              size: 38,
                                            ),
                                      splashRadius: 1.0,
                                    ),
                                    const SizedBox(
                                      width: 40.0,
                                    ),
                                    IconButton(
                                      onPressed: () => _forward5Second(),
                                      icon: const Icon(
                                        Icons.forward_5,
                                        size: 38,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Future _playPause()async{
    if (_playerController.value.isPlaying) {
      setState(() {
        _isPlaying = false;
      });
      _playerController.pause();
    } else {
      setState(() {
        _isPlaying = true;
      });
      _playerController.play();
    }
  }

  Future _rewind5Second() async {
    _goPosition(
        (currentPosition) => currentPosition - const Duration(seconds: 15));
  }

  Future _forward5Second() async {
    _goPosition(
        (currentPosition) => currentPosition + const Duration(seconds: 15));
  }

  Future _goPosition(
      Duration Function(Duration currentPosition) builder) async {
    final currentPosition = await _playerController.position;
    final newPosition = builder(currentPosition!);
    await _playerController.seekTo(newPosition);
  }
}

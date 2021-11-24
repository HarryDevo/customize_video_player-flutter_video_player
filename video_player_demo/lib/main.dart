import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player_demo/video_player.dart';

void main(){
  runApp(const MyPlayer());
}


class MyPlayer extends StatelessWidget {
  const MyPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const VideoPlayerPage(title: 'Video Player'),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ockams_razor/src/utils/utils.dart';
import 'package:video_player/video_player.dart';

class AnimationInit extends StatefulWidget {
  @override
  _AnimationInitState createState() => _AnimationInitState();
}

class _AnimationInitState extends State<AnimationInit> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    // _controller = VideoPlayerController.network(
    //     "https://github.com/Soumraked/Ockam-s-Razor/blob/main/assets/Introreal.mp4");
    // _controller = VideoPlayerController.asset("assets/introreal.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(1.0);
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          route();
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  route() {
    setPrefsBool('initAnimation', true);
    Navigator.pushNamed(context, '/');
  }
}

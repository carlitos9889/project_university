// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _isPlay = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/movies/bienvenida.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 100),
          _controller.value.isInitialized
              ? Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_isPlay == false) {
                _animationController.forward();
                _isPlay = true;
              } else {
                _animationController.reverse();
                _isPlay = false;
              }
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            style: ElevatedButton.styleFrom(),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _animationController,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

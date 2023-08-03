library af_video;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:af_video/video_widget/main.dart';
import 'video_singleton.dart';

class VideoController {
  VideoPlayerController controller;
  Function changeFull;
  Function seekTo;
  Duration duration;
  Duration position;
  Function play;
  Function pause;

  VideoController({
    required this.controller,
    required this.changeFull,
    required this.seekTo,
    required this.duration,
    required this.position,
    required this.play,
    required this.pause,
  });
}

// ignore: library_private_types_in_public_api
GlobalKey<_AfVideoState> videoKey = GlobalKey();

class AfVideo extends StatefulWidget {
  final String? url;
  final double? aspectRatio;
  final Function? onDone;
  final bool control;
  final bool autoplay;
  final bool isFull;
  final Function(VideoController)? onController;
  const AfVideo({
    super.key,
    this.url = '',
    this.aspectRatio = 16 / 9,
    this.onDone,
    this.control = true,
    this.autoplay = false,
    this.isFull = false,
    this.onController,
  });

  @override
  State<AfVideo> createState() => _AfVideoState();
}

class _AfVideoState extends State<AfVideo> {
  String _videoUrl = '';
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  Future<void> _playVideo() async {
    await _controller?.play();
  }

  Future<void> _pauseVideo() async {
    await _controller?.pause();
  }

  Future<void> _disposeVideo() async {
    await _controller?.dispose();
  }

  void _onVideoListener() {}

  void _changeVideo(String newUrl) async {
    await _pauseVideo();
    await _disposeVideo();
    setState(() {
      _videoUrl = newUrl;
      _controller = VideoPlayerController.networkUrl(Uri.parse(_videoUrl));
      _initializeVideoPlayerFuture = _controller!.initialize();
      controllerSingleton.controller = _controller;
      _controller!.addListener(() {
        _onVideoListener();
      });
      if (widget.onController != null) {
        VideoController customController = VideoController(
          controller: _controller!,
          changeFull: () => videoWidgetKey.currentState!.onChangeFull(),
          seekTo: _controller!.seekTo,
          duration: _controller!.value.duration,
          position: _controller!.value.position,
          play: _controller!.play,
          pause: _controller!.pause,
        );
        widget.onController!(customController);
      }
      if (widget.autoplay == true) {
        _playVideo();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disposeVideo();
    ControllerSingleton.clearInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoUrl != widget.url) {
      _changeVideo(widget.url!);
    }
    if (widget.url == '' || _controller == null) {
      return Container();
    }

    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (widget.onDone != null) {
            widget.onDone!(true);
          }
          return VideoWidget(
            key: videoWidgetKey,
            isFull: widget.isFull,
            control: widget.control,
          );
        } else {
          if (widget.onDone != null) {
            widget.onDone!(false);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

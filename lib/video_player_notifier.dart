import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_singleton.dart';

class VideoPlayerNotifier {
  final VideoPlayerController controller;
  late final ValueNotifier<VideoPlayerValue> notifier;

  VideoPlayerNotifier(this.controller) {
    notifier = ValueNotifier(controller.value);
    controller.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    notifier.value = controller.value;
  }

  void dispose() {
    controller.removeListener(_videoPlayerListener);
    notifier.dispose();
  }
}

class VideoStateWidget extends StatefulWidget {
  final Widget Function(
      BuildContext context, VideoPlayerValue value, Widget? child) child;
  const VideoStateWidget({super.key, required this.child});

  @override
  State<VideoStateWidget> createState() => _VideoStateWidgetState();
}

class _VideoStateWidgetState extends State<VideoStateWidget> {
  VideoPlayerNotifier? _videoPlayerNotifier;

  @override
  void initState() {
    super.initState();
    _videoPlayerNotifier = VideoPlayerNotifier(controllerSingleton.controller!);
  }

  @override
  void dispose() {
    _videoPlayerNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _videoPlayerNotifier!.notifier,
      builder: (context, value, child) {
        return widget.child(context, value, child);
      },
    );
  }
}

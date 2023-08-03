import 'package:af_video/video_singleton.dart';
import 'package:flutter/material.dart';

class RewindWidget extends StatefulWidget {
  const RewindWidget({super.key});

  @override
  State<RewindWidget> createState() => _RewindWidgetState();
}

class _RewindWidgetState extends State<RewindWidget> {
  void _click() {
    if (controllerSingleton.controller!.value.isInitialized) {
      final currPosition = controllerSingleton.controller!.value.position;
      controllerSingleton.controller!
          .seekTo(Duration(seconds: currPosition.inSeconds - 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          _click();
        },
        child: const Icon(
          Icons.fast_rewind,
          size: 24,
        ),
      ),
    );
  }
}

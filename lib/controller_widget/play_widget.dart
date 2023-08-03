import 'package:af_video/video_singleton.dart';
import 'package:flutter/material.dart';
import 'package:af_video/video_player_notifier.dart';

class PlayWidget extends StatefulWidget {
  final Function? onClick;
  const PlayWidget({
    super.key,
    this.onClick,
  });

  @override
  State<PlayWidget> createState() => _PlayWidgetState();
}

class _PlayWidgetState extends State<PlayWidget> {
  void _click() {
    controllerSingleton.controller!.value.isPlaying
        ? controllerSingleton.controller!.pause()
        : controllerSingleton.controller!.play();

    if (widget.onClick != null) {
      widget.onClick!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VideoStateWidget(
      child: (context, value, child) {
        return GestureDetector(
          onTap: () {
            _click();
          },
          child: Icon(
            value.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
            size: 24,
          ),
        );
      },
    );
  }
}

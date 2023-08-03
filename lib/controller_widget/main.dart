import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'controller_widget.dart';
import 'package:af_video/video_singleton.dart';

class VideoContainerWidget extends StatefulWidget {
  final bool isFull;
  final bool control;
  final Function onChangeFull;
  const VideoContainerWidget({
    super.key,
    required this.onChangeFull,
    this.isFull = false,
    this.control = true,
  });

  @override
  State<VideoContainerWidget> createState() => _VideoContainerWidgetState();
}

class _VideoContainerWidgetState extends State<VideoContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controllerSingleton.controller!.value.hasError
          ? 16 / 9
          : controllerSingleton.controller!.value.aspectRatio,
      child: controllerSingleton.controller!.value.hasError
          ? const Center(
              child: Text(
                '视频出错',
                style: TextStyle(color: Colors.white),
              ),
            )
          : Stack(
              children: [
                const SizedBox(width: double.infinity, height: double.infinity),
                VideoPlayer(controllerSingleton.controller!),
                widget.control
                    ? Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ControllerWidget(
                          isFull: widget.isFull,
                          onChangeFull: widget.onChangeFull,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
    );
  }
}

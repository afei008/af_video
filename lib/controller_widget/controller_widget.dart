import 'dart:async';
import 'package:af_video/video_player_notifier.dart';
import 'package:af_video/video_singleton.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'full_widget.dart';
import 'mask_widget.dart';
import 'progress_widget.dart';
import 'back_widget.dart';
import 'play_widget.dart';
import 'rewind_widget.dart';

final logger = Logger();

class ControllerWidget extends StatefulWidget {
  final bool isFull;
  final Function onChangeFull;
  const ControllerWidget({
    super.key,
    required this.onChangeFull,
    this.isFull = false,
  });

  @override
  State<ControllerWidget> createState() => _ControllerWidgetState();
}

class _ControllerWidgetState extends State<ControllerWidget> {
  var _isShowMask = false;
  var _isShowController = true;
  Timer? _timer;

  void _showMask() {
    setState(() {
      _isShowMask = true;
    });
  }

  void _hideMask() {
    setState(() {
      _isShowMask = false;
    });
  }

  void _showController() {
    setState(() {
      _isShowController = true;
    });
  }

  void _hideController() {
    setState(() {
      _isShowController = false;
    });
  }

  void _clickMask() {
    if (_isShowMask) {
      _hideMask();
      _showController();
    } else {
      _showMask();
      _hideController();
    }
  }

  void _clickPlay() {
    if (controllerSingleton.controller!.value.isPlaying) {
      _playVideo();
    } else {
      _pauseVideo();
    }
  }

  void _playVideo() {
    _hideMask();
    _showController();
    _timer = Timer(const Duration(seconds: 5), () {
      _hideController();
      _showMask();
    });
  }

  void _pauseVideo() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoStateWidget(
      child: (context, value, child) {
        bool isStop() {
          if (value.position >= value.duration) {
            return true;
          }
          return false;
        }

        if (_isShowMask && !isStop()) {
          return MaskWidget(onClick: _clickMask);
        }

        if (_isShowController || isStop()) {
          return IconTheme(
            data: const IconThemeData(
              color: Colors.white,
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  MaskWidget(onClick: _clickMask),
                  BackWidget(
                    onChangeFull: widget.onChangeFull,
                    isFull: widget.isFull,
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlayWidget(onClick: _clickPlay),
                        const RewindWidget(),
                        const Expanded(
                          child: ProgressWidget(),
                        ),
                        FullWidget(
                          isFull: widget.isFull,
                          onChangeFull: widget.onChangeFull,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

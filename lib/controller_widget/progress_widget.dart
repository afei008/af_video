import 'package:af_video/video_singleton.dart';
import 'package:flutter/material.dart';
import 'package:af_video/video_player_notifier.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({
    super.key,
  });

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  String _formatDuration(Duration duration) {
    if (duration.inHours == 0) {
      return '${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.toString().padLeft(2, '0')}';
    }
    return '${duration.inHours}:${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return VideoStateWidget(
      child: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(value.position),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                decoration: TextDecoration.none,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: LayoutBuilder(builder: (context, constraints) {
                  final width = constraints.maxWidth + 12;
                  final ratio =
                      value.position.inSeconds / value.duration.inSeconds;
                  return Stack(
                    children: [
                      SizedBox(
                        height: 30,
                        width: width,
                      ),
                      Positioned.fill(
                        top: 0,
                        left: 0,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12),
                          ),
                          child: Slider(
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            value: ratio.isNaN ? 0 : ratio,
                            onChanged: (v) {
                              double duration;
                              duration = v * value.duration.inSeconds;
                              controllerSingleton.controller!
                                  .seekTo(Duration(seconds: duration.toInt()));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Text(
              _formatDuration(value.duration),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        );
      },
    );
  }
}

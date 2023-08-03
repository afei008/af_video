import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './small_video_widget.dart';
import './full_video_widget.dart';

// ignore: library_private_types_in_public_api
GlobalKey<_VideoWidgetState> videoWidgetKey = GlobalKey();

class VideoWidget extends StatefulWidget {
  final bool isFull;
  final bool control;
  const VideoWidget({
    super.key,
    this.isFull = false,
    this.control = true,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  bool _isFull = false;

  void _landscape() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    showDialog(
      context: context,
      builder: (context) {
        return FullVideoWidget(
          onChangeFull: onChangeFull,
          control: widget.control,
        );
      },
    );
  }

  void _portrait() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Navigator.of(context).pop();
  }

  void onChangeFull() {
    setState(() {
      _isFull = !_isFull;
      if (_isFull) {
        _landscape();
      } else {
        _portrait();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isFull = widget.isFull;
    if (_isFull) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _landscape();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFull) {
      return const SizedBox();
    } else {
      return SmallVideoWidget(
        onChangeFull: onChangeFull,
        control: widget.control,
      );
    }
  }
}

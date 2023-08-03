import 'package:flutter/material.dart';
import 'package:af_video/controller_widget/main.dart';

class FullVideoWidget extends StatefulWidget {
  final Function onChangeFull;
  final bool control;
  const FullVideoWidget({
    super.key,
    required this.onChangeFull,
    this.control = true,
  });

  @override
  State<FullVideoWidget> createState() => _FullVideoWidgetState();
}

class _FullVideoWidgetState extends State<FullVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: VideoContainerWidget(
              isFull: true,
              control: widget.control,
              onChangeFull: widget.onChangeFull,
            ),
          ),
        ),
      ),
      onWillPop: () async {
        widget.onChangeFull();
        return false;
      },
    );
  }
}

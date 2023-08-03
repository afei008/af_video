import 'package:flutter/material.dart';
import 'package:af_video/controller_widget/main.dart';

class SmallVideoWidget extends StatefulWidget {
  final bool control;
  final Function onChangeFull;
  const SmallVideoWidget({
    super.key,
    required this.onChangeFull,
    this.control = true,
  });

  @override
  State<SmallVideoWidget> createState() => _SmallVideoWidgetState();
}

class _SmallVideoWidgetState extends State<SmallVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: VideoContainerWidget(
        isFull: false,
        control: widget.control,
        onChangeFull: widget.onChangeFull,
      ),
    );
  }
}

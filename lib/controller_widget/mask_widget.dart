import 'package:flutter/material.dart';

class MaskWidget extends StatefulWidget {
  final Function onClick;
  const MaskWidget({super.key, required this.onClick});

  @override
  State<MaskWidget> createState() => _MaskWidgetState();
}

class _MaskWidgetState extends State<MaskWidget> {
  void _clickMask() {
    widget.onClick();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _clickMask();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
      ),
    );
  }
}

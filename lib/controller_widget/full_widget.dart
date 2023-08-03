import 'package:flutter/material.dart';

class FullWidget extends StatefulWidget {
  final bool isFull;
  final Function onChangeFull;
  const FullWidget({
    super.key,
    this.isFull = false,
    required this.onChangeFull,
  });

  @override
  State<FullWidget> createState() => _FullWidgetState();
}

class _FullWidgetState extends State<FullWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: () {
          widget.onChangeFull();
        },
        child: Icon(
          widget.isFull == true ? Icons.fullscreen_exit : Icons.fullscreen,
          size: 24,
        ),
      ),
    );
  }
}

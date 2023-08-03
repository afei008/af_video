import 'package:flutter/material.dart';

class BackWidget extends StatefulWidget {
  final Function onChangeFull;
  final bool isFull;
  const BackWidget({
    super.key,
    required this.onChangeFull,
    this.isFull = false,
  });

  @override
  State<BackWidget> createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isFull) {
      return const SizedBox();
    }
    return Positioned(
      top: 8,
      left: 8,
      child: GestureDetector(
        onTap: () {
          widget.onChangeFull();
        },
        child: const Icon(
          Icons.arrow_back,
          size: 24,
        ),
      ),
    );
  }
}

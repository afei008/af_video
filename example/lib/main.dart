import 'package:flutter/material.dart';
import 'package:af_video/af_video.dart';

Map<String, dynamic> video = {
  'id': 'id1',
  'title': '预告/课程介绍',
  'progress': 100,
  'img': 'assets/thumb-big.jpg',
  'url':
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly1.mp4',
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VideoController? _controller;
  bool isFull = false;
  void onController(controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              AfVideo(
                key: videoKey,
                url: video['url'],
                onController: onController,
              ),
              ElevatedButton(
                onPressed: () {
                  _controller?.play();
                },
                child: const Text('play'),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller?.pause();
                },
                child: const Text('pause'),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller?.changeFull();
                },
                child: const Text('full'),
              ),
              Text('$isFull')
            ],
          ),
        ),
      ),
    );
  }
}

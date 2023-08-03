import 'package:video_player/video_player.dart';

class ControllerSingleton {
  static ControllerSingleton? _instance;
  VideoPlayerController? controller;

  factory ControllerSingleton() {
    _instance ??= ControllerSingleton.__internal();
    return _instance!;
  }

  ControllerSingleton.__internal();

  static void clearInstance() {
    _instance = null;
  }
}

final controllerSingleton = ControllerSingleton();

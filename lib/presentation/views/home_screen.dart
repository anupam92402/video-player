import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  Future initializeVideo() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    log(Uri.parse(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        .toString());
    await _videoPlayerController?.initialize();
    log(_videoPlayerController?.value.isInitialized.toString() ??
        'Video Player Controller not initialised');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
    );

    setState(() {});
  }

  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Chewie(
        controller: _chewieController ??
            ChewieController(
                videoPlayerController: _videoPlayerController!,
                autoInitialize: true,
                autoPlay: true),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}

// FutureBuilder(
//         future: initializeVideo(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Chewie(
//               controller: _chewieController ??
//                   ChewieController(
//                       videoPlayerController: _videoPlayerController!,
//                       autoInitialize: true,
//                       autoPlay: true),
//             );
//           } else if (snapshot.hasError) {
//             return ListView(
//               children: [
//                 const Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Error: ${snapshot.error}'),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       )

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class StatusVideoItem extends StatefulWidget {
  final String uri;

  const StatusVideoItem({super.key, required this.uri});

  @override
  State<StatusVideoItem> createState() => _StatusVideoItemState();
}

class _StatusVideoItemState extends State<StatusVideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
    VideoPlayerController.contentUri(Uri.parse(widget.uri))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),
          IconButton(
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
          ),
        ],
      ),
    );
  }
}

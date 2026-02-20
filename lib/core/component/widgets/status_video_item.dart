import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:statusly/core/styles/app_colors.dart';
import 'package:statusly/core/styles/app_dimensions.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class StatusVideoItem extends StatefulWidget {
  final String uri;
  final bool isShowButton;
  const StatusVideoItem({super.key, required this.uri,required this.isShowButton});

  @override
  State<StatusVideoItem> createState() => _StatusVideoItemState();
}

class _StatusVideoItemState extends State<StatusVideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState(){
    super.initState();

    _controller = VideoPlayerController.contentUri(Uri.parse(widget.uri))
      ..initialize().then((_) {
        setState(() {
          widget.isShowButton ? _controller.play() : _controller.pause();
        });
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
      return const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen,));
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),
          widget.isShowButton ? IconButton(
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

          ) : SizedBox.shrink(),
          widget.isShowButton ?   Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true, // Allows users to seek
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.spacing_8,vertical: AppDimensions.spacing_4),
              colors: VideoProgressColors(playedColor: AppColors.primaryGreen,backgroundColor: AppColors.grey500)
            ),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}

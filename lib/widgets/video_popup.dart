import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPopup extends StatefulWidget {
  final String videoUrl;

  const VideoPopup({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPopupState createState() => _VideoPopupState();
}

class _VideoPopupState extends State<VideoPopup> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Extract the video ID from the URL
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(autoPlay: true, mute: false),
      );
    } else {
      // Handle error: invalid URL
      _controller = YoutubePlayerController(
        initialVideoId: '', // fallback video or error handling
        flags: YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back navigation while video is playing
      child: Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.all(16),
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(controller: _controller),
          builder: (context, player) {
            return Stack(
              children: [
                player, // Display the video player
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

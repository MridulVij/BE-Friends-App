import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShortVideos extends StatefulWidget {
  const ShortVideos({Key? key}) : super(key: key);

  @override
  State<ShortVideos> createState() => _ShortVideosState();
}

class _ShortVideosState extends State<ShortVideos> {
  List<String> videoIds = [
    'fphKTt5SaBw',
    'IbJNUrF8b34',
    '_8SWEj7Y8qE',
    'rDlXlJbb4H0',
    'ZdhXi7lW1Oo',
    'XKgpnhjclH0',
    'Zjw7kzLbt0c'
    // Add more video IDs as needed ONLY OF SHORTS!!!
  ];
  int currentVideoIndex = 0;
  late YoutubePlayerController _controller;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();

    // Shuffle the videoIds list to randomize the order
    videoIds.shuffle();

    _controller = YoutubePlayerController(
      initialVideoId: videoIds[currentVideoIndex],
      flags: YoutubePlayerFlags(
        loop: true,
        mute: false,
        autoPlay: true, // Autoplay the first video
        forceHD: false,
        controlsVisibleAtStart: false,
        isLive: false,
        hideControls: true,
        useHybridComposition: true,
      ),
    )..addListener(_videoListener);
  }

  void _videoListener() {
    if (_controller.value.isReady && !_controller.value.isFullScreen) {
      setState(() {
        // Pause other videos and play the current one
        for (int i = 0; i < videoIds.length; i++) {
          if (i != currentVideoIndex) {
            YoutubePlayerController(initialVideoId: videoIds[i]).pause();
          }
        }
      });
    }

  }

  void _playNextVideo() {
    setState(() {
      isPaused = false;
    });
    if (currentVideoIndex < videoIds.length - 1) {
      setState(() {
        currentVideoIndex++;
      });
    } else {
      // If we're at the last video, go back to the first video and shuffle again
      videoIds.shuffle();
      setState(() {
        currentVideoIndex = 0;
      });
    }
    // Load and play the new video
    _controller.load(videoIds[currentVideoIndex]);
    _controller.play();
  }

  void _playPreviousVideo() {
    setState(() {
      isPaused = false;
    });
    if (currentVideoIndex > 0) {
      setState(() {
        currentVideoIndex--;
      });
    } else {
      // If we're at the first video, go to the last video and shuffle again
      videoIds.shuffle();
      setState(() {
        currentVideoIndex = videoIds.length - 1;
      });
    }
    // Load and play the new video
    _controller.load(videoIds[currentVideoIndex]);
    _controller.play();
  }

  void _togglePause() {
    if (isPaused) {
      _controller.play();
    } else {
      _controller.pause();
    }
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QuickBytes",style: TextStyle(fontWeight:FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: false,
                progressIndicatorColor: Colors.deepPurple,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: _playPreviousVideo,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.skip_previous),
              ),
              FloatingActionButton(
                backgroundColor: Colors.deepPurple,
                onPressed: _togglePause,
                child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
              ),
              FloatingActionButton(
                backgroundColor: Colors.deepPurple,
                onPressed: _playNextVideo,
                child: Icon(Icons.skip_next),
              ),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



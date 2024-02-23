import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube/data.dart';
import 'package:youtube/screens/nav_screen.dart';
import 'package:youtube/widgets/widgets.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController? _controller;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _controller = YoutubePlayerController(
      initialVideoId: 'Tb9k9_Bo-G4',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        isLive: false,
        controlsVisibleAtStart: true
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
            controller: _scrollController,
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Consumer(
                  builder: (context, watch, _) {
                    final selectedVideo = watch(selectedVideoProvider).state;
                    return SafeArea(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                                YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: selectedVideo!.id,
                                    flags: YoutubePlayerFlags(
                                      autoPlay: true,
                                      mute: false,
                                      hideThumbnail: true,
                                    ),
                                  ),
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.amber,
                                  progressColors: ProgressBarColors(
                                    playedColor: Colors.amber,
                                    handleColor: Colors.amberAccent,
                                  ),
                                ),
                              IconButton(
                                iconSize: 30.0,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () => context
                                    .read(miniPlayerControllerProvider)
                                    .state
                                    .animateToHeight(state: PanelState.MIN),
                              ),
                            ],
                          ),

                          VideoInfo(video: selectedVideo),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final video = suggestedVideos[index];
                    return VideoCard(
                      video: video,
                      hasPadding: true,
                      onTap: () => _scrollController!.animateTo(
                        0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      ),
                    );
                  },
                  childCount: suggestedVideos.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

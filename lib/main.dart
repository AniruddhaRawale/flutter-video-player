import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Video Example",
      home: VideoExample(),
    );
  }
}

class VideoExample extends StatefulWidget {
  @override
  _VideoExampleState createState() => _VideoExampleState();
}

class _VideoExampleState extends State<VideoExample> {

  //allows us to control how we deal with video players
  VideoPlayerController playerController;
  //void call back means it has no arguments
  // and no return value
  VoidCallback listener;

  @override
  void initState(){
    super.initState();
    listener = () {
      //when video receives data from platform
      // it automatically updates our widget
      //so every frame of video we receive
      // it will update and makes our video experience smoother
      setState(() {

      });
    };
    }

    void createVideo(){
    if(playerController == null){
      playerController = VideoPlayerController.asset("assets/videos/1.mp4")
      //to instantitate video player listener
          ..addListener(listener)
        //to set te volume 1.0 => loudest 0.0 => lowest(mute)
          ..setVolume(1.0)
        //to initialize the controller
          ..initialize()
          ..play();
    }else{
      if(playerController.value.isPlaying){
        playerController.pause();
      }else{
        playerController.initialize();
        playerController.play();
      }
    }
    }

    @override
    void deactivate(){
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Example"),
      ),
      body: Center(
         child:AspectRatio(
           aspectRatio: 16 / 9 ,
           child: Container(
             child: (playerController != null
             ?VideoPlayer(
               //if video player doesnt exist we will create one
               // ie playercontroller widget is activated
                 playerController,
             ):Container()
             ),
           ),
         )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          createVideo();
          playerController.play();
        },
        child: Icon(Icons.play_arrow)
        ),
      );
  }
}

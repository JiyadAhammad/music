import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/module_1/home_widget.dart';
import 'package:music/module_2/nowplaying_widget.dart';
import 'package:music/module_2/volume_slider.dart';
import 'package:music/module_4/playlist_screen.dart';
import 'package:music/module_4/playlist_songs_screen.dart';
import 'package:music/module_4/playlist_widget.dart';

class NowPlayingDesigns extends StatefulWidget {
  const NowPlayingDesigns({Key? key}) : super(key: key);

  @override
  State<NowPlayingDesigns> createState() => _NowPlayingDesignsState();
}

class _NowPlayingDesignsState extends State<NowPlayingDesigns>
    with TickerProviderStateMixin {
  //  AudioPlayer audioPlayer = AudioPlayer();
  dynamic totalDuration = "00:00";
  Duration position = Duration();
  bool expanded = true;
  late AnimationController controller;
  // dynamic position1 = "00:00";
  // String? audioState;
  // Duration duration = Duration();
  int _value = 6;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 400),
      reverseDuration: Duration(microseconds: 400),
    );
  }

  //  initAudio() {
  //   audioPlayer.onDurationChanged.listen((updatedDuration) {
  //     setState(() {
  //       totalDuration = updatedDuration;
  //     });
  //   });
  //   audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
  //     setState(() {
  //       position = updatedPosition;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          bigBlankSpace,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 280,
            width: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: AssetImage(
                  'lib/assets/bheeshma.jpeg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          bigBlankSpace,
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: listtiles(),
          ),
          Slider(
              value: _value.toDouble(),
              min: 1.0,
              max: 20.0,
              divisions: 10,
              activeColor: textWhite,
              inactiveColor: textGrey,
              // label: '',
              onChanged: (double newValue) {
                setState(() {
                  _value = newValue.round();
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()} dollars';
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  position.toString().split(".").first,
                  style: TextStyle(color: textWhite),
                ),
                Text(totalDuration.toString().split(".").first,
                    style: TextStyle(color: textWhite)),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          addAndVol(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      color: textWhite,
                      size: 40,
                    )),
              ),
              smallwidth,

// play and pause

              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: textWhite, borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: controller,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      expanded ? controller.forward() : controller.reverse();
                      expanded = !expanded;
                    });
                  },
                ),
              ),
              smallwidth,
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_next_rounded,
                      color: textWhite,
                      size: 40,
                    )),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

Widget bigBlankSpace = SizedBox(
  height: 80,
);

Widget smallwidth = SizedBox(
  width: 30,
);

// row

Widget listtiles() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              EvaIcons.shuffle2,
              color: textWhite,
              size: 30,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Parudheesa',
              style: TextStyle(fontSize: 22, color: textWhite),
            ),
            Text(
              'sree nadh bhaasi',
              style: TextStyle(color: textGrey, fontSize: 14),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              EvaIcons.heart,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
      ],
    ),
  );
}

// vol and add

Widget addAndVol(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50)),
            child: MyVolumeUp()
            //  child: IconButton(
            //       onPressed: () {MyVolumeUp();
            //       },
            //       icon: Icon(
            //         Icons.volume_up,
            //         color: textWhite,
            //         size: 30,
            //       )),
            ),
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: () {
                PlayListShowBottomSheet(context);
              },
              icon: Icon(
                Icons.add,
                size: 30,
                color: textWhite,
              )),
        )
      ],
    ),
  );
}

createPlaylistShowAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel", style: TextStyle(color: textWhite, fontSize: 16)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Save", style: TextStyle(color: textWhite, fontSize: 16)),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: darkBlue,
    alignment: Alignment.center,
    title: Center(
        child: Text(
      "Give Your Playlist Name",
      style: TextStyle(color: textWhite),
    )),
    content: TextFormField(
      decoration: InputDecoration(),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

PlayListShowBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: lightBlue,
      context: context,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: boxtColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
          height: 300,
          width: double.infinity,
          child: playListBotttom(context),
        );
      });
}

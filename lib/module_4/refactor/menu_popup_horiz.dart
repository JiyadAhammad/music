import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:music/module_4/refactor/read_add_playlist.dart';
import 'package:music/module_4/refactor/create_playlist.dart';

class MenuHoriz extends StatelessWidget {
  final String songId;
  MenuHoriz({Key? key, required this.songId}) : super(key: key);

  final box = PlaylistBox.getInstance();

  List<SongsModel> dbSongs = [];
  List<Audio> fullsong = [];
  List playlist = [];
  List<dynamic> playlistSongs = [];
  @override
  Widget build(BuildContext context) {

    dbSongs = box.get("music") as List<SongsModel>;
    final playlistName = databaseSongs(dbSongs, songId);

    return PopupMenuButton(
      color: darkBlue,
      icon: Icon(
        Icons.more_vert_outlined,
        color: textWhite,
      ), //don't specify icon if you want 3 dot menu
      // color: Colors.blue,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {},
          value: 0,
          child: Text(
            "Add to Playlist",
            style: TextStyle(color: textWhite),
          ),
        ),
        PopupMenuItem(
          onTap: () {},
          value: 1,
          child: Text(
            "View Details",
            style: TextStyle(color: textWhite),
          ),
        ),
        PopupMenuItem(
          onTap: () {},
          value: 2,
          child: Text(
            "Delete Song",
            style: TextStyle(color: textWhite),
          ),
        ),
      ],
      onSelected: (item) => {
        if (item == 0)
          {
            PlayListShowBottomSheet(context, playlistName),
          }
      },
    );
  }

  SongsModel databaseSongs(List<SongsModel> songs, String id) {
    return songs.firstWhere(
      (element) => element.songurl.toString().contains(id),
    );
  }
}

PlayListShowBottomSheet(BuildContext context, playlistName) {
  return showModalBottomSheet(
      backgroundColor: black,
      context: context,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(25.0.w.h),
              topRight: Radius.circular(25.w.h),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),
          height: 300.h,
          width: double.infinity,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                 children: [
                     PlayListItem(
                      song: playlistName,
                      countSong: "song",
                    )]
                )
                ,

                //  floatting
                Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CreatePlaylistForm();
                          },
                        );
                      },
                      backgroundColor: darkBlue,
                      child: Icon(Icons.add),
                    ))
              ],
            ),
          ),
        );
      });
}

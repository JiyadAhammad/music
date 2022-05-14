import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/dbFunction/songmodel.dart';
import 'package:music/main.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddSongFavourites extends StatefulWidget {
  // List favSongsList;

  AddSongFavourites({
    Key? key,
    // required this.favSongsList,
  }) : super(key: key);

  @override
  State<AddSongFavourites> createState() => _AddSongFavouritesState();
}

class _AddSongFavouritesState extends State<AddSongFavourites> {
  final box = PlaylistBox.getInstance();
  List<SongsModel> dbSong = [];
  List<SongsModel> favSongs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbSong = box.get("music") as List<SongsModel>;
    favSongs = box.get("favourites")!.cast<SongsModel>();
  }

  @override
  Widget build(BuildContext context) {
    // final dbSong=
    return  ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: ((context, value, child) {
            return ListView.builder(
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                       EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: ListTile(
                      tileColor: boxColor,
                      leading: QueryArtworkWidget(
                        id: dbSong[index].id!,
                        type: ArtworkType.AUDIO,
                        artworkHeight: 55.h,
                        artworkWidth: 55.w,
                      ),
                      title: Padding(
                        padding:
                             EdgeInsets.only(left: 5.0.w, bottom: 3.h, top: 3.h),
                        child: Text(
                          dbSong[index].songname!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textWhite, fontSize: 18.w.h),
                        ),
                      ),
                      subtitle: Padding(
                        padding:  EdgeInsets.only(left: 7.0.w),
                        child: Text(
                          dbSong[index].artist!.toLowerCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: textGrey),
                        ),
                      ),
                      trailing: favSongs
                              .where((element) =>
                                  element.id.toString() ==
                                  dbSong[index].id.toString())
                              .isEmpty
                          ? StatefulBuilder(builder: (context, setState) {
                            return IconButton(
                                onPressed: () {
                                 favSongs.add(dbSong[index]);
                                  box.put("favourites", favSongs);
                                  setState(() { });
                                },
                                icon:  Icon(
                                  Icons.favorite,
                                  size: 35.w.h,
                                  color: Colors.white,
                                ));}
                          )
                          : IconButton(
                              onPressed: () {
                                favSongs.removeWhere((element) =>
                                    element.id.toString() ==
                                    dbSong[index].id.toString());
                                box.put("favourites", favSongs);
                                setState(() {});
                              },
                              icon:  Icon(Icons.favorite,
                                  size: 35.w.h, color: Colors.red))),
                );
              }),
              itemCount: dbSong.length,
            );
          }));
  
  }
}

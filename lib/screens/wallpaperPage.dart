import 'package:flutter/material.dart';
import 'package:wallpapers_app_sqllite/database/accessDatabase.dart';
import 'package:wallpapers_app_sqllite/models/wallpaperModel.dart';
import 'package:sqflite/sqlite_api.dart';

class WallpaperPage extends StatefulWidget {
  final Function callBack;
  final int id;
  const WallpaperPage({Key key, this.callBack, this.id}) : super(key: key);
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  bool delLoading = false;
  WallpaperModel wallpaperModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWallpaper(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: wallpaperModel != null ? Text(wallpaperModel.title) : Text(""),
        actions: [
          IconButton(
              icon: wallpaperModel != null
                  ? Icon(
                      Icons.star,
                      color:
                          wallpaperModel.fav == 0 ? Colors.white : Colors.amber,
                    )
                  : Container(),
              onPressed: () {
                updateFav(wallpaperModel.id);
              })
        ],
      ),
      body: wallpaperModel != null
          ? SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.network(wallpaperModel.url),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wallpaperModel.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "category: ${wallpaperModel.category}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        wallpaperModel.desc,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                              child: !delLoading
                                  ? Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : CircularProgressIndicator(),
                              color: Colors.blue,
                              onPressed: !delLoading
                                  ? () async {
                                      //delete wallpaper
                                      setState(() {
                                        delLoading = true;
                                      });
                                      await deleteWallpaper(wallpaperModel.id);
                                      widget.callBack();
                                      Navigator.pop(context);
                                      setState(() {
                                        delLoading = false;
                                      });
                                    }
                                  : () {})
                        ],
                      )
                    ],
                  ),
                )
              ],
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> deleteWallpaper(int id) async {
    Database database = await AccessDatabase.accessDatabase.getDatabase;
    database.delete('Wallpapers', where: 'id=?', whereArgs: [id]);
  }

  Future<void> getWallpaper(int id) async {
    Database database = await AccessDatabase.accessDatabase.getDatabase;
    List<Map<String, dynamic>> result =
        await database.query('Wallpapers', where: 'id=?', whereArgs: [id]);
    WallpaperModel localWallpaerObject = WallpaperModel.fromJson(result[0]);

    setState(() {
      wallpaperModel = localWallpaerObject;
    });
  }

  Future<void> updateFav(int id) async {
    Database database = await AccessDatabase.accessDatabase.getDatabase;
    await database.update(
        'Wallpapers',
        {
          "id": id,
          "url": wallpaperModel.url,
          "title": wallpaperModel.title,
          "category": wallpaperModel.category,
          "desc": wallpaperModel.desc,
          "fav": wallpaperModel.fav == 0 ? 1 : 0
        },
        where: "id=?",
        whereArgs: [id]);
    await getWallpaper(id);
  }
}

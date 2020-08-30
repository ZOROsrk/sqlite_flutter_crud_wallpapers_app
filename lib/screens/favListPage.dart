import 'package:flutter/material.dart';
import 'package:wallpapers_app_sqllite/database/accessDatabase.dart';
import 'package:wallpapers_app_sqllite/models/wallpaperModel.dart';
import 'package:wallpapers_app_sqllite/screens/addWallpaperPage.dart';
import 'package:wallpapers_app_sqllite/widgets/wallpaperCard.dart';
import 'package:sqflite/sqlite_api.dart';

class FavListPage extends StatefulWidget {
  @override
  _FavListPageState createState() => _FavListPageState();
}

class _FavListPageState extends State<FavListPage> {
  List<WallpaperModel> wallpapersList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [],
      ),
      body: Stack(
        children: [
          wallpapersList != null
              ? ListView.builder(
                  itemCount: wallpapersList.length,
                  itemBuilder: (context, index) {
                    return WallpaperCard(
                      wallpaperModel: wallpapersList[index],
                      callBack: getDataList,
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

  void getDataList() async {
    Database database = await AccessDatabase.accessDatabase.getDatabase;
    List<Map<String, dynamic>> result =
        await database.query('Wallpapers', where: "fav=1");
    print(result.toString());
    List<WallpaperModel> list = List.generate(
        result.length, (index) => WallpaperModel.fromJson(result[index]));
    setState(() {
      wallpapersList = list;
    });
  }
}

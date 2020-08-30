import 'package:flutter/material.dart';
import 'package:wallpapers_app_sqllite/database/accessDatabase.dart';
import 'package:wallpapers_app_sqllite/models/wallpaperModel.dart';
import 'package:wallpapers_app_sqllite/screens/addWallpaperPage.dart';
import 'package:wallpapers_app_sqllite/widgets/wallpaperCard.dart';
import 'package:sqflite/sqlite_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text("Wallpapers"),
      ),
      body: Stack(
        children: [
          wallpapersList != null
              ? ListView.builder(
                  itemCount: wallpapersList.length,
                  itemBuilder: (context, index) {
                    return WallpaperCard(
                      wallpaperModel: wallpapersList[index],
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddWallpaperPage(
                                    callBack: getDataList,
                                  )));
                    })),
          )
        ],
      ),
    );
  }

  void getDataList() async {
    Database database = await AccessDatabase.accessDatabase.getDatabase;
    List<Map<String, dynamic>> result = await database.query('Wallpapers');
    List<WallpaperModel> list = List.generate(
        result.length, (index) => WallpaperModel.fromJson(result[index]));

    setState(() {
      wallpapersList = list;
    });
  }
}

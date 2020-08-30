import 'package:flutter/material.dart';
import 'package:wallpapers_app_sqllite/database/accessDatabase.dart';
import 'package:sqflite/sqlite_api.dart';

class AddWallpaperPage extends StatefulWidget {
  final Function callBack;

  const AddWallpaperPage({Key key, this.callBack}) : super(key: key);
  @override
  _AddWallpaperPageState createState() => _AddWallpaperPageState();
}

class _AddWallpaperPageState extends State<AddWallpaperPage> {
  Size _size;
  TextEditingController _url;
  TextEditingController _title;
  TextEditingController _category;
  TextEditingController _desc;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = TextEditingController();
    _title = TextEditingController();
    _category = TextEditingController();
    _desc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("add new wallpaper"),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      height: _size.height * .5,
                      width: _size.width,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: TextFormField(
                                  controller: _url,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.indigo)),
                                      hintText: "image url"),
                                ),
                              ),
                              TextFormField(
                                controller: _title,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.indigo)),
                                    hintText: "image title"),
                              ),
                              TextFormField(
                                controller: _category,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.indigo)),
                                    hintText: "image category"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: TextFormField(
                                  controller: _desc,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.indigo)),
                                      hintText: "image description"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )),
                SizedBox(
                  height: 60,
                ),
                RaisedButton(
                    color: Colors.blue,
                    child: !isLoading
                        ? Text(
                            "Add Wallpaper",
                            style: TextStyle(color: Colors.white),
                          )
                        : CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                    onPressed: !isLoading
                        ? () async {
                            setState(() {
                              isLoading = true;
                            });
                            AccessDatabase accessDatabase =
                                AccessDatabase.accessDatabase;
                            Database database =
                                await accessDatabase.getDatabase;
                            await database.insert('Wallpapers', {
                              "url": _url.text,
                              "title": _title.text,
                              "category": _category.text,
                              "desc": _desc.text,
                              "fav": 0
                            });
                            print("wallpaper added");
                            setState(() {
                              isLoading = false;
                            });
                            widget.callBack();
                            Navigator.pop(context);
                          }
                        : () {}),
                SizedBox(
                  height: 10,
                ),
              ]),
        ));
  }
}

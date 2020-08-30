import 'package:flutter/material.dart';
import 'package:wallpapers_app_sqllite/models/wallpaperModel.dart';
import 'package:wallpapers_app_sqllite/screens/wallpaperPage.dart';

class WallpaperCard extends StatefulWidget {
  final WallpaperModel wallpaperModel;
  final Function callBack;

  const WallpaperCard({Key key, this.wallpaperModel, this.callBack})
      : super(key: key);
  @override
  _WallpaperCardState createState() => _WallpaperCardState();
}

class _WallpaperCardState extends State<WallpaperCard> {
  Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: _size.width,
          height: _size.height * .6,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WallpaperPage(
                            callBack: widget.callBack,
                            id: widget.wallpaperModel.id,
                          )));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.network(widget.wallpaperModel.url),
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
                          widget.wallpaperModel.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "category: ${widget.wallpaperModel.category}",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.wallpaperModel.desc,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class WallpaperModel {
  int id;
  String url;
  String title;
  String category;
  String desc;
  int fav;

  WallpaperModel(
      {this.id, this.url, this.title, this.category, this.desc, this.fav});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    category = json['category'];
    desc = json['desc'];
    fav = json['fav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['category'] = this.category;
    data['desc'] = this.desc;
    data['fav'] = this.fav;
    return data;
  }
}
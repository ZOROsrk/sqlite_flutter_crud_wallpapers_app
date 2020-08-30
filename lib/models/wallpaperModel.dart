class WallpaperModel {
  int id;
  String url;
  String title;
  String category;
  String desc;

  WallpaperModel({this.id, this.url, this.title, this.category, this.desc});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    category = json['category'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['category'] = this.category;
    data['desc'] = this.desc;
    return data;
  }
}
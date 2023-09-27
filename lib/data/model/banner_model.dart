class BannerModel {
  String? title;
  String? image;
  String? url;

  BannerModel({this.title, this.image, this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}
class WebsiteLinkModel {

  String? name;
  String? image;
  String? url;

  WebsiteLinkModel(
      {
        this.name,
        this.image,
        this.url,});

  WebsiteLinkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}

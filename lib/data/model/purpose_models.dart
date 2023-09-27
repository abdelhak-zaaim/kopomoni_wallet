// To parse this JSON data, do
//
//     final purpose = purposeFromJson(jsonString);

import 'dart:convert';

List<Purpose> purposeFromJson(String str) => List<Purpose>.from(json.decode(str).map((x) => Purpose.fromJson(x)));

// String purposeToJson(List<Purpose> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Purpose {
  Purpose({
    // this.id,
    this.title = '',
    this.logo = '',
    this.color = '#f0fff6',
    // this.createdAt,
    // this.updatedAt,
  });

  //int id;
  String? title;
  String? logo;
  String? color;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory Purpose.fromJson(Map<String, dynamic> json) => Purpose(
     //id: json["id"],
    title: json["title"],
    logo: json["logo"],
    color: json["color"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "title": title,
  //   "logo": logo,
  //   "color": color,
  //   "created_at": createdAt.toIso8601String(),
  //   "updated_at": updatedAt.toIso8601String(),
  // };
}

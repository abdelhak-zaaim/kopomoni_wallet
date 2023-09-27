
import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

class FaqModel {
  FaqModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.helpTopics,
  });

  int? totalSize;
  int? limit;
  int? offset;
  List<HelpTopic>? helpTopics;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    totalSize: json["total_size"],
    limit: json["limit"],
    offset: json["offset"],
    helpTopics: List<HelpTopic>.from(json["helpTopics"].map((x) => HelpTopic.fromJson(x))),
  );
}

class HelpTopic {
  HelpTopic({
    this.id,
    this.question,
    this.answer,
    this.ranking,
    this.createdAt,
  });

  int? id;
  String? question;
  String? answer;
  int? ranking;
  DateTime? createdAt;

  factory HelpTopic.fromJson(Map<String, dynamic> json) => HelpTopic(
    id: json["id"],
    question: json["question"] ?? '',
    answer: json["answer"] ?? '',
    ranking: json["ranking"] ?? 0,
    createdAt: DateTime.parse(json["created_at"]),
  );

}

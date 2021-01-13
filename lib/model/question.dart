import 'package:flutter/foundation.dart';

class Question {
  final String qn;
  final String vehicle;
  final String qType;
  final String category;
  final String title;
  final String image;
  // final List<dynamic> options;
  final String ansType;
  final String ans;
  final String comments;

  Question({
    @required this.qn,
    @required this.vehicle,
    @required this.qType,     // rule | sign
    @required this.title,
    // this.options,
    @required this.ansType,   // choice | bool
    @required this.ans,
    this.image,
    this.category,
    this.comments
  }) {
    assert(qn != null, 'question qa is empty');
    assert(title != null,  'question title is empty');
    assert(ans != null, 'question ans is empty');
  }

  Question.fromJson(Map<String, dynamic> json)
      : qn = json['qn'],
        vehicle = json['vehicle'],
        qType = json['qType'],
        category = json['category'] ?? '',
        title = json['title'],
        image = json['image'] ?? '',
        // options = json['options'] ?? null,
        ansType = json['ansType'],
        ans = json['ans'],
        comments = json['comments'];

  Map<String, dynamic> toJson() => {
    'qn': qn,
    'vehicle': vehicle,
    'qType': qType,
    'category': category,
    'title': title,
    'image': image,
    // 'options': options,
    'ansType': ansType,
    'ans': ans,
    'comments': comments
  };
}

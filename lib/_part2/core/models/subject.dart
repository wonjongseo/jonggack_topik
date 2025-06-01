import 'dart:convert';

import 'package:jonggack_topik/_part2/core/models/word.dart';

class Category {
  final String title;
  final List<Subject> subjects;
  Category({required this.title, required this.subjects});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'subjects': subjects.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      title: map['title'] ?? '',
      subjects: List<Subject>.from(
        map['subjects']?.map((x) => Subject.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}

class Subject {
  final String title;
  final List<Chapter> chapters; // Word 총 1600개
  Subject({required this.title, required this.chapters});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'chatper': chapters.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      title: map['title'] ?? '',
      chapters: List<Chapter>.from(
        map['chapters']?.map((x) => Chapter.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source));
}

class Chapter {
  final String title;
  final List<StepModel> steps; // Word 총 210개
  Chapter({required this.title, required this.steps});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'stpes': steps.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      title: map['title'] ?? '',
      steps: List<StepModel>.from(
        map['steps']?.map((x) => StepModel.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source));
}

class StepModel {
  final String title;
  final List<Word> words; // Word 총 15개

  StepModel({required this.title, required this.words});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'words': words.map((x) => x.toMap()).toList()});

    return result;
  }

  factory StepModel.fromMap(Map<String, dynamic> map) {
    return StepModel(
      title: map['title'] ?? '',
      words: List<Word>.from(map['words']?.map((x) => Word.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory StepModel.fromJson(String source) =>
      StepModel.fromMap(json.decode(source));
}

// To parse this JSON data, do
//
//     final mcq = mcqFromJson(jsonString);

import 'dart:convert';

Mcq mcqFromJson(String str) => Mcq.fromJson(json.decode(str));

String mcqToJson(Mcq data) => json.encode(data.toJson());

class Mcq {
  Mcq({
    required this.questions,
  });

  List<Question> questions;

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    required this.question,
    required     this.answers,
    required this.correctIndex,
  });

  String question;
  List<String> answers;
  int correctIndex;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    question: json["question"],
    answers: List<String>.from(json["answers"].map((x) => x)),
    correctIndex: json["correctIndex"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answers": List<dynamic>.from(answers.map((x) => x)),
    "correctIndex": correctIndex,
  };
}

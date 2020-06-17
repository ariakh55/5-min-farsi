import 'dart:convert';

Question questionFromJson(String str){
  final jsonData = json.decode(str);
  return Question.fromMap(jsonData);
}

String questionToJson(Question data){
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Question{
  final int qid;
  final int lid;
  final String qname;
  final String qanswer;
  final List<String> choices;
  final int score;

  Question({
    this.qid,
    this.lid,
    this.qname,
    this.qanswer,
    this.choices,
    this.score
  });

  factory Question.fromMap(Map<String, dynamic> json) => new Question(
    qid: json['QId'],
    lid: json['Lid'],
    qname: json['QName'],
    qanswer: json['QAnswers'],
    choices: json['Choices'].toString().split('،'),
    score: json['Score']
  );

  Map<String, dynamic> toMap() => {
    "QId": qid,
    "Lid": lid,
    "QName": qname,
    "QAnswers": qanswer,
    "Choices": choices.reduce((value, element) => value+'،'+element),
    "Score": score
  };
}
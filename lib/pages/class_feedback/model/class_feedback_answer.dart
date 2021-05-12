import 'package:acs_upb_mobile/pages/people/model/person.dart';

class FeedbackQuestionAnswer {
  FeedbackQuestionAnswer({
    this.questionAnswer,
    this.className,
    this.teacherName,
    this.assistant,
    this.questionNumber,
  });

  String questionAnswer;
  final String className;
  final String teacherName;
  final Person assistant;
  final String questionNumber;

  @override
  int get hashCode => questionAnswer.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is FeedbackQuestionAnswer) {
      return other.questionAnswer == questionAnswer;
    }
    return false;
  }
}

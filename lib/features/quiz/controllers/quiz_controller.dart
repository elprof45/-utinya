import 'package:get/get.dart';
import 'package:egliloo/data/datasources/local/mock_data.dart';
import 'package:egliloo/data/models/quiz_model.dart';

class QuizController extends GetxController {
  final quiz = Rxn<QuizModel>();
  final currentQuestion = 0.obs;
  final selectedAnswer = (-1).obs;
  final score = 0.obs;
  final isFinished = false.obs;
  final answers = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    final id = Get.arguments as String?;
    if (id != null) {
      quiz.value = MockData.quizzes.firstWhere(
        (q) => q.id == id,
        orElse: () => MockData.quizzes.first,
      );
    }
  }

  void selectAnswer(int i) {
    if (selectedAnswer.value != -1) return;
    selectedAnswer.value = i;
    answers.add(i);
    final q = quiz.value!.questions[currentQuestion.value];
    if (i == q.correctIndex) score.value++;
  }

  void nextQuestion() {
    if (currentQuestion.value < (quiz.value?.questions.length ?? 1) - 1) {
      currentQuestion.value++;
      selectedAnswer.value = -1;
    } else {
      isFinished.value = true;
    }
  }
}

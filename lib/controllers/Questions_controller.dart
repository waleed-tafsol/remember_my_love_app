import 'package:get/get.dart';
import 'package:remember_my_love_app/view/screens/bottom_nav_bar/Bottom_nav_bar.dart';

class Question {
  final String question;
  final List<String> answers;
  Rx<String?> selectedAnswer = Rx<String?>(null);

  Question({required this.question, required this.answers});
}

class QuestionsController extends GetxController {
  // Use RxList to hold the questions
  final RxList<Question> questions = <Question>[
    Question(
      question: "Have you been struggling with anything lately?",
      answers: ["Anxiety", "Grief", "Breakup", "Depression"],
    ),
    Question(
      question:
          "It is a long established fact that a reader will be distracted by the readable.",
      answers: ["Grief", "Anxiety", "Breakup", "Depression"],
    ),
    // Additional questions can be added here
  ].obs; // Convert the list to an observable list

  var currentQuestionIndex = 0.obs; // Track the current question index

  // Getter for the current question
  Question get currentQuestion => questions[currentQuestionIndex.value];

  void onChanged(String? value) {
    currentQuestion.selectedAnswer.value = value; // Set the selected answer
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      // showResults();
      Get.toNamed(BottomNavBarScreen.routeName);
    }
  }

  // void showResults() {
  //   Get.defaultDialog(
  //     title: "Survey Completed",
  //     content: Text("You have completed the survey!"),
  //     onConfirm: () {
  //       Get.back(); // Close the dialog
  //       Get.back(); // Optionally go back to the previous page
  //     },
  //     textConfirm: "OK",
  //   );
  // }
}

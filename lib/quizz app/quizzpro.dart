import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizzapp/quizz%20app/overallquizz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizProLevel extends StatefulWidget {
  const QuizProLevel({super.key});

  @override
  State<QuizProLevel> createState() => _QuizProLevelState();
}

class _QuizProLevelState extends State<QuizProLevel> {

  int questionIndex = 0;
  int score = 0;
  int skipCount = 1;
  int timeLeft = 30;

  Timer? timer;

  String? selectedAnswer;
  bool answered = false;

  final List<Map<String, Object>> questions = [

    {
      "question":
      "Which scientist proposed the three laws of motion?",
      "options": [
        "Isaac Newton",
        "Nikola Tesla",
        "Albert Einstein",
        "Galileo Galilei"
      ],
      "answer": "Isaac Newton"
    },

    {
      "question":
      "Which country has the largest population in the world?",
      "options": [
        "China",
        "United States",
        "India",
        "Indonesia"
      ],
      "answer": "India"
    },

    {
      "question":
      "What is the speed of light in vacuum?",
      "options": [
        "300,000 km/s",
        "299,792 km/s",
        "150,000 km/s",
        "500,000 km/s"
      ],
      "answer": "299,792 km/s"
    },

    {
      "question":
      "Which is the longest mountain range in the world?",
      "options": [
        "Himalayas",
        "Rockies",
        "Alps",
        "Andes"
      ],
      "answer": "Andes"
    },

    {
      "question":
      "Who discovered penicillin?",
      "options": [
        "Louis Pasteur",
        "Robert Koch",
        "Alexander Fleming",
        "Edward Jenner"
      ],
      "answer": "Alexander Fleming"
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 30;

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (t) {
        if (timeLeft > 0) {
          setState(() => timeLeft--);
        } else {
          nextQuestion();
        }
      },
    );
  }

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {

      setState(() {
        questionIndex++;
        selectedAnswer = null;
        answered = false;
      });

      startTimer();

    } else {
      showResult();
    }
  }

  void skipQuestion() {
    if (skipCount > 0) {
      skipCount--;
      nextQuestion();
    }
  }

  void showResult() async {

    timer?.cancel();

    double percentage =
        (score / questions.length) * 100;

    final prefs =
    await SharedPreferences.getInstance();

    bool unlocked = false;

    if (percentage >= 70) {
      await prefs.setBool('proCompleted', true);
      unlocked = true;
    }

    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (_) => AlertDialog(
        title: const Text("Quiz Finished"),

        content: Text(
          "Score: $score / ${questions.length}\n\n"
              "${percentage.toStringAsFixed(0)}%\n\n"
              "${unlocked ? "🎉 Pro Level Completed!" : "Try Again"}",
        ),

        actions: [

          /// Retry
          TextButton(
            onPressed: () {

              Navigator.pop(context);

              setState(() {
                questionIndex = 0;
                score = 0;
                skipCount = 1;
                selectedAnswer = null;
                answered = false;
              });

              startTimer();
            },

            child: const Text("Retry"),
          ),

          /// Close
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
            ),

            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PerformancePage(beginner:5, intermediate: 5, advanced: 5, pro: 5)));
            },

            child: const Text("view score"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final q = questions[questionIndex];
    final options =
    q["options"] as List<String>;

    return Scaffold(

      backgroundColor:
      const Color(0xFF7C3AED),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFF7C3AED),

        centerTitle: true,

        title: const Text(
          "Pro Level",
        ),
      ),

      body: Column(
        children: [

          /// Timer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),

            color: const Color(0xFF7C3AED),

            child: Text(
              "Time: $timeLeft",

              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),

              textAlign: TextAlign.center,
            ),
          ),

          /// Question Area
          Expanded(
            child: Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "Q ${questionIndex + 1}/5",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    q["question"] as String,

                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Options
                  Expanded(
                    child: ListView(
                      children:
                      options.map((opt) {

                        return GestureDetector(

                          onTap: () {

                            if (answered) return;

                            setState(() {

                              selectedAnswer = opt;
                              answered = true;

                              if (opt ==
                                  q["answer"]) {
                                score++;
                              }
                            });

                            Future.delayed(
                              const Duration(seconds: 1),
                                  () {
                                nextQuestion();
                              },
                            );
                          },

                          child: optionTile(
                            opt,
                            q["answer"] as String,
                          ),
                        );

                      }).toList(),
                    ),
                  ),

                  /// Buttons
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      ElevatedButton(
                        onPressed:
                        skipCount > 0
                            ? skipQuestion
                            : null,

                        child: Text(
                          "Skip ($skipCount)",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionTile(
      String text,
      String answer,
      ) {

    Color color = Colors.white;

    if (answered) {

      if (text == answer) {
        color = Colors.green;
      }

      else if (text == selectedAnswer) {
        color = Colors.red;
      }
    }

    return Container(

      margin:
      const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: color,

        border: Border.all(
          color: const Color(0xFF7C3AED),
        ),

        borderRadius:
        BorderRadius.circular(15),
      ),

      child: Text(
        text,

        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
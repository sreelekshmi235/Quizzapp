import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizzapp/quizz%20app/quizzpro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class quizzadvancedlevel extends StatefulWidget {
  const quizzadvancedlevel  ({super.key});

  @override
  State<quizzadvancedlevel > createState() => _BeginnerLevelState();
}

class _BeginnerLevelState extends State<quizzadvancedlevel > {

  int questionIndex = 0;
  int score = 0;
  int skipCount = 1;
  int timeLeft = 30;

  Timer? timer;

  String? selectedAnswer;
  bool answered = false;

  final List<Map<String, Object>> questions = [

    {
      "question":"who develop the theory of relativity ?",
      "options":["issac Newton"," Nikola tesla","Albert Einstein","Galilio Galilie"],
      "answer": "Albert Einstein"
    },

    {
      "question": "what is the capital of Australia ?",
      "options": ["sydney","melbourne","brisbane","Canberra"],
      "answer": "Canberra"
    },

    {
      "question": "Which element has the atomic number 1?",
      "options": ["oxygen","helium","Hydrogen","nitrogen"],
      "answer": "Hydrogen"
    },

    {
      "question": "Which is the fastest land animal ?",
      "options": ["Lion","Leopard","cheetah","Tiger"],
      "answer": "cheetah"
    },

    {
      "question": "Which programming language is mainly used for Flutter development?",
      "options": ["java","kotlin","dart","python"],
      "answer": "dart"
    },

 

  ];

   @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 30;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        nextQuestion();
      }
  });
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

    double percentage = (score / questions.length) * 100;
    final prefs = await SharedPreferences.getInstance();

    bool unlocked = false;

    if (percentage >= 70) {
      await prefs.setBool('intermediate', true);
      unlocked = true;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Finished"),
        content: Text(
          "Score: $score / ${questions.length}\n\n" +
              (unlocked
                  ? "🎉 Next Level Unlocked!"
                  : "Score 70% to unlock next level"),
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
          if (unlocked)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
              ),
              onPressed: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizProLevel()
                  ),
                );
              },
              child: const Text("Next Level"),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[questionIndex];
    final options = q["options"] as List<String>;

    return Scaffold(
      backgroundColor: const Color(0xFF7C3AED),

      appBar: AppBar(
        backgroundColor: const Color(0xFF7C3AED),
        centerTitle: true,
        title: const Text("Advance Level"),
      ),

      body: Column(
        children: [

          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF7C3AED),
            child: Text(
              "Time: $timeLeft",
              style: const TextStyle(color: Colors.white, fontSize: 18),
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
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Q ${questionIndex + 1}/5"),

                  const SizedBox(height: 10),

                  Text(
                    q["question"] as String,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Expanded(
                    child: ListView(
                      children: options.map((opt) {
                        return GestureDetector(
                          onTap: () {
                            if (answered) return;

                            setState(() {
                              selectedAnswer = opt;
                              answered = true;

                              if (opt == q["answer"]) score++;
                            });

                            Future.delayed(
                                const Duration(seconds: 1), nextQuestion);
                          },
                          child: optionTile(opt, q["answer"] as String),
                        );
                      }).toList(),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed:
                            skipCount > 0 ? skipQuestion : null,
                        child: Text("Skip ($skipCount)"),
                      ),
                      ElevatedButton(
                        onPressed: nextQuestion,
                        child: const Text("Next"),
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

  Widget optionTile(String text, String answer) {
    Color color = Colors.white;

    if (answered) {
      if (text == answer) color = Colors.green;
      else if (text == selectedAnswer) color = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text),
    );
  }
}
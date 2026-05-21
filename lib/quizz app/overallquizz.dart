import 'package:flutter/material.dart';
import 'package:quizzapp/quizz app/quizstart.dart';

class PerformancePage extends StatelessWidget {

  final int beginner;
  final int intermediate;
  final int advanced;
  final int pro;

  const PerformancePage({
    super.key,
    required this.beginner,
    required this.intermediate,
    required this.advanced,
    required this.pro,
  });

  @override
  Widget build(BuildContext context) {

    /// Total Score
    int totalScore =
        beginner + intermediate + advanced + pro;

    /// Total Questions
    int totalQuestions = 20;

    /// Overall Percentage
    double overallPercentage =
        (totalScore / totalQuestions) * 100;

    /// Performance Condition
    String performanceMessage = "";
    IconData performanceIcon = Icons.emoji_events;

    if (overallPercentage >= 80) {
      performanceMessage = "Excellent Performance! 🎉";
      performanceIcon = Icons.workspace_premium;
    } else if (overallPercentage >= 60) {
      performanceMessage = "Good Job! 👍";
      performanceIcon = Icons.thumb_up;
    } else {
      performanceMessage = "Keep Practicing 💪";
      performanceIcon = Icons.refresh;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF7C3AED),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Performance Summary",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              /// Overall Percentage Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7C3AED),
                      Color(0xFFA78BFA),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(25),
                ),

                child: Column(
                  children: [

                    const Text(
                      "Overall Percentage",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "${overallPercentage.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "$totalScore / $totalQuestions Marks",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Performance Message Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    Icon(
                      performanceIcon,
                      size: 55,
                      color: const Color(0xFF7C3AED),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      performanceMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "You scored ${overallPercentage.toStringAsFixed(0)}% overall",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// Level Score Tiles
              levelTile(
                "Beginner",
                beginner,
                Colors.green,
              ),

              const SizedBox(height: 15),

              levelTile(
                "Intermediate",
                intermediate,
                Colors.blue,
              ),

              const SizedBox(height: 15),

              levelTile(
                "Advanced",
                advanced,
                Colors.orange,
              ),

              const SizedBox(height: 15),

              levelTile(
                "Pro",
                pro,
                Colors.red,
              ),

              const SizedBox(height: 40),

              /// Back To Home Button
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  onPressed: () {

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const QuizStartPage(),
                      ),
                          (route) => false,
                    );
                  },

                  child: const Text(
                    "Back To Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Level Tile Widget
  Widget levelTile(
      String level,
      int marks,
      Color color,
      ) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 18,
                backgroundColor: color,

                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 15),

              Text(
                level,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          Text(
            "$marks / 5",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
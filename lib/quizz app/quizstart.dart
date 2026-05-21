import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizzapp/quizz app/quizzhome.dart';

class QuizStartPage extends StatelessWidget {
  const QuizStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7C3AED),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LevelUp Quiz',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color:  Color.fromARGB(255, 250, 21, 158),
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              
              const Text(
                'Test your knowledge 🚀',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 30),

              Lottie.asset(
                'assets/animations/Question.json',
                height: 400,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 250, 21, 158), // Yellow accent
                  foregroundColor: const Color(0xFF1F2937),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 8,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LevelPage(),
                    ),
                  );
                },
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
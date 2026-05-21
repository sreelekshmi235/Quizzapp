import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'quizzbeginerlevel.dart';
import 'intermediatelevel.dart';
import 'quizadvance.dart';
import 'quizzpro.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {

  bool intermediateUnlocked = false;
  bool advancedUnlocked = false;
  bool proUnlocked = false;

  @override
  void initState() {
    super.initState();
    loadLevels();
  }

  void loadLevels() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      intermediateUnlocked = prefs.getBool('intermediate') ?? false;
      advancedUnlocked = prefs.getBool('advanced') ?? false;
      proUnlocked = prefs.getBool('pro') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7C3AED),

      appBar: AppBar(
        backgroundColor: const Color(0xFF7C3AED),
        title: const Text("Select Level"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          levelCard("Beginner", true, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const BeginnerLevel()))
                .then((_) => loadLevels());
          }),

          levelCard("Intermediate", intermediateUnlocked, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const quizIntermeediatelevel()))
                .then((_) => loadLevels());
          }),

          levelCard("Advanced", advancedUnlocked, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const quizzadvancedlevel()))
                .then((_) => loadLevels());
          }),

          levelCard("Pro", proUnlocked, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const QuizProLevel()))
                .then((_) => loadLevels());
          }),
        ],
      ),
    );
  }

  Widget levelCard(String title, bool unlocked, VoidCallback onTap) {
    return GestureDetector(
      onTap: unlocked ? onTap : null,

      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: unlocked ? Colors.white : Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            Icon(
              unlocked ? Icons.lock_open : Icons.lock,
              color: unlocked ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
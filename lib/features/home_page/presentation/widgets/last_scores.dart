import 'package:flutter/material.dart';

class StaticLastScoresWidget extends StatelessWidget {
  const StaticLastScoresWidget({super.key});

  Color getScoreColor(int score) {
    if (score >= 8) return Colors.green[700]!;
    if (score >= 5) return Colors.orange[700]!;
    return Colors.red[700]!;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyScores = [
      {"score": 8, "date": "2025-06-09"},
      {"score": 6, "date": "2025-06-08"},
      {"score": 4, "date": "2025-06-07"},
    ];

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.teal[50],
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bar_chart, color: Colors.teal, size: 26),
                const SizedBox(width: 8),
                Text(
                  "Your Last Scores",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...dummyScores.map(
                  (score) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.teal[600]),
                    const SizedBox(width: 10),
                    Text(
                      "Score: ${score['score']}/10",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: getScoreColor(score['score']),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      score['date'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

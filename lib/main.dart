import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GameScreen(),
  ));
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController controller = TextEditingController();

  int secret = Random().nextInt(1000) + 1;

  List<Map<String, dynamic>> attempts = [];

  String getHint(int diff) {
    if (diff == 0) return "🎯 EXACTO";
    if (diff <= 10) return "🔥 ARDIENDO";
    if (diff <= 25) return "☀️ CALIENTE";
    if (diff <= 50) return "🌤️ TIBIO";
    return "❄️ FRÍO";
  }

  Color getColor(String hint) {
    if (hint.contains("🔥")) return Colors.red;
    if (hint.contains("☀️")) return Colors.orange;
    if (hint.contains("🌤")) return Colors.amber;
    if (hint.contains("🎯")) return Colors.green;

    return Colors.blue;
  }

  void checkNumber() {
    int guess = int.tryParse(controller.text) ?? 0;

    if (guess < 1 || guess > 1000) return;

    int diff = (guess - secret).abs();

    String hint = getHint(diff);
    Color color = getColor(hint);

    double proximity = 1 - (diff / 1000);

    setState(() {
      attempts.insert(0, {
        "number": guess,
        "hint": hint,
        "color": color,
        "proximity": proximity,
      });
    });

    controller.clear();

    if (diff == 0) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("🎉 Ganaste"),
            content: Text("El número era $secret"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    secret = Random().nextInt(1000) + 1;
                    attempts.clear();
                  });
                },
                child: const Text("Nueva partida"),
              )
            ],
          ),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 162, 60, 60),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 145, 207),
        elevation: 0,
        title: const Text("NumeroX"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              "Adivina el número entre 1 y 1000",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Tu número",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 6, 73, 150),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: checkNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 65, 145, 207),
                    padding: const EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Icon(Icons.arrow_forward, color: Color.fromARGB(255, 0, 0, 0)),
                )
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: attempts.length,
                itemBuilder: (context, index) {
                  final item = attempts[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 73, 150),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${item['number']}",
                              style: TextStyle(
                                color: item['color'],
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              item['hint'],
                              style: TextStyle(
                                color: item['color'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: item['proximity'],
                            minHeight: 8,
                            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                            valueColor:
                                AlwaysStoppedAnimation(item['color']),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
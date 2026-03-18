import 'dart:math';

import 'package:flutter/material.dart';

class RiddleMasterScreen extends StatefulWidget {
  const RiddleMasterScreen({super.key});

  @override
  State<RiddleMasterScreen> createState() => _RiddleMasterScreenState();
}

class _RiddleMasterScreenState extends State<RiddleMasterScreen> {
  final _controller = TextEditingController();
  int _score = 0;
  int _attempts = 0;
  String _feedback = '';

  final List<_Riddle> _riddles = [
    _Riddle(question: 'Có chân nhưng không đi, có lông mà không kêu?', answer: 'gà gà'),
    _Riddle(question: 'Bán đứng, bán nghiêng, đêm ngày không nghỉ. Hỏi là gì?', answer: 'cái quạt'),
    _Riddle(question: 'Trong bếp có cái gì, ăn nhiều lại đói?', answer: 'lửa'),
    _Riddle(question: 'Hai người cha, một người con, hỏi là mấy người?', answer: '3'),
    _Riddle(question: 'Lớn lên không chân vẫn đi, nhỏ vào đất ngo ngoe ngoe?', answer: 'sâu'),
  ];

  int _currentIndex = 0;

  late _Riddle _current;

  @override
  void initState() {
    super.initState();
    _shuffleRiddle();
  }

  void _shuffleRiddle() {
    _currentIndex = Random().nextInt(_riddles.length);
    _current = _riddles[_currentIndex];
    _feedback = '';
    _controller.clear();
    setState(() {});
  }

  void _checkAnswer() {
    final userAnswer = _controller.text.trim().toLowerCase();
    if (userAnswer.isEmpty) return;

    _attempts++;
    if (userAnswer.contains(_current.answer.toLowerCase())) {
      _score += 20;
      _feedback = '✅ Chính xác!';
      setState(() {});

      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        _shuffleRiddle();
      });
    } else {
      _feedback = '❌ Sai rồi, thử lại nhé.';
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riddle Master'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0097A7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Câu đố:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    _current.question,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Nhập câu trả lời...',
                    suffixIcon: const Icon(Icons.question_answer),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  onSubmitted: (_) => _checkAnswer(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _checkAnswer,
                        icon: const Icon(Icons.check),
                        label: const Text('Kiểm tra'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00796B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _shuffleRiddle,
                        icon: const Icon(Icons.skip_next),
                        label: const Text('Câu mới'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0097A7),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _feedback,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _feedback.startsWith('✅') ? Colors.green.shade700 : Colors.red.shade700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBadge('Điểm', _score.toString(), Icons.stars, Colors.orange),
                    _buildBadge('Lượt', _attempts.toString(), Icons.history, Colors.deepPurple),
                  ],
                ),
                const Spacer(),
                Text(
                  'Mẹo: viết ngắn gọn, không dấu hoặc có dấu đều được, ví dụ “lửa” hoặc “lua”.',
                  style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Riddle {
  final String question;
  final String answer;
  const _Riddle({required this.question, required this.answer});
}

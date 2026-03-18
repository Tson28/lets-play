import 'dart:math';

import 'package:flutter/material.dart';

class MemoryFlipScreen extends StatefulWidget {
  const MemoryFlipScreen({super.key});

  @override
  State<MemoryFlipScreen> createState() => _MemoryFlipScreenState();
}

class _MemoryFlipScreenState extends State<MemoryFlipScreen> {
  static const List<String> _emojis = ['🐶', '🐱', '🦊', '🐸', '🐵', '🐼'];

  late List<_MemoryCard> _cards;
  int _score = 0;
  int _moves = 0;
  int _firstSelected = -1;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    final all = [..._emojis, ..._emojis];
    all.shuffle(Random());

    _cards = List.generate(all.length, (index) {
      return _MemoryCard(id: index, content: all[index]);
    });
    _score = 0;
    _moves = 0;
    _firstSelected = -1;
    _busy = false;
    setState(() {});
  }

  void _onCardTap(int index) async {
    final card = _cards[index];
    if (_busy || card.isRevealed || card.isMatched) return;

    setState(() {
      card.isRevealed = true;
    });

    if (_firstSelected < 0) {
      _firstSelected = index;
      return;
    }

    _moves++;
    final firstCard = _cards[_firstSelected];

    if (firstCard.content == card.content) {
      setState(() {
        firstCard.isMatched = true;
        card.isMatched = true;
        _score += 15;
        _firstSelected = -1;
      });
    } else {
      _busy = true;
      await Future.delayed(const Duration(milliseconds: 700));
      setState(() {
        firstCard.isRevealed = false;
        card.isRevealed = false;
        _firstSelected = -1;
        _busy = false;
      });
    }

    if (_cards.every((element) => element.isMatched)) {
      await Future.delayed(const Duration(milliseconds: 150));
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('🎉 Bạn đã thắng!'),
          content: Text('Hoàn thành trong $_moves lượt với $_score điểm. Bạn có muốn chơi lại?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Đóng')),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _resetGame();
              },
              child: const Text('Chơi lại'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Flip'),
        centerTitle: true,
        backgroundColor: const Color(0xFF6C5CE7),
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
            colors: [Color(0xFFF3E5F5), Color(0xFFE8EAF6)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStat('Điểm', _score.toString(), Icons.star, Colors.amber),
                    _buildStat('Lượt', _moves.toString(), Icons.timelapse, Colors.blue),
                    ElevatedButton.icon(
                      onPressed: _resetGame,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Làm mới'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GridView.builder(
                    itemCount: _cards.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final c = _cards[index];
                      if (c.isMatched) {
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 0.0,
                          child: const SizedBox.shrink(),
                        );
                      }
                      return GestureDetector(
                        onTap: () => _onCardTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: c.isRevealed ? Colors.white : Colors.indigo.shade300,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              c.isRevealed ? c.content : '🐾',
                              style: TextStyle(fontSize: 28, color: c.isRevealed ? Colors.black : Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _MemoryCard {
  final int id;
  final String content;
  bool isRevealed;
  bool isMatched;

  _MemoryCard({
    required this.id,
    required this.content,
    this.isRevealed = false,
    this.isMatched = false,
  });
}

import 'package:flutter/material.dart';
import 'dart:math';

class Game2048Screen extends StatefulWidget {
  const Game2048Screen({super.key});

  @override
  State<Game2048Screen> createState() => _Game2048ScreenState();
}

class _Game2048ScreenState extends State<Game2048Screen> {
  late List<List<int>> _grid;
  int _score = 0;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _grid = List.generate(4, (_) => List.generate(4, (_) => 0));
    _score = 0;
    _gameOver = false;
    _addNewTile();
    _addNewTile();
  }

  void _addNewTile() {
    List<List<int>> emptyPos = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          emptyPos.add([i, j]);
        }
      }
    }

    if (emptyPos.isNotEmpty) {
      final random = Random();
      final pos = emptyPos[random.nextInt(emptyPos.length)];
      _grid[pos[0]][pos[1]] = random.nextDouble() < 0.9 ? 2 : 4;
    }
  }

  void _move(String direction) {
    if (_gameOver) return;

    List<List<int>> oldGrid = _grid.map((row) => [...row]).toList();

    switch (direction) {
      case 'left':
        _moveLeft();
        break;
      case 'right':
        _moveRight();
        break;
      case 'up':
        _moveUp();
        break;
      case 'down':
        _moveDown();
        break;
    }

    bool changed = false;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] != oldGrid[i][j]) {
          changed = true;
          break;
        }
      }
      if (changed) break;
    }

    if (changed) {
      _addNewTile();
    }

    _checkGameOver();
    setState(() {});
  }

  void _moveLeft() {
    for (int i = 0; i < 4; i++) {
      _grid[i] = _compress(_grid[i]);
      _grid[i] = _merge(_grid[i]);
      _grid[i] = _compress(_grid[i]);
    }
  }

  void _moveRight() {
    for (int i = 0; i < 4; i++) {
      _grid[i] = _grid[i].reversed.toList();
      _grid[i] = _compress(_grid[i]);
      _grid[i] = _merge(_grid[i]);
      _grid[i] = _compress(_grid[i]);
      _grid[i] = _grid[i].reversed.toList();
    }
  }

  void _moveUp() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [_grid[0][j], _grid[1][j], _grid[2][j], _grid[3][j]];
      column = _compress(column);
      column = _merge(column);
      column = _compress(column);
      for (int i = 0; i < 4; i++) {
        _grid[i][j] = column[i];
      }
    }
  }

  void _moveDown() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [_grid[0][j], _grid[1][j], _grid[2][j], _grid[3][j]];
      column = column.reversed.toList();
      column = _compress(column);
      column = _merge(column);
      column = _compress(column);
      column = column.reversed.toList();
      for (int i = 0; i < 4; i++) {
        _grid[i][j] = column[i];
      }
    }
  }

  List<int> _compress(List<int> line) {
    List<int> newLine = line.where((val) => val != 0).toList();
    newLine.addAll(List.filled(4 - newLine.length, 0));
    return newLine;
  }

  List<int> _merge(List<int> line) {
    for (int i = 0; i < 3; i++) {
      if (line[i] != 0 && line[i] == line[i + 1]) {
        line[i] *= 2;
        _score += line[i];
        line[i + 1] = 0;
      }
    }
    return line;
  }

  void _checkGameOver() {
    bool hasEmpty = false;
    bool canMove = false;

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) hasEmpty = true;

        if (j < 3 && _grid[i][j] == _grid[i][j + 1]) {
          canMove = true;
        }
        if (i < 3 && _grid[i][j] == _grid[i + 1][j]) {
          canMove = true;
        }
      }
    }

    _gameOver = !(hasEmpty || canMove);
  }

  Color _getTileColor(int value) {
    switch (value) {
      case 0:
        return const Color(0xFFCDC1B4);
      case 2:
        return const Color(0xFFEEE4DA);
      case 4:
        return const Color(0xFFEDE0C8);
      case 8:
        return const Color(0xFFF2B179);
      case 16:
        return const Color(0xFFF59563);
      case 32:
        return const Color(0xFFF67C5F);
      case 64:
        return const Color(0xFFF65E3B);
      case 128:
        return const Color(0xFFEDCF72);
      case 256:
        return const Color(0xFFEDCC61);
      case 512:
        return const Color(0xFFEDC850);
      case 1024:
        return const Color(0xFFEDC53F);
      case 2048:
        return const Color(0xFFEDC22E);
      default:
        return const Color(0xFF3C3C2F);
    }
  }

  Color _getTextColor(int value) {
    return value > 4 ? Colors.white : Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('static_assets/images/back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // OVERLAY FIX SỌC
          Container(
            color: Colors.black.withOpacity(0.35),
          ),

          Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        '2048',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$_score',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5A2B), // màu đặc FIX SỌC
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GridView.builder(
                          itemCount: 16,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            int row = index ~/ 4;
                            int col = index % 4;
                            int value = _grid[row][col];

                            return Container(
                              decoration: BoxDecoration(
                                color: _getTileColor(value),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.black12, width: 1),
                              ),
                              child: Center(
                                child: value != 0
                                    ? Text(
                                        '$value',
                                        style: TextStyle(
                                          color: _getTextColor(value),
                                          fontSize:
                                              value >= 1024 ? 18 : 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 10,
                children: [
                  _btn('↑', () => _move('up')),
                  _btn('↓', () => _move('down')),
                  _btn('←', () => _move('left')),
                  _btn('→', () => _move('right')),
                ],
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () => setState(_initializeGame),
                child: const Text('New Game'),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _btn(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
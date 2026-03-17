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

    // Check if grid actually changed
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

    // Only add new tile and update if the grid changed
    if (changed) {
      _addNewTile();
      _checkGameOver();
      setState(() {});
    }
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
      _grid[0][j] = column[0];
      _grid[1][j] = column[1];
      _grid[2][j] = column[2];
      _grid[3][j] = column[3];
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
      _grid[0][j] = column[0];
      _grid[1][j] = column[1];
      _grid[2][j] = column[2];
      _grid[3][j] = column[3];
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
    bool canMoveHorizontal = false;
    bool canMoveVertical = false;

    // Check for empty cells
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          hasEmpty = true;
          break;
        }
        // Check horizontal merge
        if (j < 3 && _grid[i][j] != 0 && _grid[i][j] == _grid[i][j + 1]) {
          canMoveHorizontal = true;
        }
        // Check vertical merge
        if (i < 3 && _grid[i][j] != 0 && _grid[i][j] == _grid[i + 1][j]) {
          canMoveVertical = true;
        }
      }
      if (hasEmpty) break;
    }

    if (!hasEmpty && !canMoveHorizontal && !canMoveVertical) {
      setState(() => _gameOver = true);
    }
  }

  Color _getTileColor(int value) {
    switch (value) {
      case 0:
        return Colors.grey[300]!;
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF9F8F7F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF776E5E),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            '2048',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.brown[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Score',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  Text(
                    '$_score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Game Grid
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.brown[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.0,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(16, (index) {
                      final row = index ~/ 4;
                      final col = index % 4;
                      final value = _grid[row][col];

                      return Container(
                        decoration: BoxDecoration(
                          color: _getTileColor(value),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            if (value != 0)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                              )
                          ],
                        ),
                        child: Center(
                          child: value != 0
                              ? Text(
                                  '$value',
                                  style: TextStyle(
                                    color: _getTextColor(value),
                                    fontSize: value > 100 ? 20 : 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 30),

                if (_gameOver)
                  Container(
                    padding:const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Game Over!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Final Score: $_score',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                const Spacer(),

                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _move('up'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[400],
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                          ),
                          child: const Icon(Icons.arrow_upward, color: Colors.white, size: 24),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _move('left'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[400],
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12),
                              ),
                              child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _move('down'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[400],
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12),
                              ),
                              child: const Icon(Icons.arrow_downward, color: Colors.white, size: 24),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _move('right'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[400],
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12),
                              ),
                              child: const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // New Game Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _initializeGame();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDC22E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'New Game',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
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
      ),
    );
  }
}

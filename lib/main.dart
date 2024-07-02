import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BackgroundScreen(),
      ),
    );
  }
}

class BackgroundScreen extends StatefulWidget {
  @override
  _BackgroundScreenState createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen>
    with SingleTickerProviderStateMixin {
  double _position = 0;
  double _velocity = 10; // 속도 조정
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startMoving();
  }

  void _startMoving() {
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        _position += _velocity;
        double screenWidth = MediaQuery.of(context).size.width;
        double barWidth = screenWidth - 80;
        if (_position > barWidth - 50 || _position < 0) {
          _velocity = -_velocity;
        }
      });
    });
  }

  void _increaseSpeed() {
    setState(() {
      if (_velocity > 0 && _velocity < 50) {
        _velocity += 3;
      } else if (_velocity < 0 && _velocity > -50) {
        _velocity -= 3;
      }
    });
  }

  void _decreaseSpeed() {
    setState(() {
      if (_velocity > 5) {
        _velocity -= 3;
      } else if (_velocity < -5) {
        _velocity += 3;
      }
    });
  }

  double _calculateProgress() {
    double screenWidth = MediaQuery.of(context).size.width;
    double barWidth = screenWidth - 80;
    return (_position / (barWidth - 50)) * 100;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _calculateProgress();
    return Container(
      color: Color(0xFF1A44AF),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '거꾸로 매점',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontFamily: 'Saum',
                    ),
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'assets/꾸로.png',
                    height: 36,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 150),
              width: MediaQuery.of(context).size.width - 80,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  '${progress.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Saum',
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: _position + 40,
            child: Image.asset(
              'assets/꾸로.png',
              width: 50,
            ),
          ),
          Positioned(
            bottom: 1115, // Adjusted to position the button just below the bar
            left: 40,  // Positioned at the start of the bar
            child: ElevatedButton(
              onPressed: _decreaseSpeed,
              child: Text('-'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)), // 버튼 배경색
                foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)), // 버튼 텍스트 색
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10), // 버튼 크기 조정
                ),
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 20, // 버튼 텍스트 크기
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글기
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 1115, // Adjusted to position the button just below the bar
            right: 40, // Positioned at the end of the bar
            child: ElevatedButton(
              onPressed: _increaseSpeed,
              child: Text('+'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)), // 버튼 배경색
                foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)), // 버튼 텍스트 색
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10), // 버튼 크기 조정
                ),
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 20, // 버튼 텍스트 크기
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder( 
                    borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글기
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

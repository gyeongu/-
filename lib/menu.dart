import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';  // url_launcher 패키지 임포트

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'saum', // 기본 폰트 설정
      ),
      home: MainPage(), // 시작 페이지를 MainPage로 설정
    );
  }
}

class MainPage extends StatelessWidget {
  // 카카오톡 봇 링크
  final String kakaoTalkBotUrl = 'https://open.kakao.com/o/gfVrazAg';  // 여기에 실제 카카오톡 봇 URL을 입력하세요

  // 카카오톡 봇 링크를 여는 함수
  void _launchKakaoTalkBot() async {
    if (await canLaunch(kakaoTalkBotUrl)) {
      await launch(kakaoTalkBotUrl);
    } else {
      throw 'Could not launch $kakaoTalkBotUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 페이지', style: TextStyle(fontFamily: 'saum')),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            iconSize: 30.0, // 아이콘 크기를 적당히 설정
            onPressed: _launchKakaoTalkBot, // 카카오톡 봇 링크 열기
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              iconSize: 70.0, // 아이콘 크기를 크게 설정
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final String _correctPassword = "0523";
  String _enteredPassword = "";
  String _errorMessage = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "지우기") {
        if (_enteredPassword.isNotEmpty) {
          _enteredPassword = _enteredPassword.substring(0, _enteredPassword.length - 1);
        }
      } else if (value == "확인") {
        if (_enteredPassword == _correctPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage()),
          );
        } else {
          _errorMessage = "비밀번호가 맞지 않습니다";
          _enteredPassword = ""; // 비밀번호가 틀렸을 때 입력된 비밀번호 초기화
        }
      } else {
        if (_enteredPassword.length < 4) {
          _enteredPassword += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B46B4),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF1B46B4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // 텍스트 위에 이미지 추가
            Image.asset('assets/꾸로.png', height: 140,), // 경로에 맞게 이미지 파일을 추가하세요.
            SizedBox(height: 20),
            Text(
              '관리자로 로그인',
              style: TextStyle(
                fontSize: 60.0, // 텍스트 크기 증가
                color: Colors.white,
                fontWeight: FontWeight.bold, // 추가 스타일 적용 가능
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: double.infinity, // 화면 전체 너비를 채우도록 설정
              padding: EdgeInsets.symmetric(horizontal: 95),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < _enteredPassword.length; i++)
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _enteredPassword[i],
                          style: TextStyle(
                            fontSize: 40, // 텍스트 크기 조정
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 34, // 에러메시지 텍스트 크기 증가
                  ),
                ),
              ),
            SizedBox(height: 50),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildButtonColumn(["1", "4", "7", SizedBox(
                        width: 140,
                        height: 140,
                        child: IconButton(
                          icon: Icon(Icons.backspace),
                          onPressed: () => _buttonPressed("지우기"),
                          iconSize: 80.0,
                          color: Colors.white,
                        ),
                      )]),
                      buildButtonColumn(["2", "5", "8", "0"]),
                      buildButtonColumn(["3", "6", "9", "확인"]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonColumn(List<dynamic> values) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((value) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // 세로 간격 조정
          child: value is String
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // 모서리를 둥글게 설정
                    ),
                    backgroundColor: value == "확인" ? Colors.yellow : Colors.white, // 배경색 설정
                    foregroundColor: Color.fromARGB(255, 0, 0, 0), // 텍스트 색상 설정
                    minimumSize: Size(140, 140), // 버튼 크기 설정
                  ),
                  onPressed: () => _buttonPressed(value),
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 65),
                  ),
                )
              : value, // IconButton이나 ElevatedButton인 경우 바로 반환
        );
      }).toList()
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('다음 페이지'),
      ),
      body: Center(
        child: Text('메뉴 추가하기'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // 앱 실행 시작점
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스타일링 메모 앱',
      theme: ThemeData(
        primarySwatch: Colors.teal, // 앱의 메인 색상을 teal로 설정
      ),
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      home: MemoApp(), // 앱의 첫 화면으로 MemoApp 설정
    );
  }
}

class MemoApp extends StatefulWidget {
  @override
  _MemoAppState createState() => _MemoAppState(); // 상태 관리용 State 클래스 생성
}

class _MemoAppState extends State<MemoApp> {
  List<String> memos = []; // 메모를 저장할 리스트
  final TextEditingController _controller =
      TextEditingController(); // 입력 필드 컨트롤러

  // 메모 추가 함수
  void _addMemo() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        // 텍스트 필드가 비어있지 않은 경우
        memos.add(_controller.text); // 리스트에 입력된 메모 추가
        _controller.clear(); // 입력 필드 초기화
      }
    });
  }

  // 메모 삭제 함수
  void _deleteMemo(int index) {
    setState(() {
      memos.removeAt(index); // 리스트에서 해당 인덱스의 메모 제거
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '메모 앱', // 상단바 제목
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // 제목을 중앙으로 정렬
      ),
      body: Column(
        children: [
          // 입력 필드와 추가 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // 입력 필드 컨트롤러
                    decoration: InputDecoration(
                      hintText: '메모를 입력하세요', // 힌트 텍스트
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // 테두리를 둥글게 설정
                      ),
                      filled: true,
                      fillColor: Colors.teal[50], // 배경 색상
                    ),
                  ),
                ),
                SizedBox(width: 8), // 텍스트 필드와 버튼 사이 간격
                ElevatedButton(
                  onPressed: _addMemo, // 버튼 클릭 시 메모 추가
                  child: Text('추가'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16), // 버튼 크기 설정
                  ),
                ),
              ],
            ),
          ),
          // 메모 리스트 표시
          Expanded(
            child: ListView.builder(
              itemCount: memos.length, // 메모의 개수만큼 아이템 생성
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), // 카드 여백 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // 카드 모서리를 둥글게 설정
                  ),
                  elevation: 3, // 카드 그림자 효과
                  child: ListTile(
                    title: Text(
                      memos[index], // 메모 내용
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red), // 삭제 아이콘
                      onPressed: () => _deleteMemo(index), // 삭제 버튼 클릭 시 메모 삭제
                    ),
                    onTap: () {
                      // 메모 상세 페이지로 이동
                      Navigator.push(
                        //// 페이지 이동
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MemoDetailPage(memo: memos[index]), // 상세 페이지로 이동
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 새로운 메모 상세 페이지
class MemoDetailPage extends StatelessWidget {
  final String memo; // 전달받은 메모 데이터

  MemoDetailPage({required this.memo}); // 생성자를 통해 메모를 초기화

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 상세'), // 상단바 제목
        centerTitle: true, // 제목을 중앙으로 정렬
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // 카드 모서리를 둥글게 설정
            ),
            elevation: 5, // 카드 그림자 효과
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                memo, // 메모 내용 표시
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*
Navigator.push:

새로운 페이지로 이동할 때 사용하는 함수.
builder에 이동할 페이지를 정의.
dart
코드 복사

MemoDetailPage:

전달된 메모를 화면에 표시하는 두 번째 페이지.
Scaffold와 Card를 사용해 메모를 깔끔하게 표현.

위젯 설명:
AppBar: 상단바에서 제목을 중앙 정렬(centerTitle: true)로 설정.
TextField: 사용자의 입력을 처리.
ListView.builder: 동적으로 메모를 리스트로 표시.

 */

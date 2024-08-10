import 'package:flutter/material.dart';

/// Miso 메인 색상
Color misoPrimaryColor = Color.fromARGB(255, 38, 103, 240);

class Miso extends StatefulWidget {
  const Miso({Key? key}) : super(key: key);

  @override
  _MisoState createState() => _MisoState();
}

class _MisoState extends State<Miso> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: [
          MisoFirstPage(),
          MisoSecondPage(),
          MisoThirdPage(),
          MisoFourthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 다른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: misoPrimaryColor, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 항목 label 숨기기
        showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "list"),
          BottomNavigationBarItem(icon: Icon(Icons.redeem), label: "redeem"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "user"),
        ],
      ),
    );
  }
}

/// 첫 번째 페이지
class MisoFirstPage extends StatelessWidget {
  const MisoFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: misoPrimaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "대한민국 1등 홈서비스\n미소를 만나보세요!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 38,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "+ 예약하기",
                    style: TextStyle(color: misoPrimaryColor),
                  ),
                ),
              ),
            ],
          ),
          // positioned 을 사용하면 특정 위치에 고정할 수 있음. 단, 상위에 Stack으로 감싸야함
          Positioned(
            bottom: 32,
            child: GestureDetector(
              onTap: () {
                print("서비스 상세 정보 클릭 됨");
              },
              child: Container(
                color: Colors.white.withOpacity(0.3),
                padding: EdgeInsets.all(12),
                child: Text(
                  "서비스 상세 정보",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 두 번째 페이지
class MisoSecondPage extends StatelessWidget {
  const MisoSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Miso 두 번째 페이지"),
      ),
    );
  }
}

/// 세 번째 페이지
class MisoThirdPage extends StatelessWidget {
  const MisoThirdPage({Key? key}) : super(key: key);

  /// 세 번째 화면 배경 이미지 URL
  final String backgroundImgUrl =
      "https://i.ibb.co/rxzkRTD/146201680-e1b73b36-aa1e-4c2e-8a3a-974c2e06fa9d.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Miso 세 번째 페이지"),
      ),
    );
  }
}

/// 네 번째 페이지
class MisoFourthPage extends StatelessWidget {
  const MisoFourthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Miso 네 번째 페이지"),
      ),
    );
  }
}

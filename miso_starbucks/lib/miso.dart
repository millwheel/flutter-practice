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
      body: SafeArea(
        child: SizedBox(
          width: double.infinity, // 중앙정렬 역할
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  // 위쪽 패딩을 전체 사이즈의 배율로 설정
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Text(
                    textAlign: TextAlign.center,
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
                  ElevatedButton(
                    onPressed: () {
                      print("예약하기 버튼 클릭됨");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MisoSecondPage()));
                    },
                    child: Text(
                      "+ 예약하기",
                      style: TextStyle(color: misoPrimaryColor),
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
        ),
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
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 위쪽 패딩을 전체 사이즈의 배율로 설정
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Text(
                      "예약내역",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: misoPrimaryColor,
                        ),
                        SizedBox(width: 8),
                        // 가로 남은 공간 채우기
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("예약된 서비스가 아직 없어요. 지금 예약해보세요!"),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Positioned(
                left: 24, // 포지션 좌측 패딩 크기
                right: 24, // 포지션 우측 패딩 크기
                bottom: 30, // 포지션 아래 패딩 크기
                child: GestureDetector(
                  onTap: () {
                    print("예약하기 클릭됨");
                  },
                  child: Container(
                    width: double.infinity, // 컨테이너 확장
                    height: 58, //
                    color: misoPrimaryColor,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "예약하기",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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

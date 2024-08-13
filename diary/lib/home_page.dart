import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDay = DateTime.now();
  TextEditingController createTextController = TextEditingController();
  TextEditingController updateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, child) {
        List<Diary> diaryList = diaryService.getByDate(selectedDay);
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2000, 3, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDay, day);
                  },
                  onDaySelected: (_, focusedDay) {
                    setState(() {
                      focusedDay = focusedDay;
                    });
                  },
                ),
                Divider(
                  height: 1,
                ),
                Expanded(
                  child: diaryList.isEmpty
                      ? Center(
                          child: Text(
                            "한 줄 일기를 작성해주세요.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: diaryList.length,
                          itemBuilder: (context, index) {
                            int i = diaryList.length - index - 1;
                            Diary diary = diaryList[index];
                            // ListView 아래는 ListTile
                            return ListTile(
                              title: Text(
                                diary.text,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                showDeleteDialog(diaryService, diary);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(height: 1);
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create),
            onPressed: () {
              showCreateDialog(diaryService);
            },
          ),
        );
      },
    );
  }

  // build가 아닌 private 함수 넣을 수 있음
  void showCreateDialog(DiaryService diaryService) {
    // 팝업 창 띄우는 역할
    showDialog(
      context: context,
      builder: (context) {
        // 팝업 창
        return AlertDialog(
          title: Text("일기 작성"),
          // 입력 받기
          content: TextField(
            controller: createTextController,
            cursorColor: Colors.indigo,
            decoration: InputDecoration(
              hintText: "한 줄 일기를 작성해주세요.",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
          ),
          // 액션 결정해주는 곳
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "취소",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            TextButton(
              onPressed: () {
                String newText = createTextController.text.trim();
                if (newText.isNotEmpty) {
                  diaryService.create(newText, selectedDay);
                  createTextController.text = "";
                }
                Navigator.pop(context);
              },
              child: Text(
                "작성",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(DiaryService diaryService, Diary diary) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("일기 삭제"),
          content: Text("일기를 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "취소",
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            TextButton(
              onPressed: () {
                diaryService.delete(diary.createdAt);
                Navigator.pop(context);
              },
              child: Text(
                "삭제",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

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
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //   child: ListView.separated(
                //     itemCount: diaryList.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       int i = diaryList.length - index - 1;
                //       Diary diary = diaryList[i];
                //       Text(diary.text);
                //     },
                //     separatorBuilder: (BuildContext context, int index) {
                //       return Divider(
                //         height: 1,
                //       );
                //     },
                //   ),
                // ),
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

  void createDiary(DiaryService diaryService) {
    String newText = createTextController.text.trim();
    if (newText.isNotEmpty) {
      diaryService.create(newText, selectedDay);
      createTextController.text = "";
    }
  }

  void showCreateDialog(DiaryService diaryService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("일기 작성"),
          content: TextField(
            controller: createTextController,
            decoration: InputDecoration(
              hintText: "한 줄 일기를 작성해주세요.",
            ),
            onSubmitted: (_) {
              createDiary(diaryService);
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                createDiary(diaryService);
                Navigator.pop(context);
              },
              child: Text("작성"),
            ),
          ],
        );
      },
    );
  }
}

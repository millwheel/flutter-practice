import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bucket.dart';
import 'bucket_service.dart';

void main() {
  runApp(
    // provider는 myapp을 감싼 형태로 사용한다.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BucketService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // notifyListners()에 의해 Comsumer의 builder 함수 내부가 새로고침
    return Consumer<BucketService>(
      builder: (context, bucketService, child) {
        List<Bucket> bucketList = bucketService.bucketList;
        return Scaffold(
          appBar: AppBar(
            title: Text("버킷 리스트"),
          ),
          body: bucketList.isEmpty
              ? Center(child: Text("버킷리스트를 작성해주세요"))
              : ListView.builder(
                  itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
                  itemBuilder: (context, index) {
                    Bucket bucket =
                        bucketList[index]; // index에 해당하는 bucket 가져오기
                    return ListTile(
                      // 버킷 리스트 할 일
                      title: Text(
                        bucket.job,
                        style: TextStyle(
                          fontSize: 24,
                          color: bucket.isDone ? Colors.grey : Colors.black,
                          decoration: bucket.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      // 삭제 아이콘 버튼
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.delete),
                        onPressed: () {
                          // 삭제 버튼 클릭시
                          showDeleteDialog(context, index, bucketService);
                        },
                      ),
                      onTap: () {
                        // 아이템 클릭시
                        bucket.isDone = !bucket.isDone;
                        bucketService.updateBucket(bucket, index);
                        // setState(() {
                        //   bucket.isDone = !bucket.isDone;
                        // });
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              // + 버튼 클릭시 버킷 생성 페이지로 이동
              // CreatePage에서 pop에 의해 넘어온 변수가 job에 담긴다.
              String? job = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePage()),
              );
              if (job != null) {
                setState(() {
                  bucketList.add(new Bucket(job));
                });
              }
            },
          ),
        );
      },
    );
  }

  void showDeleteDialog(
      BuildContext context, int index, BucketService bucketService) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('정말로 삭제하겠습니까?'),
            actions: [
              // 취소 버튼
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("취소"),
              ),
              // 확인 버튼
              TextButton(
                onPressed: () {
                  bucketService.deleteBucket(index);
                  Navigator.pop(context);
                },
                child: Text(
                  "확인",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          );
        });
  }
}

/// 버킷 생성 페이지
// 아무 text를 입력하지 않았을 때 에러를 보여줘야 하므로 state를 사용한다.
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // 사용자가 입력한 text를 가져올 때 사용한다.
  TextEditingController textEditingController = TextEditingController();
  // 에러 메시지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error,
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textEditingController.text;
                  if (job.isEmpty)
                    setState(() {
                      error = "내용을 입력하세요";
                    });
                  else {
                    setState(() {
                      error = null;
                    });
                    // navigator 대신 bucket service를 사용하여 job을 넘겨준다.
                    BucketService bucketService = context.read<BucketService>();
                    bucketService.createBucket(job);
                    Navigator.pop(context);
                    // Navigator.pop(context, job);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

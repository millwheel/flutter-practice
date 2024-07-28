import 'package:flutter/material.dart';

import 'bucket.dart';

/// Bucket 상태 관리 전문
class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기'), // 더미(dummy) 데이터
  ];

  void createBucket(String job) {
    bucketList.add(Bucket(job));
    // 변경사항이 있는 경우 새로고침
    notifyListeners();
  }

  void updateBucket(Bucket bucket, int index) {
    bucketList[index] = bucket;
    notifyListeners();
  }

  void deleteBucket(int index) {
    bucketList.removeAt(index);
    notifyListeners();
  }
}

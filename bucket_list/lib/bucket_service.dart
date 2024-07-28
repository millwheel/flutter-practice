import 'package:flutter/material.dart';

import 'bucket.dart';

/// Bucket 상태 관리 전문
class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기'), // 더미(dummy) 데이터
  ];

  void createBucket(String job) {
    bucketList.add(Bucket(job));
  }
}

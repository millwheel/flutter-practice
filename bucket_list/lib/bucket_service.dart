import 'package:flutter/material.dart';

import 'main.dart';

/// Bucket 상태 관리 전문
class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기'), // 더미(dummy) 데이터
  ];
}

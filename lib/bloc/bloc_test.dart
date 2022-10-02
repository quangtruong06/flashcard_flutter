// ignore_for_file: non_constant_identifier_names

import 'dart:async';

class BlocTest{
  final StreamController _CountAbcController = StreamController<int>.broadcast();
  Stream get countAbc => _CountAbcController.stream;
  void setCountAbc(int value){
    _CountAbcController.sink.add(value);
  }
}
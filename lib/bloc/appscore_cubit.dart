import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCubit extends Cubit<List<Map<String, double>>> {
  ScoreCubit() : super([]);
  void setScoreLength(int length){
    emit(List.generate(length, (index) => {"WordGame":0.0,"PuzzleGame":0.0}));
  }
  void setWordGame(double score,int index){
    state[index]["WordGame"] = score;
    emit(state);
  }
  void setPuzzleGame(double score,int index) {
    state[index]["PuzzleGame"] = score;
    emit(state);
  }
}



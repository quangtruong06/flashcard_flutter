import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCubit extends Cubit<List<Map<String, double>>> {
  List<double> totalScores =[];
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
  void listTotalScore(){
    for (int i =0;i<state.length;i++){
      totalScores.add((state[i]["WordGame"]!+state[i]["PuzzleGame"]!)/2);
    }
  }
}



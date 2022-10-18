import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCubit extends Cubit<Map<String,double>> {
  ScoreCubit() : super({"WordGame": 0.0, "PuzzleGame": 0.0});
  void setWordGame(double score) => emit(state["WordGame"]);
  void setPuzzleGame(double score) => emit(state["PuzzleGame"] = score);
}

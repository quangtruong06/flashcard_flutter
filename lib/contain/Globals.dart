import 'package:flutter/foundation.dart';

const double defaultPadding =8.0;
const String CDN_DOUMAIN = "https://vndoc.com/cards";
const String API_TAXONOMIES = "$CDN_DOUMAIN/api/taxonomies";
const String API_CARDDATA ="$CDN_DOUMAIN/api/flashcards?taxonomyId=";
class PhonemicLastPageData{
  String tittle = "Bạn đã xem hết Flash Card!";
  String imageSrc = "";
  String description = "Bạn có thể xem lại từ đầu hoặc chuyển sang chơi game";
}
class GameLastPageData{
  GameLastPageData(this.trueAnswerAmount,this.gameQuestionLength);
  int? trueAnswerAmount ;
  int? gameQuestionLength;
  String? description;
  String? title;
  String? imgSrc;
  double? score() => trueAnswerAmount!/gameQuestionLength!;
  void loadData(){
    title = "Bạn đã trả lời đúng $trueAnswerAmount/$gameQuestionLength";
    if(score()!<0.5){
      description = "Bạn cần trau dồi thêm kiến thức.";
      imgSrc = "";
    }
    else if(score()!<0.8){
      description = "Bạn đạt mức kha khá rồi đó!";
      imgSrc = "";
    }
    else if(score()! ==1) {
      description = "Bạn đã đúng 100% câu hỏi của chúng tôi";
      imgSrc = "";
    }
    else {
      description = "Bạn khá giỏi tiếng anh đó";
      imgSrc = "";
    }
  }
}

import 'dart:math';

const double defaultPadding = 8.0;
const String CDN_DOUMAIN = "https://vndoc.com/cards";
const String API_TAXONOMIES = "$CDN_DOUMAIN/api/taxonomies";
const String API_CARDDATA = "$CDN_DOUMAIN/api/flashcards?taxonomyId=";
class PhonemicLastPageData {
  String tittle = "Bạn đã xem hết Flash Card!";
  String imageSrc = "assets/images/smile_5.png";
  String description = "Bạn có thể xem lại từ đầu hoặc chuyển sang chơi game";
}

class GameLastPageData {
  GameLastPageData(this.trueAnswerAmount, this.gameQuestionLength);
  int? trueAnswerAmount;
  int? gameQuestionLength;
  String? description;
  String? title;
  String? imgSrc;
  double? score() => trueAnswerAmount! / gameQuestionLength!;
  void loadData() {
    title = "Bạn đã trả lời đúng $trueAnswerAmount/$gameQuestionLength";
    if (score()! < 0.5) {
      List cryImg = [
        "assets/images/cry_1.png",
        "assets/images/cry_2.png",
        "assets/images/cry_3.png",
        "assets/images/cry_4.png"
      ];
      description = "Bạn cần trau dồi thêm kiến thức.";
      imgSrc = cryImg[Random().nextInt(cryImg.length)];
    } else if (score()! < 0.8) {
      description = "Bạn đạt mức kha khá rồi đó!";
      imgSrc = "assets/images/smile_2.png";
    } else if (score()! == 1) {
      description = "Bạn đã đúng 100% câu hỏi của chúng tôi";
      imgSrc = "assets/images/smile_1.png";
    } else {
      description = "Bạn khá giỏi tiếng anh đó";
      imgSrc = "assets/images/smile_5.png";
    }
  }
}

const double defaultPadding =8.0;
const String CDN_DOUMAIN = "https://vndoc.com/cards";
const String API_TAXONOMIES = "$CDN_DOUMAIN/api/taxonomies";
const String API_CARDDATA ="$CDN_DOUMAIN/api/flashcards?taxonomyId=";
class CardGameLastPageData{
  String tittle = "Bạn đã xem hết Flash Card!";
  String imageSrc = "";
  String description = "Bạn có thể xem lại từ đầu hoặc chuyển sang chơi game";
}
class CardModel {
  String? name, imageUrl, mediaUrl, phonemic, description;

  CardModel(
      {this.name,
      this.imageUrl,
      this.description,
      this.mediaUrl,
      this.phonemic});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        name: json["Name"],
        imageUrl: json["ImageUrl"],
        mediaUrl: json["MediaUrl"],
        phonemic: json["Phonemic"],
        description: json["Description"]);
  }
}

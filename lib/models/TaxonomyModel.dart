class TaxonomyModel {
  int? taxonomyId, totalFlashCards;
  String? name, imageUrl;

  TaxonomyModel(
      {this.name, this.imageUrl, this.totalFlashCards, this.taxonomyId});

  factory TaxonomyModel.fromJson(Map<String, dynamic> json) {
    return TaxonomyModel(
        name: json['Name'],
        imageUrl: json['ImageUrl'],
        totalFlashCards: json['TotalFlashCards'],
        taxonomyId: json['TaxonomyId']);
  }
}

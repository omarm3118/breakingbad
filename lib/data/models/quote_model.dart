class QuoteModel {
  late final quote;

  QuoteModel.fromJson({required Map<String, dynamic> json}) {
    quote = json['quote'];
  }
}

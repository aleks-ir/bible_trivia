class Verse {
  int chapter;
  int verse;
  String text;
  String translationId;
  String bookId;
  String bookName;

  Verse({
    required this.chapter,
    required this.verse,
    required this.text,
    required this.translationId,
    required this.bookId,
    required this.bookName
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
    chapter : json["chapter"],
    verse : json["verse"],
    text : json["text"],
    translationId : json["translation_id"],
    bookId : json["book_id"],
    bookName : json["book_name"]
  );

  Map<String, dynamic> toJson() => {
    "chapter": chapter,
    "verse": verse,
    "text": text,
    "translation_id": translationId,
    "book_id": bookId,
    "book_name": bookName,
  };
}
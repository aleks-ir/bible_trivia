class Verse {
  int chapter;
  int verse;
  String text;
  String translation_id;
  String book_id;
  String book_name;

  Verse({
    required this.chapter,
    required this.verse,
    required this.text,
    required this.translation_id,
    required this.book_id,
    required this.book_name
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
    chapter : json["chapter"],
    verse : json["verse"],
    text : json["text"],
    translation_id : json["translation_id"],
    book_id : json["book_id"],
    book_name : json["book_name"]
  );

  Map<String, dynamic> toJson() => {
    "chapter": chapter,
    "verse": verse,
    "text": text,
    "translation_id": translation_id,
    "book_id": book_id,
    "book_name": book_name,
  };
}
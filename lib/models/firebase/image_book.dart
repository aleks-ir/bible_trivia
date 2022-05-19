class ImageBook {
  final String book;
  final String url;

  ImageBook(
      {required this.book,
      required this.url});

  ImageBook.fromJson(Map<String, Object?> json)
      : this(
          book: json['book']! as String,
          url: json['url']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'book': book,
      'url': url,
    };
  }
}

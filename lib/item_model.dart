class Item {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUr;

  Item(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUr});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      thumbnailUr: json['thumbnailUrl'],
      url: json['url'],
    );
  }
}

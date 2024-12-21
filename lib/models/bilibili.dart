class SearchResponse {
  int avid;
  String bvid;
  String title;
  String description;
  String author;

  SearchResponse({
    required this.avid,
    required this.bvid,
    required this.title,
    required this.description,
    required this.author,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      avid: json['aid'],
      bvid: json['bvid'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
    );
  }
}

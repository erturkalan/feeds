class FeedModel {
  final String header;
  final String body;
  final String image;
  final int date;

  const FeedModel({
    required this.header,
    required this.body,
    this.image =
        "https://fastly.picsum.photos/id/234/200/200.jpg?hmac=xPu1ioX9SWsHBaICVti0qPl5c7fPKvztdkSxpv8w6oo",
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'header': header,
      'body': body,
      'image': image,
      'date': date,
    };
  }

  factory FeedModel.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return FeedModel(
      header: map['header'] as String,
      body: map['body'] as String,
      image: map['image'] as String,
      date: map['date'] as int,
    );
  }
}

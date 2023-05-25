class NotificationModel {
  final String title;
  final String body;

  NotificationModel({
    required this.title,
    required this.body,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "body": body,
      };
  static List<NotificationModel> notifications(List data) =>
      data.map((e) => NotificationModel.fromMap(e)).toList();
}

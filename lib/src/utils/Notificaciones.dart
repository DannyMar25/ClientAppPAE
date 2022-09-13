class Notification {
  Notification({
    this.body = '',
    this.icon = '',
    this.title = '',
  });

  String body;
  String icon;
  String title;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        body: json["body"],
        icon: json["icon"] ?? "",
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "icon": icon,
        "title": title,
      };
}

class NotificationModel {
  int _id;
  String _title;
  String _message;

  NotificationModel(
    int id,
    String title,
    String message,
  ) {
    this._id = id;
    this._title = title;
    this._message = message;
  }

  int get id => _id;
  String get title => _title;
  String get message => _message;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    this._id = int.parse(json['id']);
    this._title = json['title'];
    this._message = json['message'];
  }
}

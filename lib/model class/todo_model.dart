class ToDoModel {
  String title;
  String subTitle;
  bool isCompleted;

  ToDoModel(
      {required this.title, required this.subTitle, this.isCompleted = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
      'isCompleted': isCompleted,
    };
  }

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      title: json['title'],
      subTitle: json['subTitle'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

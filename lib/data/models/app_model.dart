class AppModel {
  final int? id;
  final int? age;
  final double? weight;
  final double? height;
  final int? dailyGoal;
  final int? amount;
  final String? dateTime;

  AppModel({
    this.id,
    this.age,
    this.weight,
    this.height,
    this.dailyGoal,
    this.amount,
    this.dateTime,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        id: json['id'],
        age: json['age'],
        weight: json['weight'],
        height: json['height'],
        dailyGoal: json['dailyGoal'],
        amount: json['amount'],
        dateTime: json['dateTime'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'age': age,
        'weight': weight,
        'height': height,
        'dailyGoal': dailyGoal,
        'amount': amount,
        'dateTime': dateTime,
      };
}

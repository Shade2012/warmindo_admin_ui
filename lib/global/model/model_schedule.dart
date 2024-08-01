class Schedule {
  int id;
  bool isOpen;
  String days;
  String hours;
  String temporaryClosureDuration;
  DateTime createdAt;
  DateTime updatedAt;

  Schedule({
    required this.id,
    required this.isOpen,
    required this.days,
    required this.hours,
    required this.temporaryClosureDuration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      isOpen: json['is_open'] == "1",
      days: json['days'],
      hours: json['hours'],
      temporaryClosureDuration: json['temporary_closure_duration'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_open': isOpen ? "1" : "0",
        'days': days,
        'hours': hours,
        'temporary_closure_duration': temporaryClosureDuration,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class PathologicalCase {
  final String id;
  final String level;
  final String name;

  PathologicalCase({
    required this.id,
    required this.level,
    required this.name,
  });

  factory PathologicalCase.fromMap(Map<String, dynamic> json) =>
      PathologicalCase(
        id: json["_id"],
        level: json["level"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "level": level,
        "name": name,
      };
  static List<PathologicalCase> pathologicalCases(List data) =>
      data.map((e) => PathologicalCase.fromMap(e)).toList();
}

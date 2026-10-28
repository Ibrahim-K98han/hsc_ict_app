class Chapter {
  final int id;
  final String name;
  final int sortOrder;
  final int questionsCount;

  const Chapter({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.questionsCount,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json['id'] as int,
    name: json['name'] as String,
    sortOrder: json['sort_order'] as int,
    questionsCount: json['questions_count'] as int,
  );
}

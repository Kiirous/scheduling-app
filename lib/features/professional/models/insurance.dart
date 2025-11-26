class Insurance {
  const Insurance({required this.id, required this.name});

  factory Insurance.fromJson(Map<String, dynamic> map) {
    return Insurance(id: map['id'] as String, name: map['name'] as String);
  }

  final String id;
  final String name;
}

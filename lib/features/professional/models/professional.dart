class Professional {
  const Professional({
    required this.id,
    required this.name,
    required this.crm,
    this.picture,
    required this.rating,
    required this.ratingCount,
  });

  final String id;
  final String name;
  final String crm;
  final String? picture;
  final num rating;
  final int ratingCount;

  factory Professional.fromJson(Map<String, dynamic> map) {
    return Professional(
      id: map['id'] as String,
      name: map['name'] as String,
      crm: map['crm'] as String,
      picture: map['picture'] as String,
      rating: map['rating'] as num,
      ratingCount: map['ratingCount'] as int,
    );
  }
}

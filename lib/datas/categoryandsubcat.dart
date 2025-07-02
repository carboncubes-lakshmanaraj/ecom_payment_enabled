class Category {
  final int id;
  final String title;
  final String image;

  Category({required this.id, required this.title, required this.image});

  // For saving to SQLite
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'image': image};
  }

  // For reading from SQLite
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(id: map['id'], title: map['title'], image: map['image']);
  }
}

class SubCategory {
  final int id;
  final String title;

  SubCategory({required this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(id: map['id'], title: map['title']);
  }
}

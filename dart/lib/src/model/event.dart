import 'dart:convert';

import 'package:dart/src/model/model_base.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Event extends ModelBase {
  @override
  // ignore: overridden_fields
  final String? id;
  final String? title;
  final String? description;

  Event({
    this.id,
    this.title,
    this.description,
  });

  factory Event.initial() {
    return Event(
      id: "",
      title: "",
      description: "",
    );
  }

  Event copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Event.fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      return Event(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
      );
    } else {
      return Event.initial();
    }
  }
  factory Event.fromMongoMap(Map<String, dynamic>? map) {
    if (map != null) {
      return Event(
        id: (map['_id'] as ObjectId).toHexString(),
        title: map['title'] ?? '',
        description: map['description'] ?? '',
      );
    } else {
      return Event.initial();
    }
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Event(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}

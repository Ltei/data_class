// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// Generator: DataClassProcessor
// **************************************************************************

extension ModelExt on Model {
  Model copyWith({
    int id,
    DateTime creationDate,
    List subClass,
  }) {
    return Model(
      id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      subClass: subClass ?? this.subClass,
    );
  }

  bool dataEquals(dynamic other) =>
      other is Model &&
      (this.id == other.id ||
          const DeepCollectionEquality(const DefaultEquality())
              .equals(this.id, other.id)) &&
      (this.creationDate == other.creationDate ||
          const DeepCollectionEquality(const DefaultEquality())
              .equals(this.creationDate, other.creationDate)) &&
      (this.subClass == other.subClass ||
          const DeepCollectionEquality(const DefaultEquality())
              .equals(this.subClass, other.subClass));

  String dataToString() =>
      "Model(id=${this.id}, creationDate=${this.creationDate}, subClass=${this.subClass})";

  int get dataHashCode =>
      (Model).hashCode ^
      this.id.hashCode ^
      this.creationDate.hashCode ^
      this.subClass.hashCode;
}

extension SubClassExt on SubClass {
  SubClass copyWith({
    int id,
  }) {
    return SubClass(
      id ?? this.id,
    );
  }

  bool dataEquals(dynamic other) =>
      other is SubClass &&
      (this.id == other.id ||
          const DeepCollectionEquality(const DefaultEquality())
              .equals(this.id, other.id));

  String dataToString() => "SubClass(id=${this.id})";

  int get dataHashCode => (SubClass).hashCode ^ this.id.hashCode;
}

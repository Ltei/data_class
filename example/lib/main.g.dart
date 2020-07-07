// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

Model $buildModelFromJson(Map<String, dynamic> json) => Model(
      json["id"],
      creationDate: json["creationDate"],
      subClass: json["subClass"].map((e) => SubClass.fromJson(e)).toList(),
    );

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

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "creationDate": this.creationDate,
        "subClass": this.subClass.map((e) => e.toJson()).toList(),
      };

  bool dataEquals(dynamic other) =>
      other is Model &&
      this.id == other.id &&
      this.creationDate == other.creationDate &&
      this.subClass == other.subClass;

  String dataToString() =>
      "Model(id=${this.id}, creationDate=${this.creationDate}, subClass=${this.subClass})";

  int get dataHashCode =>
      (Model).hashCode ^
      this.id.hashCode ^
      this.creationDate.hashCode ^
      this.subClass.hashCode;
}

SubClass $buildSubClassFromJson(Map<String, dynamic> json) => SubClass(
      json["id"],
    );

extension SubClassExt on SubClass {
  SubClass copyWith({
    int id,
  }) {
    return SubClass(
      id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
      };

  bool dataEquals(dynamic other) => other is SubClass && this.id == other.id;

  String dataToString() => "SubClass(id=${this.id})";

  int get dataHashCode => (SubClass).hashCode ^ this.id.hashCode;
}

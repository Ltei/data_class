## DataClass

This library provides the @dataClass annotation, used to generate :
* equals
* hashCode
* toString
* copyWith

For example, this (main.dart) :

```dart
@dataClass
class Model {
  final int id;
  final DateTime creationDate;
  final List<SubClass> subClass;

  Model(this.id, {this.creationDate, this.subClass});

  @override int get hashCode => dataHashCode;
  @override bool operator ==(other) => dataEquals(other);
  @override String toString() => dataToString();
}

@dataClass
class SubClass {
  final int id;

  SubClass(this.id);
  
  @override int get hashCode => dataHashCode;
  @override bool operator ==(other) => dataEquals(other);
  @override String toString() => dataToString();
}
```

Will generate this (main.g.dart) :

```dart
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

extension SubClassExt on SubClass {
  SubClass copyWith({
    int id,
  }) {
    return SubClass(
      id ?? this.id,
    );
  }

  bool dataEquals(dynamic other) => other is SubClass && this.id == other.id;

  String dataToString() => "SubClass(id=${this.id})";

  int get dataHashCode => (SubClass).hashCode ^ this.id.hashCode;
}
```
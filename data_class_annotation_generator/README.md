## DataClass

### How to use :

Add this to your pubspec.yaml's dependency section :

```yaml
data_class_annotation: any
```

And this to the dev_dependency section :

```yaml
data_class_annotation_generator: any
```

### What it does :

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
  @DateOnlyEquality()
  final DateTime creationDate;
  @SubClassEquality()
  final List<SubClass> subClass;

  Model(this.id, {this.creationDate, this.subClass});

  @override
  int get hashCode => dataHashCode;

  @override
  bool operator ==(other) => dataEquals(other);

  @override
  String toString() => dataToString();
}

@dataClass
class SubClass {
  final int id;

  SubClass(this.id);

  @override
  int get hashCode => dataHashCode;

  @override
  bool operator ==(other) => dataEquals(other);

  @override
  String toString() => dataToString();
}

class DateOnlyEquality extends DefaultEquality<DateTime> {
  const DateOnlyEquality();

  @override
  bool equals(Object e1, Object e2) =>
      e1 is DateTime && e2 is DateTime && e1.year == e2.year && e1.month == e2.month && e1.day == e2.day;
}

class SubClassEquality extends DefaultEquality<SubClass> {
  const SubClassEquality();

  @override
  bool equals(Object e1, Object e2) => e1 is SubClass && e2 is SubClass && e1.id == e2.id;
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
      (this.id == other.id ||
          const DeepCollectionEquality(const DefaultEquality())
              .equals(this.id, other.id)) &&
      (const DateOnlyEquality().equals(this.creationDate, other.creationDate) ||
          const DeepCollectionEquality(const DateOnlyEquality())
              .equals(this.creationDate, other.creationDate)) &&
      (const SubClassEquality().equals(this.subClass, other.subClass) ||
          const DeepCollectionEquality(const SubClassEquality())
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

```

### Keep in mind :

To generate the copyWith method, data_class_annotation uses the first
constructor defined in the @dataClass annotated class.
If you want to use a specific constructor, just annotate it with the
@primaryConstructor annotation
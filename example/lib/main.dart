import 'package:flutter/material.dart';
import 'package:data_class/data_class.dart';

part 'main.g.dart';

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

class App extends StatelessWidget {
  static const TITLE = 'Model builder example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Text('Hello'),
    );
  }
}

void main() => runApp(App());

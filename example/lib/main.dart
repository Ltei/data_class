// Copyright (c) 2017, Ltei. All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the
// LICENSE file.

import 'package:data_class_annotation/data_class_annotation.dart';
import 'package:flutter/material.dart';

part 'main.g.dart';

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

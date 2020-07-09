import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:data_class/data_class.dart';
import 'package:data_class_generator/src/string_utils.dart';
import 'package:data_class_generator/src/type_utils.dart';

class ClassElementInfo {
  final ClassElement clazz;
  final String name;
  final List<FieldInfo> fields;
  final ConstructorElement primaryConstructor;

  ClassElementInfo._(this.clazz, this.name, this.fields, this.primaryConstructor);

  static ClassElementInfo parse(ClassElement clazz) {
    final name = clazz.name;
    final fields = clazz.fields.where((e) => !e.isStatic && !e.isSynthetic).map((e) {
      return FieldInfo(name: e.name, type: e.type);
    }).toList();
    final primaryConstructor = _getPrimaryConstructor(clazz);
    return ClassElementInfo._(clazz, name, fields, primaryConstructor);
  }

  String get constructorCallConstString =>
      primaryConstructor.parameters.isEmpty && primaryConstructor.isConst ? "const " : "";

  String get constructorCallNameString => primaryConstructor.name != "" ? ".${primaryConstructor.name}" : "";

  @override
  String toString() => "{clazz=$clazz, name=$name, fields=$fields, primaryConstructor=$primaryConstructor}";

  static ConstructorElement _getPrimaryConstructor(ClassElement classElement) {
    ConstructorElement constructor = classElement.constructors
        .firstWhere((e) => DartElementUtils.hasAnnotation(e, PrimaryConstructor), orElse: () => null);
    if (constructor == null) {
      if (classElement.constructors.length == 1) {
        constructor = classElement.constructors[0];
      } else {
//        throw Exception("Couldn't determine primary constructor for class ${classElement.name}.");
        constructor = classElement.constructors[0]; // TODO
      }
    }
    return constructor;
  }
}

class FieldInfo {
  final String name;
  final DartType type;

  FieldInfo({this.name, this.type});

  @override
  String toString() => "{name=$name, type=$type}";
}

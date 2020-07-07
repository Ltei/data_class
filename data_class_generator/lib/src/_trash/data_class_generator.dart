//import 'dart:async';
//
//import 'package:analyzer/dart/element/element.dart';
//import 'package:build/build.dart';
//import 'package:code_builder/code_builder.dart';
//import 'package:data_class/data_class.dart';
//import 'package:data_class_generator/src/class_element_info.dart';
//import 'package:data_class_generator/src/type_utils.dart';
//import 'package:source_gen/source_gen.dart';
//
//class DataClassGenerator extends GeneratorForAnnotation<DataClass> {
//  @override
//  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
//    if (element is! ClassElement)
//      throw InvalidGenerationSourceError('The element annotated with @DataClass is not a class.', element: element);
//
//    final ClassElement classElement = element as ClassElement;
//
////    print("Parsing annotation...");
//    DataClass dataClassAnnotation;
//    try {
//      dataClassAnnotation = classElement.getDataClassAnnotation();
//    } catch (e) {
//      throw InvalidGenerationSourceError("Couldn't find @DataClass annotation. ($e)", element: element);
//    }
//
////    print("Parsing classElementInfo...");
//    final classElementInfo = ClassElementInfo.parse(classElement);
//
//    final dataClassExtension = Code(_generateDataClassExtension(classElementInfo));
//
//    final library = Library((builder) => builder..body.add(dataClassExtension));
//    return library.accept(DartEmitter()).toString();
//  }
//
//  String _generateDataClassExtension(ClassElementInfo classElementInfo) {
//    return "extension ${classElementInfo.name}Ext on ${classElementInfo.name} {"
//        "${_generateMethodCopyWith(classElementInfo)} "
//        "${_generateMethodToJson(classElementInfo)} "
//        "${_generateMethodEquals(classElementInfo)} "
//        "}";
//  }
//
//  String _generateMethodCopyWith(ClassElementInfo classElementInfo) {
//    final paramsInput = classElementInfo.fields.fold("", (acc, e) => "$acc${e.type.name} ${e.name}, ");
//    final params = "{$paramsInput}";
//
//    final codeInput = classElementInfo.fields.fold("", (acc, e) => "$acc${e.name}: ${e.name} ?? this.${e.name}, ");
//    final code = "return ${classElementInfo.name}($codeInput);";
//
//    return "${classElementInfo.name} copyWith($params) {$code}";
//  }
//
//  String _generateMethodToJson(ClassElementInfo classElementInfo) {
//    final code = classElementInfo.fields.fold("", (acc, e) {
//      return "$acc\"${e.name}\": this.${e.name},";
//    });
//    return "Map<String, dynamic> toJson() => {$code};";
//  }
//
//  String _generateMethodEquals(ClassElementInfo classElementInfo) {
//    final code = StringBuffer();
//    for (int i=0; i<classElementInfo.fields.length; i++) {
//      final field = classElementInfo.fields[i];
//      code.write("this.${field.name} == other.${field.name}");
//      if (i < classElementInfo.fields.length - 1) {
//        code.write(" && ");
//      }
//    }
//    return "bool equals(dynamic other) => other is ${classElementInfo.name} && ${code.toString()};";
//  }
//}
//
//extension A on Class {}

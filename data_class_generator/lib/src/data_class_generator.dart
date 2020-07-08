import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:data_class/data_class.dart';
import 'package:data_class_generator/src/class_element_info.dart';
import 'package:data_class_generator/src/string_utils.dart';
import 'package:source_gen/source_gen.dart';

class DataClassGenerator extends GeneratorForAnnotation<DataClass> {

  static const DEFAULT_ADAPTER_DATA_CLASS = "DataClassAdapter";
  static const DEFAULT_ADAPTER_DATA_CLASS_LIST = "DataClassListAdapter";
  static final defaultAdapterNames = <String>[
    "DataClassAdapter",
    "DataClassListAdapter",
  ];

  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement)
      throw InvalidGenerationSourceError('The element annotated with @DataClass is not a class.', element: element);

    final ClassElement classElement = element as ClassElement;

    final classElementInfo = ClassElementInfo.parse(classElement);

    final dataClassExtension = Code(_generateDataClass(classElementInfo));


    final library = Library((builder) => builder..body.add(dataClassExtension));
    return library.accept(DartEmitter()).toString();
  }

  String _generateDataClass(ClassElementInfo classElementInfo) {
    return "${_generateAdapterValues(classElementInfo)}\n\n"
        "${_generateFunctionFromJson(classElementInfo)}\n\n"
        "extension ${classElementInfo.name}Ext on ${classElementInfo.name} {\n"
        "${_generateMethodCopyWith(classElementInfo)} \n\n"
        "${_generateMethodToJson(classElementInfo)} \n\n"
        "${_generateMethodEqualsData(classElementInfo)} \n\n"
        "${_generateMethodToStringData(classElementInfo)} \n\n"
        "int get dataHashCode => ${_generateHashCodeExpr(classElementInfo)}; \n"
        "}";
  }

  String _generateMethodCopyWith(ClassElementInfo classElementInfo) {
    String paramsString = classElementInfo.fields.fold("", (acc, e) => "$acc${e.type.name} ${e.name}, ");
    paramsString = paramsString.isEmpty ? "" : "{$paramsString}";

    StringBuffer constructorParamsStringBuffer = StringBuffer();
    for (final param in classElementInfo.primaryConstructor.parameters.where((e) => e.isPositional)) {
      constructorParamsStringBuffer..write("${param.name} ?? this.${param.name}, ");
    }
    for (final param in classElementInfo.primaryConstructor.parameters.where((e) => e.isNamed)) {
      constructorParamsStringBuffer..write("${param.name}: ${param.name} ?? this.${param.name}, ");
    }

    final code = "return ${classElementInfo.constructorCallConstString}${classElementInfo.name}${classElementInfo.constructorCallNameString}($constructorParamsStringBuffer);";

    return "${classElementInfo.name} copyWith($paramsString) {$code}";
  }

  String _generateMethodToJson(ClassElementInfo classElementInfo) {
    final code = classElementInfo.fields.fold("", (acc, e) {
      if (e.adapter != null) {
        if (e.adapter.name == DEFAULT_ADAPTER_DATA_CLASS) {
          return "$acc\"${e.serializedName ?? e.name}\": this.${e.name}.toJson(),";
        } else if (e.adapter.name == DEFAULT_ADAPTER_DATA_CLASS_LIST) {
          return "$acc\"${e.serializedName ?? e.name}\": this.${e.name}.map((e) => e.toJson()).toList(),";
        } else {
          final adapterValueName = classElementInfo.getFieldAdapterValueName(e);
          return "$acc\"${e.serializedName ?? e.name}\": $adapterValueName.toJson(this.${e.name}),";
        }
      } else {
        return "$acc\"${e.serializedName ?? e.name}\": this.${e.name},";
      }
    });
    return "Map<String, dynamic> dataToJson() => {$code};";
  }

  String _generateMethodEqualsData(ClassElementInfo classElementInfo) {
    final code = StringBuffer();
    for (int i = 0; i < classElementInfo.fields.length; i++) {
      final field = classElementInfo.fields[i];
      code.write("this.${field.name} == other.${field.name}");
      if (i < classElementInfo.fields.length - 1) {
        code.write(" && ");
      }
    }
    final fullCode =
        code.isEmpty ? "other is ${classElementInfo.name}" : "other is ${classElementInfo.name} && ${code.toString()}";
    return "bool dataEquals(dynamic other) => $fullCode;";
  }

  String _generateMethodToStringData(ClassElementInfo classElementInfo) {
    final code = StringBuffer();
    for (int i = 0; i < classElementInfo.fields.length; i++) {
      final field = classElementInfo.fields[i];
      code.write("${field.name}=\${this.${field.name}}");
      if (i < classElementInfo.fields.length - 1) {
        code.write(", ");
      }
    }
    return "String dataToString() => \"${classElementInfo.name}($code)\";";
  }

  String _generateHashCodeExpr(ClassElementInfo classElementInfo) {
    final code = StringBuffer();
    code.write("(${classElementInfo.name}).hashCode");
    for (int i = 0; i < classElementInfo.fields.length; i++) {
      final field = classElementInfo.fields[i];
      code.write(" ^ this.${field.name}.hashCode");
    }
    return code.toString();
  }

  String _generateAdapterValues(ClassElementInfo classElementInfo) {
    StringBuffer result = StringBuffer();
    final generatedAdapters = Set();
    for (final field in classElementInfo.fields) {
      if (field.adapter != null && !generatedAdapters.contains(field.adapter) && !defaultAdapterNames.contains(field.adapter.name)) {
        final adapterTypeName = field.adapter.name;
        final adapterValueName = classElementInfo.getFieldAdapterValueName(field);
        result.write("final $adapterTypeName $adapterValueName = const $adapterTypeName();\n");
      }
    }
    return result.toString();
  }

  String _generateFunctionFromJson(ClassElementInfo classElementInfo) {
    StringBuffer constructorParamsStringBuffer = StringBuffer();
    for (final param in classElementInfo.primaryConstructor.parameters) {
      final fieldInfo = classElementInfo.fields.firstWhere((e) => e.name == param.name);
      String convertedValueCode;
      if (fieldInfo.adapter != null) {
        if (DEFAULT_ADAPTER_DATA_CLASS == fieldInfo.adapter.name) {
          convertedValueCode = "${fieldInfo.type.name}.fromJson(json[\"${fieldInfo.serializedName ?? fieldInfo.name}\"]), ";
        } else if (DEFAULT_ADAPTER_DATA_CLASS_LIST == fieldInfo.adapter.name) {
          final listTypeName = fieldInfo.type.toString();
          final listItemTypeName = listTypeName.split("<")[1].split(">")[0];
          convertedValueCode = "json[\"${fieldInfo.serializedName ?? fieldInfo.name}\"].map((e) => $listItemTypeName.fromJson(e)).toList(), ";
        }  else {
          final adapterValueName = classElementInfo.getFieldAdapterValueName(fieldInfo);
          convertedValueCode = "$adapterValueName.fromJson(json[\"${fieldInfo.serializedName ?? fieldInfo.name}\"]), ";
        }
      } else {
        convertedValueCode = "json[\"${fieldInfo.serializedName ?? fieldInfo.name}\"], ";
      }

      if (param.isNamed) {
        constructorParamsStringBuffer.write("${param.name}: ");
      }
      constructorParamsStringBuffer.write(convertedValueCode);
    }

    return "${classElementInfo.name} \$build${classElementInfo.name}FromJson(Map<String, dynamic> json) => ${classElementInfo.constructorCallConstString}${classElementInfo.name}${classElementInfo.constructorCallNameString}($constructorParamsStringBuffer);";
  }
}
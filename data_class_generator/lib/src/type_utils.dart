import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:data_class/data_class.dart';
import 'package:data_class_generator/src/extracted_model.dart';
import 'package:source_gen/source_gen.dart';

//class AnnotationExtractor {
//  static final TypeChecker _typeAdapterChecker = TypeChecker.fromRuntime(TypeAdapter);
//
//  static TypeAdapter extractTypeAdapter(DartType targetType, ElementAnnotation annotation) {
//    final constantValue = annotation.computeConstantValue();
//    final converterClassElement = constantValue.type.element as ClassElement;
//
//    final typeAdapterSuper = converterClassElement.allSupertypes
//        .singleWhere((e) => _typeAdapterChecker.isExactly(e.element), orElse: () => null);
//    if (typeAdapterSuper == null) {
//      return null;
//    }
//
//    assert(typeAdapterSuper.element.typeParameters.length == 2);
//    assert(typeAdapterSuper.typeArguments.length == 2);
//
//    final fieldType = typeAdapterSuper.typeArguments[0];
//
//    if (fieldType == targetType) {
//
//    }
//  }
//}

class DartElementUtils {
  static bool hasAnnotation(Element element, final Type type) {
    return _typeChecker(type).hasAnnotationOfExact(element);
  }

  static DartObject getAnnotation(Element element, final Type type) {
    try {
      return _typeChecker(type).firstAnnotationOfExact(element);
    } catch (e) {
      throw Exception("Couldn't get $type annotation on $element ($e)");
    }
  }

  static List<DartObject> getAnnotations(Element element, final Type type) {
    try {
      return _typeChecker(type).annotationsOfExact(element).toList();
    } catch (e) {
      throw Exception("Couldn't get $type annotations on $element ($e)");
    }
  }
}

class DartObjectUtils {
  static DataClass loadDataClass(DartObject object) {
    return const DataClass();
  }

  static PrimaryConstructor loadPrimaryConstructor(DartObject object) {
    return const PrimaryConstructor();
  }

  static ExtractedDataField loadDataField(DartObject object) {
    return ExtractedDataField(
      serializedName: object?.getField("serializedName")?.toStringValue(),
      adapter: object?.getField("adapter")?.toTypeValue(),
    );
  }
}

class AnnotationUtils {
  static DataClass getDataClassAnnotation(Element element) {
    final annotation = DartElementUtils.getAnnotation(element, DataClass);
    return DartObjectUtils.loadDataClass(annotation);
  }

  static PrimaryConstructor getPrimaryConstructorAnnotation(Element element) {
    final annotation = DartElementUtils.getAnnotation(element, PrimaryConstructor);
    return DartObjectUtils.loadPrimaryConstructor(annotation);
  }

  static ExtractedDataField getDataFieldAnnotation(Element element) {
    final annotation = DartElementUtils.getAnnotation(element, DataField);
    return DartObjectUtils.loadDataField(annotation);
  }
}

TypeChecker _typeChecker(final Type type) => TypeChecker.fromRuntime(type);

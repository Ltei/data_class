// Copyright (c) 2017, Ltei. All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the
// LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:data_class_annotation/data_class_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// Misc methods for Element manipulation.
class DartElementUtils {
  static bool hasAnnotationOf(Element element, final Type type) {
    return _typeChecker(type).hasAnnotationOf(element);
  }

  static DartObject getAnnotationOf(Element element, final Type type) {
    try {
      return _typeChecker(type).firstAnnotationOf(element);
    } catch (e) {
      throw Exception("Couldn't get $type annotation on $element ($e)");
    }
  }

  static List<DartObject> getAnnotationsOf(Element element, final Type type) {
    try {
      return _typeChecker(type).annotationsOf(element).toList();
    } catch (e) {
      throw Exception("Couldn't get $type annotations on $element ($e)");
    }
  }
  
  static bool hasAnnotationOfExact(Element element, final Type type) {
    return _typeChecker(type).hasAnnotationOfExact(element);
  }

  static DartObject getAnnotationOfExact(Element element, final Type type) {
    try {
      return _typeChecker(type).firstAnnotationOfExact(element);
    } catch (e) {
      throw Exception("Couldn't get $type annotation on $element ($e)");
    }
  }

  static List<DartObject> getAnnotationsOfExact(Element element, final Type type) {
    try {
      return _typeChecker(type).annotationsOfExact(element).toList();
    } catch (e) {
      throw Exception("Couldn't get $type annotations on $element ($e)");
    }
  }
}

/// Misc methods for DartObject manipulation.
class DartObjectUtils {
  static DataClass loadDataClass(DartObject object) {
    return DataClass(
      generateCopyWith: object.getField('generateCopyWith').toBoolValue(),
      generateDataToString: object.getField('generateDataToString').toBoolValue(),
      generateDataHashCode: object.getField('generateDataHashCode').toBoolValue(),
      generateDataEquals: object.getField('generateDataEquals').toBoolValue(),
    );
  }

  static PrimaryConstructor loadPrimaryConstructor(DartObject object) {
    return const PrimaryConstructor();
  }
}

/// Misc methods for annotation Element manipulation.
class AnnotationUtils {
  static DataClass getDataClassAnnotation(Element element) {
    final annotation = DartElementUtils.getAnnotationOfExact(element, DataClass);
    return DartObjectUtils.loadDataClass(annotation);
  }

  static PrimaryConstructor getPrimaryConstructorAnnotation(Element element) {
    final annotation =
        DartElementUtils.getAnnotationOfExact(element, PrimaryConstructor);
    return DartObjectUtils.loadPrimaryConstructor(annotation);
  }
}

TypeChecker _typeChecker(final Type type) => TypeChecker.fromRuntime(type);

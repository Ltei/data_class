import 'package:build/build.dart';
import 'package:data_class_annotation_generator/src/processor.dart';
import 'package:source_gen/source_gen.dart';

Builder dataClass(BuilderOptions options) => SharedPartBuilder([DataClassGenerator()], 'data_class');

import 'package:analyzer/dart/element/type.dart';

class ExtractedDataField {
  final String serializedName;
  final DartType adapter;

  const ExtractedDataField({
    this.serializedName,
    this.adapter
  });
}
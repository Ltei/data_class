class DataClass {
  const DataClass();
}

class PrimaryConstructor {
  const PrimaryConstructor();
}

class DataField {
  final String serializedName;
  final Type adapter;

  const DataField({
    this.serializedName,
    this.adapter
  });
}

//

const DataClass dataClass = const DataClass();

const PrimaryConstructor primaryConstructor = const PrimaryConstructor();

//

abstract class TypeAdapter<T, S> {
  const TypeAdapter();

  S toJson(T obj);
  T fromJson(S json);
}

class DataClassAdapter extends TypeAdapter<dynamic, Map<String, dynamic>> {
  const DataClassAdapter();

  Map<String, dynamic> toJson(dynamic obj) => throw Exception("");
  dynamic fromJson(Map<String, dynamic> json) => throw Exception("");
}

class DataClassListAdapter extends TypeAdapter<List<dynamic>, List<Map<String, dynamic>>> {
  const DataClassListAdapter();

  List<Map<String, dynamic>> toJson(List<dynamic> obj) => throw Exception("");
  List<dynamic> fromJson(List<Map<String, dynamic>> json) => throw Exception("");
}
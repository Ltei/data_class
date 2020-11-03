// Copyright (c) 2017, Ltei. All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the
// LICENSE file.

/// An annotation used to specify a class to generate code for.
class DataClass {
  final bool generateCopyWith;
  final bool generateDataToString;
  final bool generateDataHashCode;
  final bool generateDataEquals;

  const DataClass({
    this.generateCopyWith = true,
    this.generateDataToString = true,
    this.generateDataHashCode = true,
    this.generateDataEquals = true,
  });
}

/// An annotation used to specify the data class primary constructor.
/// This is only needed when the generator doesn't automatically find the
/// primary constructor.
class PrimaryConstructor {
  const PrimaryConstructor();
}

/// An instance of the DataClass annotation.
/// Prefer using @dataClass instead of @DataClass().
const DataClass dataClass = DataClass();

/// An instance of the PrimaryConstructor annotation.
/// Prefer using @primaryConstructor instead of @PrimaryConstructor().
const PrimaryConstructor primaryConstructor = PrimaryConstructor();

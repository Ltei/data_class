// Copyright (c) 2017, Ltei. All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the
// LICENSE file.

import 'package:build/build.dart';
import 'package:data_class_annotation_generator/src/processor.dart';
import 'package:source_gen/source_gen.dart';

/// Supports 'package:build_runner' creation and configuration of
/// 'data_class_annotation'.
///
/// Not meant to be invoked by hand-authored code.
Builder dataClass(BuilderOptions options) =>
    SharedPartBuilder([DataClassProcessor()], 'data_class');

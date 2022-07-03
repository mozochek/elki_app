import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum HouseType { oFrame, aFrame, all }

@immutable
class HouseFilter with EquatableMixin {
  final HouseType type;

  const HouseFilter({
    required this.type,
  });

  @override
  List<Object?> get props => [type];
}

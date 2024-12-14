// // lib/models/time_slot.dart
//
// import 'package:flutter/material.dart';
//
// /// Data model for time slots
// class TimeSlot {
//   final TimeOfDay start;
//   final TimeOfDay end;
//   final bool isBreak;
//
//   TimeSlot({required this.start, required this.end, this.isBreak = false});
//
//   bool get isValid => start.hour != 0 && end.hour != 0;
//
//   // Override equality and hashCode to use TimeSlot as a key in Map
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is TimeSlot &&
//               runtimeType == other.runtimeType &&
//               start.hour == other.start.hour &&
//               start.minute == other.start.minute &&
//               end.hour == other.end.hour &&
//               end.minute == other.end.minute &&
//               isBreak == other.isBreak;
//
//   @override
//   int get hashCode =>
//       start.hour.hashCode ^
//       start.minute.hashCode ^
//       end.hour.hashCode ^
//       end.minute.hashCode ^
//       isBreak.hashCode;
// }

// lib/models/time_slot.dart

import 'package:flutter/material.dart';

/// Data model for time slots
class TimeSlot {
  final TimeOfDay start;
  final TimeOfDay end;
  final bool isBreak;

  TimeSlot({required this.start, required this.end, this.isBreak = false});

  bool get isValid => start.hour != 0 && end.hour != 0;

  // Override equality and hashCode to use TimeSlot as a key in Map
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TimeSlot &&
              runtimeType == other.runtimeType &&
              start.hour == other.start.hour &&
              start.minute == other.start.minute &&
              end.hour == other.end.hour &&
              end.minute == other.end.minute &&
              isBreak == other.isBreak;

  @override
  int get hashCode =>
      start.hour.hashCode ^
      start.minute.hashCode ^
      end.hour.hashCode ^
      end.minute.hashCode ^
      isBreak.hashCode;
}

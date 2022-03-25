// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTaskAdapter extends TypeAdapter<UserTask> {
  @override
  final int typeId = 1;

  @override
  UserTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTask(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
      fields[3] as DateTime,
      fields[4] as DateTime,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserTask obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.dateAdded)
      ..writeByte(4)
      ..write(obj.dateDue)
      ..writeByte(5)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

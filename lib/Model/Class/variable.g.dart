// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VariableAdapter extends TypeAdapter<Variable> {
  @override
  final int typeId = 0;

  @override
  Variable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Variable(
      name: fields[0] as String,
      value: fields[1] as double,
      variableType: fields[2] as VariableType,
    );
  }

  @override
  void write(BinaryWriter writer, Variable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.variableType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

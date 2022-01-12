// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contrainte.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContrainteAdapter extends TypeAdapter<Contrainte> {
  @override
  final int typeId = 4;

  @override
  Contrainte read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contrainte(
      variables: (fields[0] as List).cast<Variable>(),
      inegalite: fields[1] as Inegalite,
      value: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Contrainte obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.variables)
      ..writeByte(1)
      ..write(obj.inegalite)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContrainteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

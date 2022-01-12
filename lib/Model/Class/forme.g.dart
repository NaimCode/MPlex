// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormeAdapter extends TypeAdapter<Forme> {
  @override
  final int typeId = 3;

  @override
  Forme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forme(
      type: fields[1] as FormeType,
      contraintes: (fields[0] as List).cast<Contrainte>(),
    );
  }

  @override
  void write(BinaryWriter writer, Forme obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.contraintes)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'probleme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProblemeAdapter extends TypeAdapter<Probleme> {
  @override
  final int typeId = 2;

  @override
  Probleme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Probleme(
      forme: fields[3] as Forme,
      type: fields[4] as ProblemeType,
      name: fields[2] as String,
      variables: (fields[0] as List).cast<Variable>(),
    )..nameVariableEcart = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Probleme obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.nameVariableEcart)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.forme)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(0)
      ..write(obj.variables);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

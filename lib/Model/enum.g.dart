// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InegaliteAdapter extends TypeAdapter<Inegalite> {
  @override
  final int typeId = 100;

  @override
  Inegalite read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Inegalite.SUP_EGAL;
      case 1:
        return Inegalite.INF_EGAL;
      case 2:
        return Inegalite.EGAL;
      case 3:
        return Inegalite.SUP;
      case 4:
        return Inegalite.INF;
      case 5:
        return Inegalite.INDEFINI;
      default:
        return Inegalite.SUP_EGAL;
    }
  }

  @override
  void write(BinaryWriter writer, Inegalite obj) {
    switch (obj) {
      case Inegalite.SUP_EGAL:
        writer.writeByte(0);
        break;
      case Inegalite.INF_EGAL:
        writer.writeByte(1);
        break;
      case Inegalite.EGAL:
        writer.writeByte(2);
        break;
      case Inegalite.SUP:
        writer.writeByte(3);
        break;
      case Inegalite.INF:
        writer.writeByte(4);
        break;
      case Inegalite.INDEFINI:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InegaliteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VariableTypeAdapter extends TypeAdapter<VariableType> {
  @override
  final int typeId = 1;

  @override
  VariableType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VariableType.DECISION;
      case 1:
        return VariableType.ECART;
      default:
        return VariableType.DECISION;
    }
  }

  @override
  void write(BinaryWriter writer, VariableType obj) {
    switch (obj) {
      case VariableType.DECISION:
        writer.writeByte(0);
        break;
      case VariableType.ECART:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariableTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FormeTypeAdapter extends TypeAdapter<FormeType> {
  @override
  final int typeId = 99;

  @override
  FormeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FormeType.CANONIQUE;
      case 1:
        return FormeType.STANDARD;
      default:
        return FormeType.CANONIQUE;
    }
  }

  @override
  void write(BinaryWriter writer, FormeType obj) {
    switch (obj) {
      case FormeType.CANONIQUE:
        writer.writeByte(0);
        break;
      case FormeType.STANDARD:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProblemeTypeAdapter extends TypeAdapter<ProblemeType> {
  @override
  final int typeId = 98;

  @override
  ProblemeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ProblemeType.MAX;
      case 1:
        return ProblemeType.MIN;
      default:
        return ProblemeType.MAX;
    }
  }

  @override
  void write(BinaryWriter writer, ProblemeType obj) {
    switch (obj) {
      case ProblemeType.MAX:
        writer.writeByte(0);
        break;
      case ProblemeType.MIN:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExceptionsAdapter extends TypeAdapter<Exceptions> {
  @override
  final int typeId = 97;

  @override
  Exceptions read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Exceptions.DEJA_STANDARD;
      case 1:
        return Exceptions.ERREUR_CREATION_TABLEAU;
      default:
        return Exceptions.DEJA_STANDARD;
    }
  }

  @override
  void write(BinaryWriter writer, Exceptions obj) {
    switch (obj) {
      case Exceptions.DEJA_STANDARD:
        writer.writeByte(0);
        break;
      case Exceptions.ERREUR_CREATION_TABLEAU:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExceptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SolutionTypeAdapter extends TypeAdapter<SolutionType> {
  @override
  final int typeId = 96;

  @override
  SolutionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SolutionType.FINAL;
      case 1:
        return SolutionType.INITIAL;
      case 2:
        return SolutionType.OPTIMAL;
      default:
        return SolutionType.FINAL;
    }
  }

  @override
  void write(BinaryWriter writer, SolutionType obj) {
    switch (obj) {
      case SolutionType.FINAL:
        writer.writeByte(0);
        break;
      case SolutionType.INITIAL:
        writer.writeByte(1);
        break;
      case SolutionType.OPTIMAL:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolutionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

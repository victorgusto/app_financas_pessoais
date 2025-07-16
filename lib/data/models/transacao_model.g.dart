// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transacao_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransacaoModelAdapter extends TypeAdapter<TransacaoModel> {
  @override
  final int typeId = 0;

  @override
  TransacaoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransacaoModel(
      id: fields[0] as String,
      descricao: fields[1] as String,
      valor: fields[2] as double,
      data: fields[3] as DateTime,
      tipo: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransacaoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.valor)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(4)
      ..write(obj.tipo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransacaoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

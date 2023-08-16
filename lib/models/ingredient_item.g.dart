// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientItemAdapter extends TypeAdapter<IngredientItem> {
  @override
  final int typeId = 10;

  @override
  IngredientItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientItem(
      uuid: fields[0] as String?,
      name: fields[1] as String,
      allowInventory: fields[2] as bool,
      inventory: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.allowInventory)
      ..writeByte(3)
      ..write(obj.inventory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

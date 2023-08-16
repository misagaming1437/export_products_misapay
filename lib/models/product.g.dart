// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 6;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      uuid: fields[0] as String?,
      title: fields[1] as String,
      price: fields[3] as int,
      originalPrice: fields[4] as int,
      image: fields[2] as String?,
      isActive: fields[5] as bool,
      allowInventory: fields[6] as bool,
      inventory: fields[7] as int,
      printerId: fields[8] as String?,
      menuUuid: fields[9] as String,
      ingredients:
          fields[10] == null ? [] : (fields[10] as List).cast<Ingredient>(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.originalPrice)
      ..writeByte(5)
      ..write(obj.isActive)
      ..writeByte(6)
      ..write(obj.allowInventory)
      ..writeByte(7)
      ..write(obj.inventory)
      ..writeByte(8)
      ..write(obj.printerId)
      ..writeByte(9)
      ..write(obj.menuUuid)
      ..writeByte(10)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

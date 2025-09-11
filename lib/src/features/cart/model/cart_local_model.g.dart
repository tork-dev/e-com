// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemLocalAdapter extends TypeAdapter<CartItemLocal> {
  @override
  final int typeId = 0;

  @override
  CartItemLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemLocal(
      id: fields[0] as int?,
      slug: fields[1] as String?,
      productId: fields[4] as int?,
      productName: fields[5] as String?,
      productThumbnailImage: fields[6] as String?,
      isPreorder: fields[7] as int?,
      price: fields[9] as double?,
      quantity: fields[13] as int?,
      lowerLimit: fields[14] as int?,
      upperLimit: fields[15] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemLocal obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(4)
      ..write(obj.productId)
      ..writeByte(5)
      ..write(obj.productName)
      ..writeByte(6)
      ..write(obj.productThumbnailImage)
      ..writeByte(7)
      ..write(obj.isPreorder)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(13)
      ..write(obj.quantity)
      ..writeByte(14)
      ..write(obj.lowerLimit)
      ..writeByte(15)
      ..write(obj.upperLimit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

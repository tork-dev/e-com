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

class CartItemGetResponseAdapter extends TypeAdapter<CartItemGetResponse> {
  @override
  final int typeId = 1;

  @override
  CartItemGetResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemGetResponse(
      name: fields[0] as String?,
      ownerId: fields[1] as int?,
      cartItems: (fields[2] as List?)?.cast<CartItemLocal>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartItemGetResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.ownerId)
      ..writeByte(2)
      ..write(obj.cartItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemGetResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

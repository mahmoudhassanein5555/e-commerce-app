// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCartModelAdapter extends TypeAdapter<ProductCartModel> {
  @override
  final int typeId = 1;

  @override
  ProductCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCartModel(
      id: (fields[0] as num).toInt(),
      title: fields[1] as String,
      image: fields[2] as String,
      price: fields[3] as String,
      quantity: (fields[4] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductCartModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsResponseDtoAdapter extends TypeAdapter<ProductsResponseDto> {
  @override
  final typeId = 1;

  @override
  ProductsResponseDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsResponseDto(
      id: (fields[0] as num?)?.toInt(),
      title: fields[1] as String?,
      price: (fields[2] as num?)?.toInt(),
      images: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductsResponseDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsResponseDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

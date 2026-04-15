part of 'product_favorite_model.dart';

class ProductFavoriteModelAdapter extends TypeAdapter<ProductFavoriteModel> {
  @override
  final int typeId = 0;

  @override
  ProductFavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductFavoriteModel(
      title: fields[0] as String,
      image: fields[1] as String,
      price: fields[2] as String,
      productId: (fields[3] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductFavoriteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.productId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductFavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

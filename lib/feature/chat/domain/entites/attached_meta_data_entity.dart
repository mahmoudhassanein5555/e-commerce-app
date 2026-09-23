import 'package:equatable/equatable.dart';

class AttachedMetaDataEntity extends Equatable {
  final String? attachedId;
  final String? productImageUrl;
  final num? productPrice;
  final String? productTitle;

  const AttachedMetaDataEntity({
    this.attachedId,
    this.productImageUrl,
    this.productPrice,
    this.productTitle,
  });

  @override
  List<Object?> get props => [
        attachedId,
        productImageUrl,
        productPrice,
        productTitle,
      ];
}

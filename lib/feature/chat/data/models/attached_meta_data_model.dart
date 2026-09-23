import 'package:cloud_firestore/cloud_firestore.dart';

class AttachedMetaDataModel {
  final String? attachedId;
  final String? productImageUrl;
  final num? productPrice;
  final String? productTitle;

  AttachedMetaDataModel({
    this.attachedId,
    this.productImageUrl,
    this.productPrice,
    this.productTitle,
  });

  factory AttachedMetaDataModel.fromJson(Map<String, dynamic> json) {
    return AttachedMetaDataModel(
      attachedId: json['attachedId'] as String?,
      productImageUrl: json['productImageUrl'] as String?,
      productPrice: json['productPrice'] as num?,
      productTitle: json['productTitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (attachedId != null) 'attachedId': attachedId,
      if (productImageUrl != null) 'productImageUrl': productImageUrl,
      if (productPrice != null) 'productPrice': productPrice,
      if (productTitle != null) 'productTitle': productTitle,
    };
  }
}

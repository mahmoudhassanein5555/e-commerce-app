import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/details/data/api/details_api.dart';
import 'package:e_commerce_app/feature/details/data/models/product_details_dto.dart';
import 'package:e_commerce_app/feature/details/domain/entites/product_details_entity.dart';
import 'package:e_commerce_app/feature/details/domain/repositories/data_source/product_details_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsDataSource)
class ProductDetailsDataSourceImp implements ProductDetailsDataSource {
  final ProductDetailsApi _productDetailsApi;
  ProductDetailsDataSourceImp(this._productDetailsApi);

  @override
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(
      int productId) async {
    var response = await _productDetailsApi.getProductDetails(productId);
    switch (response) {
      case SuccessAPI<ProductDetailsDto>():
        var productDetails = response.data;
        var data = productDetails?.toEntity();
        return SuccessAPI<ProductDetailsEntity>(data);

      case ErrorAPI<ProductDetailsDto>():
        return ErrorAPI<ProductDetailsEntity>(response.messageError);
    }
  }
}

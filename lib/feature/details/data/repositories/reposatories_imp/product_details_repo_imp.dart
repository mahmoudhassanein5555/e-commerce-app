import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/details/domain/entites/product_details_entity.dart';
import 'package:e_commerce_app/feature/details/domain/repositories/data_source/product_details_data_source.dart';
import 'package:e_commerce_app/feature/details/domain/repositories/repo/product_details_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRepo)
class ProductsDetailsRepoImp implements ProductDetailsRepo {
  final ProductDetailsDataSource _productDetailsDataSource;
  ProductsDetailsRepoImp(this._productDetailsDataSource);
  @override
  Future<ResultApi<ProductDetailsEntity>> getProductDetails(int productId) =>
      _productDetailsDataSource.getProductDetails(productId);
}

import 'package:e_commerce_app/core/network/result_api.dart';
import 'package:e_commerce_app/feature/details/domain/entites/product_details_entity.dart';
import 'package:e_commerce_app/feature/details/domain/repositories/repo/product_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductDetailsUseCase {
  ProductDetailsRepo productDetailsRepo;

  GetProductDetailsUseCase(this.productDetailsRepo);

  Future<ResultApi<ProductDetailsEntity>> invoke(int productId) =>
      productDetailsRepo.getProductDetails(productId);
}

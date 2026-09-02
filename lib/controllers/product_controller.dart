import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductController extends GetxController {
  static const String _apiUrl = 'https://fakestoreapi.com/products';

  // Reaktif state'ler
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await http
          .get(Uri.parse(_apiUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        products.value = data
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        hasError.value = true;
      }
    } catch (_) {
      // İnternet yok / timeout / parse hatası -> uygulama çökmez,
      // hata durumu tetiklenir; View bu durumda yerel (assets) görseli gösterir.
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }
}

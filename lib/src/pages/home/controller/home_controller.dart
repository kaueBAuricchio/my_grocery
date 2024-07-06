import 'package:get/get.dart';
import 'package:my_grocery/src/models/category_model.dart';
import 'package:my_grocery/src/models/item_model.dart';
import 'package:my_grocery/src/pages/home/repository/home_repository.dart';
import 'package:my_grocery/src/pages/home/result/home_result.dart';
import 'package:my_grocery/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  bool isCategoryLoading = false;
  bool isProductLoading = true;

  List<CategoryModel> allCategories = [];
  CategoryModel? categoryModel;
  List<ItemModel> get allproducts => categoryModel?.items ?? [];

  RxString searchTitle = ''.obs;

  bool get isLastPage {
    if (categoryModel!.items.length < itemsPerPage) return true;

    return categoryModel!.pagination * itemsPerPage > allproducts.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }

    update();
  }

  @override
  onInit() {
    super.onInit();

    debounce(searchTitle, (_) => filterTitle(),
        time: const Duration(milliseconds: 600));

    getAllCategories();
  }

  void filterTitle() {
    //Delete all prpducts to category
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == '');

      if (c == null) {
        //Create new category for all categories
        final allCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    categoryModel = allCategories.first;

    update();

    getAllProducts();
  }

  void selectCategory(CategoryModel category) {
    categoryModel = category;
    update();

    if (categoryModel!.items.isNotEmpty) return;

    getAllProducts();
  }

  void loadingMoreProducts() {
    categoryModel!.pagination++;
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true, isProduct: true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();

    setLoading(false, isProduct: true);

    homeResult.when(success: (data) {
      allCategories.assignAll(data);

      if (allCategories.isEmpty) return;

      selectCategory(allCategories.first);
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }

  Future<void> getAllProducts({bool loading = true}) async {
    if (loading) {
      setLoading(true);
    }

    Map<String, dynamic> body = {
      'page': categoryModel!.pagination,
      'categoryId': categoryModel!.id,
      "itemsPwePage": itemsPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (categoryModel!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false);

    result.when(success: (data) {
      categoryModel!.items.addAll(data);
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }
}

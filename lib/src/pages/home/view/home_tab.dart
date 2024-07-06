import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/src/config/custom_colors.dart';
import 'package:my_grocery/src/pages/base/controller/base_controller.dart';
import 'package:my_grocery/src/pages/cart/controller/cart_controller.dart';
import 'package:my_grocery/src/pages/common_widget/custom_shimmer.dart';
import 'package:my_grocery/src/pages/home/controller/home_controller.dart';
import 'package:my_grocery/src/pages/home/view/components/category_tile.dart';
import 'package:my_grocery/src/models/app_data.dart' as appData;
import 'package:my_grocery/src/pages/home/view/components/item_tile.dart';
import 'package:my_grocery/src/pages/common_widget/app_name_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  final searchController = TextEditingController();
  final baseController = Get.find<BaseController>();

  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        centerTitle: true,
        elevation: 0,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GetBuilder<CartController>(
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    baseController.navigatePageView(NavigationTabs.cart);
                  },
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                        badgeColor: CustomColors.customContrastColor),
                    badgeContent: Text(
                      controller.cartItems.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    child: AddToCartIcon(
                      key: globalKeyCartItems,
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (animationCart) {
          runAddToCartAnimation = animationCart;
        },
        child: Column(
          children: [
            //Textfield search
            GetBuilder<HomeController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Pesquise aqui...',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.customSwatchColor.shade300,
                        size: 12,
                      ),
                      suffixIcon: controller.searchTitle.value.isEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = "";
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: CustomColors.customContrastColor,
                                size: 21,
                              ),
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                    ),
                  ),
                );
              },
            ),

            //Categories
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return CategoryTile(
                              onPressed: () {
                                setState(() {
                                  controller.selectCategory(
                                      controller.allCategories[index]);
                                });
                              },
                              category: controller.allCategories[index].title,
                              isSelected: appData.categories[index] ==
                                  controller.categoryModel,
                            );
                          },
                          separatorBuilder: (_, index) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: appData.categories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              10,
                              (index) => Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 12),
                                    child: CustomShimmer(
                                      height: 60,
                                      width: 80,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ))),
                );
              },
            ),
            //Grid
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProductLoading
                      ? Visibility(
                          visible: (controller.categoryModel?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off,
                                  size: 40,
                                  color: CustomColors.customContrastColor),
                              const Text('Nao ha itens para apresentar')
                            ],
                          ),
                          child: GridView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 9 / 11.5),
                              itemCount: controller.allproducts.length,
                              itemBuilder: (_, index) {
                                if (index + 1 ==
                                        controller.allproducts.length &&
                                    !controller.isLastPage) {
                                  controller.loadingMoreProducts();
                                }

                                return ItemTile(
                                    item: controller.allproducts[index],
                                    cartAnimation: itemSelectedCartAnimation);
                              }),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                              10,
                              (index) => CustomShimmer(
                                    height: double.infinity,
                                    width: double.infinity,
                                    borderRadius: BorderRadius.circular(20),
                                  ))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:shopsproductsapp/constants/app_typography.dart';
import 'package:shopsproductsapp/model/category_model.dart';
import 'package:shopsproductsapp/model/product_model.dart';
import 'package:shopsproductsapp/utils/responsive.dart';
import 'package:shopsproductsapp/view/product_details_view.dart';
import 'package:shopsproductsapp/view/profile_view.dart';
import 'package:shopsproductsapp/viewmodel/category_product_viewmodel.dart';
import 'package:shopsproductsapp/widgets/custom_snackabr.dart';

class Product_View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<CategoryProductViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewModel.fetchCategories();
      await viewModel.fetchProducts();
      CustomSnackBar.show(
        context,
        snackBarType: SnackBarType.success,
        label: 'Data fetched successfully!',
        bgColor: Colors.green,
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen", style: AppTypography.outfitBold),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Consumer<CategoryProductViewModel>(
          builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Container(
              height: context.responsive.hp(10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.categories.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.all(context.responsive.wp(2)),
                      child: ChoiceChip(
                        label: Text(
                          'All',
                          style: AppTypography.outfitRegular.copyWith(
                            fontSize: context.responsive.sp(14),
                          ),
                        ),
                        selected: viewModel.filteredProducts.length ==
                            viewModel.products.length,
                        onSelected: (isSelected) {
                          viewModel.filterProductsByCategory(
                              null); 
                        },
                      ),
                    );
                  } else {
                    final Category category =
                        viewModel.categories[index - 1]; 
                    return Padding(
                      padding: EdgeInsets.all(context.responsive.wp(2)),
                      child: ChoiceChip(
                        label: Text(
                          category.catName,
                          style: AppTypography.outfitRegular.copyWith(
                            fontSize: context.responsive.sp(14),
                          ),
                        ),
                        selected: viewModel.filteredProducts.isEmpty ||
                            viewModel.filteredProducts[0].partsCat ==
                                category.id,
                        onSelected: (isSelected) {
                          viewModel.filterProductsByCategory(category.id);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(context.responsive.wp(2)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.responsive.width > 600 ? 3 : 2,
                  crossAxisSpacing: context.responsive.wp(2),
                  mainAxisSpacing: context.responsive.hp(2),
                  childAspectRatio: 3 / 4,
                ),
                itemCount: viewModel.filteredProducts.length,
                itemBuilder: (context, index) {
                  final Products product = viewModel.filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              product.partImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/icons/pngtree-no-image-available-icon-flatvector-illustration-pic-design-profile-vector-png-image_40966566.jpg',
                                  fit: BoxFit.fitHeight,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(context.responsive.wp(2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.partsName ?? 'No Name',
                                  style: AppTypography.outfitBold.copyWith(
                                    fontSize: context.responsive.sp(16),
                                  ),
                                ),
                                SizedBox(height: context.responsive.hp(0.5)),
                                Text(
                                  '\$${product.price}',
                                  style: AppTypography.outfitRegular.copyWith(
                                    fontSize: context.responsive.sp(14),
                                  ),
                                ),
                                SizedBox(height: context.responsive.hp(0.5)),
                                Text(
                                  'Rating: ${product.productRating}',
                                  style: AppTypography.outfitLight.copyWith(
                                    fontSize: context.responsive.sp(12),
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

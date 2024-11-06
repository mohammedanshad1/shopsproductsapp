import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsproductsapp/constants/app_typography.dart';
import 'package:shopsproductsapp/model/category_model.dart';
import 'package:shopsproductsapp/model/product_model.dart';
import 'package:shopsproductsapp/utils/responsive.dart';
import 'package:shopsproductsapp/viewmodel/category_product_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<CategoryProductViewModel>(context, listen: false);

    // Fetch data when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchCategories();
      viewModel.fetchProducts();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen", style: AppTypography.outfitBold),
      ),
      body: Consumer<CategoryProductViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Categories list
              Container(
                height: context.responsive.hp(10), // Responsive height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.categories.length,
                  itemBuilder: (context, index) {
                    final Category category = viewModel.categories[index];
                    return Padding(
                      padding: EdgeInsets.all(
                          context.responsive.wp(2)), // Responsive padding
                      child: Chip(
                        label: Text(
                          category.catName,
                          style: AppTypography.outfitRegular.copyWith(
                            fontSize: context.responsive.sp(14),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Products grid
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(
                      context.responsive.wp(2)), // Responsive padding
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.responsive.width > 600
                        ? 3
                        : 2, // Adjust columns for tablets
                    crossAxisSpacing: context.responsive.wp(2),
                    mainAxisSpacing: context.responsive.hp(2),
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: viewModel.products.length,
                  itemBuilder: (context, index) {
                    final Products product = viewModel.products[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle product tap for details
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
                                  // Display the asset image if the network image fails to load
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
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shopsproductsapp/model/product_model.dart';
import 'package:shopsproductsapp/constants/app_typography.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products product;

  // Constructor to receive the product
  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: AppTypography.outfitBold),
       
        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.partImage,
                fit: BoxFit.cover,
                height: 250,
                width: 250,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/icons/pngtree-no-image-available-icon-flatvector-illustration-pic-design-profile-vector-png-image_40966566.jpg',
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.partsName ?? 'No Name',
              style: AppTypography.outfitBold.copyWith(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: AppTypography.outfitRegular
                  .copyWith(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              'Rating: ${product.productRating}',
              style: AppTypography.outfitLight
                  .copyWith(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),

            Text(
              'Offer: ${product.offerPrice}',
              style: AppTypography.outfitLight
                  .copyWith(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            if (product.description != null)
              Text(
                'Description: ${product.description}',
                style: AppTypography.outfitRegular.copyWith(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

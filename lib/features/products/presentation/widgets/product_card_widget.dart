import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:holo_products_app/constants/const_dimensions.dart';
import 'package:holo_products_app/constants/const_font_weights.dart';
import 'package:holo_products_app/constants/my_colors.dart';
import 'package:holo_products_app/core/presentation/widgets/base_text_widget.dart';
import 'package:holo_products_app/core/presentation/widgets/flutter_rating_bar.dart';
import 'package:holo_products_app/core/utils/AEDGenerator.dart';
import 'package:holo_products_app/data/translation.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:holo_products_app/features/products/presentation/widgets/product_details_sheet.dart';
import 'package:holo_products_app/injection_container.dart';
import 'package:holo_products_app/main.dart';

class ProductCardWidget extends StatelessWidget{
  final ProductEntity product;
  const ProductCardWidget({required this.product,super.key});

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (){
        showModalBottomSheet(
            useSafeArea: true,
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context){
              return  ProductDetailsSheet( product:  product,);
            }
        );
      },
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.white /* color-background-container */,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.50,
              color: const Color(0xFFD4D4D8) /* color-stroke-divider */,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Image & Product Details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 8,
                left: 16,
                right: 16,

              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  /// - Image
                  Container(
                    height: 150,
                    alignment: Alignment.topCenter,
                    padding:const  EdgeInsets.all(16),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  /// - Category
                  Ink(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: MyColors.grey100, /* color-background-container */
                      borderRadius: BorderRadius.circular(5),
                      // ),
                    ),
                    child: BasicTextWidget(text: product.category,
                      fontWeight: ConstFontWeights.regular,
                      fontSize: ConstDimensions.regular12,
                      color: MyColors.grey900,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      height: 1.33,
                    ),
                  ),
                  /// - Name
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        /// -  Name
                        SizedBox(
                          width: 141,
                          height: 40,
                          child:
                          BasicTextWidget(text: product.title,
                            fontWeight: ConstFontWeights.regular,
                            fontSize: ConstDimensions.regular14,
                            color: MyColors.grey900,
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                            height: 1.33,
                          ),
                        ),



                      ],
                    ),
                  ),
                  /// - Price
                  BasicTextWidget(text:
                  sl<AEDGenerator>().generate(product.price),
                    fontWeight: ConstFontWeights.bold,
                    fontSize: ConstDimensions.bold16,
                    color: MyColors.grey900,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    height: 1.33,
                  ),
                  /// - Rating
                  Row(
                    children: [
                      StarRatingWidget(rating: product.rating.rate,),
                      const SizedBox(width: 5,),
                      BasicTextWidget(text:'${product.rating.rate}',
                        fontWeight: ConstFontWeights.bold,
                        fontSize: ConstDimensions.bold14,
                        color: MyColors.grey900,
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        height: 1.33,
                      ),
                    ],
                  ),



                ],
              ),
            ),
            /// - Learn More Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: MyColors.grey900,
                      foregroundColor: MyColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8),),

                      ),
                    ),
                    onPressed: (){
                      showModalBottomSheet(
                          useSafeArea: true,
                          enableDrag: true,
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context){
                            return  ProductDetailsSheet( product:  product,);
                          }
                      );

                    },
                    child: BasicTextWidget(text: translation(context).learnMore,
                      fontWeight: ConstFontWeights.bold,
                      fontSize: ConstDimensions.regular14,
                      color: MyColors.white,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      height: 1.33,
                    ),
                  ),

            ),

          ],
        ),
      ),
    );
  }

}
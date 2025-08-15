import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_products_app/constants/const_dimensions.dart';
import 'package:holo_products_app/constants/const_font_weights.dart';
import 'package:holo_products_app/constants/my_colors.dart';
import 'package:holo_products_app/core/presentation/widgets/base_text_widget.dart';
import 'package:holo_products_app/core/presentation/widgets/flutter_rating_bar.dart';
import 'package:holo_products_app/data/translation.dart';
import 'package:holo_products_app/features/local_cart/domain/entity/cart_item_entity.dart';
import 'package:holo_products_app/features/local_cart/presentation/bloc/cart_bloc.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/presntation/bloc/theme_bloc.dart';


class ProductDetailsSheet extends StatelessWidget{
  final ProductEntity product;
  const ProductDetailsSheet({required this.product,super.key});

  @override
  Widget build(BuildContext context) {
    return  StatefulBuilder(
        builder: (context, setState1,) {
          return  BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Container(
                        decoration:  BoxDecoration(
                            color: state.themeEntity?.themeType==ThemeType.dark?Colors.grey.shade800:MyColors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                        ),
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              elevation: 5,
                              // backgroundColor: Colors.white,
                              // surfaceTintColor: MyColors.white,
                              // shadowColor: Colors.transparent,
                              // shadowColor: MyColors.grey100.withOpacity(0.5),
                              automaticallyImplyLeading: false,
                              centerTitle: false,
                              title:
                               BasicTextWidget(text: translation(context).productDetails, fontWeight: ConstFontWeights.semiBold, fontSize: ConstDimensions.semiBold16, ),
                              actions: [
                                IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close)),
                              ],
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(0),
                                  top: Radius.circular(10), // Adjust this value for the curve size
                                ),
                              ),
                            ),
                            body:buildBody(context,state)
                        )
                    );
          },
        );
        },
      );
  }

  Widget buildBody(BuildContext context,ThemeState state){
      return Ink(
        // color: MyColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  /// - Image
                  Container(
                    height: 250,
                    alignment: Alignment.topCenter,
                    padding:const  EdgeInsets.all(16),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  /// -  Name
                  BasicTextWidget(text: product.title,
                      fontWeight: ConstFontWeights.bold,
                      fontSize: ConstDimensions.bold14,

                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      height: 1.33,
                    ),

                  const SizedBox(height: 10,),

                  /// -  Description
                  Ink(
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      color: state.themeEntity?.themeType==ThemeType.dark?MyColors.grey400:MyColors.grey100 /* color-background-container */,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          color: const Color(0xFFD4D4D8) /* color-stroke-divider */,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        BasicTextWidget(text: translation(context).description,
                          fontWeight: ConstFontWeights.bold,
                          fontSize: ConstDimensions.bold14,
                          color: MyColors.grey900,
                          // maxLines: 2,
                          // textOverflow: TextOverflow.ellipsis,
                          height: 1.33,
                        ),
                        BasicTextWidget(text: product.description,
                          fontWeight: ConstFontWeights.regular,
                          fontSize: ConstDimensions.regular14,
                          color: MyColors.grey900,
                          // maxLines: 2,
                          // textOverflow: TextOverflow.ellipsis,
                          height: 1.33,
                        ),

                        const SizedBox(height: 10,),
                        /// - Category
                        Row(
                          children: [
                            Ink(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: MyColors.white, /* color-background-container */
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
                            const SizedBox(width: 5,),
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
                      ],
                    ),
                  ),


                  /// - Done Button
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.grey900,
                          foregroundColor: MyColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8),),

                          ),
                        ),
                        onPressed: (){
                          final item = CartItemEntity(
                            id: product.id,
                            title: product.title,
                            price: product.price,
                            image: product.image,
                            quantity: 1,
                          );

                          context.read<CartBloc>().add(AddItemToCart(item));
                          // context.read<CartBloc>().add(LoadCart());

                          Navigator.pop(context);
                        },
                        child: BasicTextWidget(text: translation(context).addToCart,
                          fontWeight: ConstFontWeights.bold,
                          fontSize: ConstDimensions.regular14,
                          color: MyColors.white,
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          height: 1.33,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      );
  }
}
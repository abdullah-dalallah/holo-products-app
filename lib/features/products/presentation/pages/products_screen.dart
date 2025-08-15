import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_products_app/constants/const_dimensions.dart';
import 'package:holo_products_app/constants/const_font_weights.dart';
import 'package:holo_products_app/constants/my_colors.dart';
import 'package:holo_products_app/core/presentation/widgets/base_text_widget.dart';
import 'package:holo_products_app/core/presentation/widgets/rotating_loader.dart';
import 'package:holo_products_app/core/presentation/widgets/settings_sheet.dart';
import 'package:holo_products_app/features/local_cart/presentation/bloc/cart_bloc.dart';
import 'package:holo_products_app/features/local_cart/presentation/widgets/cart_sheet.dart';
import 'package:holo_products_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:holo_products_app/features/products/presentation/widgets/product_grid_view_widget.dart';
import 'package:badges/badges.dart' as badges;

class ProductsScreen extends StatelessWidget {
  final String appName;

  const ProductsScreen({required this.appName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.grey900,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasicTextWidget(
                text: appName,
                fontWeight: ConstFontWeights.regular,
                fontSize: ConstDimensions.regular16,
                color: MyColors.white),
            Container(
              padding: EdgeInsets.only(left: 5,right: 5),
              color: MyColors.white,
              child: BasicTextWidget(
                  text: 'Products App',
                  fontWeight: ConstFontWeights.regular,
                  fontSize: ConstDimensions.regular14,
                  color: MyColors.neutral800),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(
                useSafeArea: false,
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context){
                  return  SettingsSheet();
                }
            );
          }, icon: ImageIcon(AssetImage("assets/images/icons/Hamburger Menu.png"),color: MyColors.white,)),
          IconButton(onPressed: (){
            showModalBottomSheet(
                useSafeArea: false,
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context){
                  return  CartSheet();
                }
            );
          }, icon: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      int cartCount = 0;
                      if(state is CartLoaded){
                        for (var item in state.items) {
                          cartCount = item.quantity + cartCount;
                        }
                        return badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                                borderRadius: BorderRadius.circular(10),
                                shape: badges.BadgeShape.square,
                                padding: EdgeInsets.only(left: 5,right: 5),
                                badgeColor: MyColors.yellow400
                            ),
                            showBadge: cartCount == 0 ? false : true,
                            badgeContent:BasicTextWidget(
                                text: cartCount.toString(),
                                fontWeight:  ConstFontWeights.regular,
                                fontSize: ConstDimensions.regular12,
                                color: MyColors.grey900
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: ImageIcon(AssetImage("assets/images/icons/Cart Large Minimalistic.png"),color: MyColors.white,),
                            ));
                      }else{
                        return SizedBox();
                      }



                      return ImageIcon(AssetImage("assets/images/icons/Cart Large Minimalistic.png"),color: MyColors.white,);
                    },
))



        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if(state is ProductsLoaded){
            return ProductsGridViewWidget(products: state.products,);
          }
          else if(state is ProductsError){
            return Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty.png'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: MyColors.grey900,
                      foregroundColor: MyColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8),),

                      ),
                    ),
                    onPressed: (){
                      BlocProvider.of<ProductsBloc>(context).add(GetProducts());
                    },
                    child: BasicTextWidget(text: 'Refresh',
                      fontWeight: ConstFontWeights.bold,
                      fontSize: ConstDimensions.regular14,
                      color: MyColors.white,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            );
          }
          return  Center(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 22,
                width: 22,
                child: RotatingLoader(color: MyColors.grey900,),
              ),
            ),
          );
        },
      ),
    );
  }
  SliverGridDelegateWithFixedCrossAxisCount girdViewDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 250);
  }

}
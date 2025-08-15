import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_products_app/constants/const_dimensions.dart';
import 'package:holo_products_app/constants/const_font_weights.dart';
import 'package:holo_products_app/constants/my_colors.dart';
import 'package:holo_products_app/core/presentation/widgets/base_text_widget.dart';
import 'package:holo_products_app/core/utils/AEDGenerator.dart';
import 'package:holo_products_app/data/translation.dart';
import 'package:holo_products_app/features/local_cart/presentation/bloc/cart_bloc.dart';
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/presntation/bloc/theme_bloc.dart';
import '../../../../injection_container.dart';

class CartSheet extends StatefulWidget{
  const CartSheet({super.key});

  @override
  State<CartSheet> createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {



  @override
  Widget build(BuildContext context) {
    return  StatefulBuilder(
      builder: (context, setState1,) {
        return  BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return Container(
                decoration:  BoxDecoration(
                    color: themeState.themeEntity?.themeType==ThemeType.dark?Colors.grey.shade800:MyColors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                child: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  double total = context.read<CartBloc>().getTotalPrice();

                  return Scaffold(
                                  backgroundColor: Colors.transparent,
                                  appBar: AppBar(
                                    elevation: 5,
                                    automaticallyImplyLeading: false,
                                    centerTitle: false,
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BasicTextWidget(text: translation(context).cart, fontWeight: ConstFontWeights.semiBold, fontSize: ConstDimensions.semiBold16,),
                                        BasicTextWidget(text:"${translation(context).totalPrice}: ${sl<AEDGenerator>().generate(total)}", fontWeight: ConstFontWeights.regular, fontSize: ConstDimensions.regular14,),

                                      ],
                                    ),
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
                                  body:SafeArea(child: buildCartBody(context, themeState))
                              );
                },
              )
            );
          },
        );

      },
    );
  }



  Widget buildCartBody(BuildContext context, ThemeState themeState) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartError) {
          return Center(child: Text(state.message));
        } else if (state is CartLoaded) {

          final cartItems = state.items;

          if (cartItems.isEmpty) {
            // Show empty cart widget
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  BasicTextWidget(
                    text: translation(context).cartEmpty, // "Your cart is empty"
                    fontWeight: ConstFontWeights.bold,
                    fontSize: ConstDimensions.regular16,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    height: 1.33,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          final totalPrice = cartItems.fold<double>(
              0, (sum, item) => sum + item.price * item.quantity);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.all(16),
                              child: CachedNetworkImage(
                                imageUrl: item.image,
                                fit: BoxFit.fitWidth,
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BasicTextWidget(
                                    text: item.title,
                                    fontWeight: ConstFontWeights.regular,
                                    fontSize: ConstDimensions.regular14,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                    height: 1.33,
                                  ),
                                  const SizedBox(height: 5),
                                  BasicTextWidget(
                                    text: sl<AEDGenerator>()
                                        .generate(item.price),
                                    fontWeight: ConstFontWeights.bold,
                                    fontSize: ConstDimensions.bold16,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                    height: 1.33,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final newQuantity = item.quantity - 1;
                                          if (newQuantity > 0) {
                                            context
                                                .read<CartBloc>()
                                                .add(UpdateCartItemQuantity(
                                                item.id, newQuantity));
                                          }
                                        },
                                        icon: const Icon(Icons.remove_circle),
                                      ),
                                      Text("${item.quantity}"),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<CartBloc>()
                                              .add(UpdateCartItemQuantity(
                                              item.id, item.quantity + 1));
                                        },
                                        icon: const Icon(Icons.add_circle),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<CartBloc>()
                                    .add(RemoveItemFromCart(item.id));
                              },
                              icon: const ImageIcon(
                                AssetImage(
                                    'assets/images/icons/Trash Bin Minimalistic.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BasicTextWidget(
                          text: translation(context).totalPrice,
                          fontWeight: ConstFontWeights.bold,
                          fontSize: ConstDimensions.bold18,
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          height: 1.33,
                        ),
                        BasicTextWidget(
                          text: sl<AEDGenerator>()
                              .generate(double.parse(totalPrice.toStringAsFixed(2))),
                          fontWeight: ConstFontWeights.bold,
                          fontSize: ConstDimensions.bold16,
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          height: 1.33,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.grey900,
                          foregroundColor: MyColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: BasicTextWidget(
                          text: translation(context).done,
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
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }



}
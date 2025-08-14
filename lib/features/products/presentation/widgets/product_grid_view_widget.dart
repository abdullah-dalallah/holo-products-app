import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:holo_products_app/constants/my_colors.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:holo_products_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:holo_products_app/features/products/presentation/widgets/product_card_widget.dart';

class ProductsGridViewWidget extends StatelessWidget{
  final List<ProductEntity> products;
  const ProductsGridViewWidget({required this.products,super.key});

  @override
  Widget build(BuildContext context) {
   return RefreshIndicator(
     backgroundColor: MyColors.white,
     color: MyColors.grey900,
     onRefresh: ()async{
       BlocProvider.of<ProductsBloc>(context).add(GetProducts());
     },
     child: SingleChildScrollView(
       child: Column(
         children: [
           AlignedGridView.count(
             crossAxisCount: 2,
             mainAxisSpacing: 10,
             crossAxisSpacing: 15,
             itemBuilder: (context, index) => ProductCardWidget(product: products[index],),
             itemCount: products.length ,
             padding: const EdgeInsets.all(10),
             physics: const NeverScrollableScrollPhysics(),
             shrinkWrap: true,
           ),
         ],
       ),
     ),
   );
  }

}
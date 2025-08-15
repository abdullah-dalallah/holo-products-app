import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable{
  final int id;
  final String title;
  final double price;
  final String image;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    price,
    image,
    quantity,
  ];
}
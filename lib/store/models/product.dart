import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String category;
  final Rating rating;
  const Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    required this.rating,
  });

  factory Product.fromJSON(Map<String,dynamic> json){
    final num price = json['price'];
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: price.toDouble(),
      category: json['category'],
      description: json['description'],
      rating: Rating.fromJSON(json['rating'])
    );
  }
  @override
  List<Object?> get props => [id,title,image];

}

class Rating{
  final double rating;
  final int count;
  Rating({required this.count,required this.rating});
  factory Rating.fromJSON(Map<String,dynamic> json){
    final num rating = json['rate'];
    return Rating(
      count: json['count'],
      rating: rating.toDouble(),
    );
  }
}
import 'dart:collection';

class Food {
  String name;
  String image;
  double price;
  int quantity;
  double cal;
  double time;
  double rate;
  int reviews;
  bool isLiked;

  Food({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.cal,
    required this.time,
    required this.rate,
    required this.reviews,
    required this.isLiked,
  });
}

final List<Food> foods = [
  Food(
    name: "Spicy Ramen Noodles",
    image: "assets/images/ramen-noodles.jpg",
    price: 20,
    quantity: 1,
    cal: 120,
    time: 15,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
  Food(
    name: "Beef Steak",
    image: "assets/images/beaf-steak.jpg",
    price: 30,quantity: 1,
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: true,
  ),
  Food(
    name: "Butter Chicken",
    image: "assets/images/butter-chicken.jpg",
    price: 35,quantity: 1,
    cal: 130,
    time: 18,
    rate: 4.2,
    reviews: 10,
    isLiked: false,
  ),
  Food(
    name: "French Toast",
    image: "assets/images/french-toast.jpg",
    price: 39,quantity: 1,
    cal: 110,
    time: 16,
    rate: 4.6,
    reviews: 90,
    isLiked: true,
  ),
  Food(
    name: "Dumplings",
    image: "assets/images/dumplings.jpg",
    price: 34,quantity: 1,
    cal: 150,
    time: 30,
    rate: 4.0,
    reviews: 76,
    isLiked: false,
  ),
  Food(
    name: "Mexican Pizza",
    image: "assets/images/mexican-pizza.jpg",
    price: 50,quantity: 1,
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
];

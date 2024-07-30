import 'package:my_grocery/src/models/item_model.dart';
import 'package:my_grocery/src/models/order_model.dart';
import 'package:my_grocery/src/models/user_model.dart';

ItemModel apple = ItemModel(
    itemName: 'Maçã',
    imageUrl: 'assets/fruits/apple.png',
    unit: 'KG',
    price: 1.50,
    description: 'A melhor maçã da região');

ItemModel grape = ItemModel(
    itemName: 'Uva',
    imageUrl: 'assets/fruits/grape.png',
    unit: 'KG',
    price: 99.90,
    description: 'Uvas da região do Himalaia.');

ItemModel guava = ItemModel(
    itemName: 'Goiaba',
    imageUrl: 'assets/fruits/guava.png',
    unit: 'KG',
    price: 155.50,
    description: 'Goiaba plantadas no monte fuji.');

ItemModel kiwi = ItemModel(
    itemName: 'kiwi',
    imageUrl: 'assets/fruits/kiwi.png',
    unit: 'KG',
    price: 264.30,
    description: 'Kiwis plantados no monte kilimanjaro.');

ItemModel mango = ItemModel(
    itemName: 'Manga',
    imageUrl: 'assets/fruits/mango.png',
    unit: 'KG',
    price: 359.80,
    description: 'Mangas platantas no sul do Saara');

ItemModel papaya = ItemModel(
    itemName: 'Mamão Papaya',
    imageUrl: 'assets/fruits/papaya.png',
    unit: 'KG',
    price: 690.30,
    description: 'Mamões Papayas plantados nas maldivas');

List<ItemModel> itens = [apple, grape, guava, kiwi, mango, papaya];

List<String> categories = [
  'Frutas',
  'Verduras',
  'Legumes',
  'Carnes',
  'Cereais',
  'Laticinios',
  'Guloseimas',
];

// List<CartItemModel> cartItems = [
//   CartItemModel(item: apple, quantity: 3),
//   CartItemModel(item: mango, quantity: 1),
//   CartItemModel(item: guava, quantity: 2),
// ];

UserModel user = UserModel(
    name: 'Kaue',
    email: 'Kaue@email.com',
    cellphone: '(55) 11 9 4002-8922',
    cpf: '123.456.678.90',
    pass: '12345');

List<OrderModel> orders = [
  OrderModel(
      id: 'asd6a5dsgb4ady8ydvg',
      createdDateTime: DateTime.parse('2023-01-23 19:16'),
      overDudeDateTime: DateTime.parse('2023-01-23 19:37'),
      qrCodeImage: "",
      items: [
        // CartItemModel(item: mango, quantity: 4),
        // CartItemModel(item: grape, quantity: 2),
      ],
      status: 'delivered',
      copyAndPaste: 'scqfbvofboqw',
      total: 1639),
  OrderModel(
      id: 'dneuh0eh84deidfn',
      createdDateTime: DateTime.parse('2023-01-23 19:16'),
      overDudeDateTime: DateTime.parse('2023-01-23 19:37'),
      qrCodeImage: "",
      items: [
        // CartItemModel(item: mango, quantity: 4),
        // CartItemModel(item: grape, quantity: 2),
        // CartItemModel(item: papaya, quantity: 1)
      ],
      status: 'delivered',
      copyAndPaste: 'scqfbvofboqw',
      total: 2329.30)
];

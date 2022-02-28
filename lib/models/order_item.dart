class OrderItem {
  String id;
  bool isActive;
  String price;
  String company;
  String pictureUrl;
  String buyer;
  List<dynamic> tags;
  String status;
  String registered;

  OrderItem({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    this.pictureUrl = '',
    this.buyer = '',
    this.tags = const [],
    required this.status,
    required this.registered,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        id: json['id'] ?? '',
        isActive: json['isActive'] ?? false,
        price: json['price'] ?? '',
        company: json['company'] ?? '',
        pictureUrl: json['picture'] ?? '',
        buyer: json['buyer'] ?? '',
        tags: json['tags'] ?? [],
        status: json['status'] ?? '',
        registered: json['registered'] ?? '');
  }
}

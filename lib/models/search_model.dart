
class SearchModel {
  late final bool status;
  late final Data data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  late final int currentPage;
  late final List<Product> data;
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final String path;
  late final int perPage;

  late final int to;
  late final int total;

  Data.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    data = List.from(json['data']).map((e)=>Product.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class Product {
  late final int id;
  late final num price;
  late final num oldPrice;
  late final num discount;
  late final String image;
  late final String name;
  late final String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
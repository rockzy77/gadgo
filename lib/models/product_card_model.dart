class ProductCardModel{
  final String? productTitle;
  final int? productPrice;
  final int? productQuantity;
  final String? productImage;
  final List? productTags;
  final String? productTheme;

  ProductCardModel({this.productImage, this.productPrice, this.productQuantity, this.productTitle, this.productTags, this.productTheme});

  factory ProductCardModel.fromJson(Map<String, dynamic> data){
    ProductCardModel model = ProductCardModel(
      productImage: data['productImage'],
      productPrice: data['productPrice'],
      productTitle: data['productTitle'],
      productTags: data['productTags'],
      productTheme: data['productTheme'],
      productQuantity: data['productQuantity']
    );
    return model;
  }

  Map<String, dynamic> toMap(ProductCardModel model){
    Map<String, dynamic> data = {};
    data['productTitle'] = model.productTitle;
    data['productImage'] = model.productImage;
    data['productPrice'] = model.productPrice;
    data['productTags'] = model.productTags;
    data['productTheme'] = model.productTheme;
    data['productQuantity'] = model.productQuantity;
    return data;
  }
}
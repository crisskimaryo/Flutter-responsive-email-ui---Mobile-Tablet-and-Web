class CategoryModel {
  final dynamic key;
  final dynamic id;
  final dynamic createdDate;
  final dynamic totaltags;
  final dynamic expertsInv;
  final String name;
  final bool status;

  CategoryModel({
    this.key,
    this.id,
    this.totaltags,
    this.expertsInv,
    this.name,
    this.createdDate,
    this.status,
  });

  factory CategoryModel.fromDoc(dynamic doc) {
    return CategoryModel(
      key: doc['_key'],
      id: doc['_key'],
      status: doc['status'],
      name: doc['name'],
      createdDate: doc['createdDate'],
      totaltags: doc['totaltags'],
      expertsInv: doc['expertsInv'],
    );
  }
}

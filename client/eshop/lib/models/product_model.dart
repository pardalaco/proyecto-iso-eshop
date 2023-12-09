/// Clase de prodctos
// ignore_for_file: unnecessary_getters_setters

class Productos {
  //Atributos de la clase solicitada (modificadas con late xq deben ser inicializadas)
  late String _name;
  late int _productId;
  late double _price;
  late ProductosType _type;
  late String _iconPath;

  static final List<Productos> initial = [
    Productos(
        name: "Detergente Ariel",
        productId: 1,
        price: 13,
        type: ProductosType.labanderia,
        iconPath: 'assets/img/detergente.jpg'),
    Productos(
        name: "Agua",
        productId: 1,
        price: 1,
        type: ProductosType.bebida,
        iconPath: "assets/img/agua.png"),
  ];

  /// Constructor con parámetros no nulables (required)
  Productos(
      {required String name,
      required int productId,
      required double price,
      required ProductosType type,
      required String iconPath}) {
    _name = name;
    _productId = productId;
    _price = price;
    _type = type;
    _iconPath = iconPath;
  }

  ProductosType get type => _type;
  set type(ProductosType value) {
    _type = value;
  }

  int get productId => _productId;
  set productId(int value) {
    _productId = value;
  }

  double get price => _price;
  set price(double value) {
    _price = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String get iconPath => _iconPath;
  set iconPath(String value) {
    _iconPath = value;
  }
}

/// Crear un enum ProductosType con los valores plant, fire y water, fuera de la clase, en el mismo fichero
enum ProductosType { labanderia, bebida }

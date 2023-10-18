class Produto{
  late int _id;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  late String _nome;
  late String _marca;
  late double _preco;
  late String _validade;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get marca => _marca;

  set marca(String value) {
    _marca = value;
  }

  double get preco => _preco;

  set preco(double value) {
    _preco = value;
  }

  String get   validade => _validade;

  set validade(String value) {
    _validade = value;
  }
}
import 'package:banco_dados/Produto.dart';
import 'package:banco_dados/banco.dart';
import 'package:flutter/material.dart';

Banco banco = Banco();

class Alterar extends StatefulWidget {
  const Alterar({Key? key}) : super(key: key);

  @override
  State<Alterar> createState() => _AlterarState();
}

class _AlterarState extends State<Alterar> {
  List<Produto> listaProdutos = [];
  String dropdownValue = 'Selecione';
  final campoNome = TextEditingController();
  final campoMarca = TextEditingController();
  final campoPreco = TextEditingController();
  final campoValidade = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAlterarDados();
  }

  void getAlterarDados() async {
    var resultSet = await banco.getProdutos();
    List<Produto> produtos = [];

    for (var row in resultSet) {
      var produto = Produto();
      produto.id = row['id'];
      produto.nome = row['nome'];
      produto.marca = row['marca'];
      produto.preco = row['preco'];
      produto.validade = row['validade'];
      produtos.add(produto);
    }

    setState(() {
      listaProdutos = produtos;
      if (produtos.isNotEmpty) {
        dropdownValue = produtos[0].id.toString(); // Usar o ID como valor no Dropdown
        _preencherCamposComProdutoSelecionado(produtos[0]);
      }
    });
  }

  void _preencherCamposComProdutoSelecionado(Produto produto) {
    campoNome.text = produto.nome;
    campoMarca.text = produto.marca;
    campoPreco.text = produto.preco.toStringAsFixed(2);
    campoValidade.text = produto.validade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Selecione o Produto",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 40),
            DropdownButton(
              value: dropdownValue,
              items: listaProdutos.map((produto) {
                return DropdownMenuItem(
                  value: produto.id.toString(), // Usar o ID como valor no Dropdown
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      produto.nome,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value.toString();
                  final produtoSelecionado = listaProdutos.firstWhere((p) => p.id.toString() == value);
                  _preencherCamposComProdutoSelecionado(produtoSelecionado);
                });
              },
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nome do Produto",
                      hintText: "Informe o Nome",
                    ),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    controller: campoNome,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Marca do Produto",
                      hintText: "Informe a Marca",
                    ),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    controller: campoMarca,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Preço do Produto",
                      hintText: "Informe o Preço",
                    ),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    controller: campoPreco,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Validade do Produto",
                      hintText: "Informe a Validade",
                    ),
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    controller: campoValidade,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final produtoSelecionado = listaProdutos.firstWhere((p) => p.id.toString() == dropdownValue);
                      produtoSelecionado.nome = campoNome.text;
                      produtoSelecionado.marca = campoMarca.text;
                      produtoSelecionado.preco = double.parse(campoPreco.text);
                      produtoSelecionado.validade = campoValidade.text;
                      await banco.alterarProduto(produtoSelecionado);

                      setState(() {
                        campoPreco.text = "";
                        campoValidade.text = "";
                        campoMarca.text = "";
                        campoNome.text = "";

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Item alterado com Sucesso!!"),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.green,),
                        );
                      });
                    },
                    child: Text("Salvar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

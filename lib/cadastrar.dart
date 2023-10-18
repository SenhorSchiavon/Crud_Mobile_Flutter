import 'package:banco_dados/Produto.dart';
import 'package:banco_dados/banco.dart';
import 'package:flutter/material.dart';
class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key});

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  Banco banco = Banco();
  TextEditingController campoNome = TextEditingController();
  TextEditingController campoMarca = TextEditingController();
  TextEditingController campoPreco = TextEditingController();
  TextEditingController campoValidade = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Nome do Produto",
                hintText: "Informe o Nome"
              ),
              style: TextStyle(
                fontSize: 15
              ),
              controller: campoNome,
            ),

            Container(
              margin: EdgeInsets.only(top: 10), // Ajuste a margem conforme necessário
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Marca do Produto",
                  hintText: "Informe a Marca",
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
                controller: campoMarca,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10), // Ajuste a margem conforme necessário
              child: TextField(
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
            ),
            Container(
              margin: EdgeInsets.only(top: 10), // Ajuste a margem conforme necessário
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Validade do Produto",
                  hintText: "Informe a Validade",
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
                controller: campoValidade,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Produto p = Produto();
                  p.nome = campoNome.text;
                  p.marca = campoMarca.text;
                  p.preco = double.parse(campoPreco.text);
                  p.validade = campoValidade.text;
                  banco.salvar(p);

                  setState(() {
                    campoPreco.text = "";
                    campoValidade.text = "";
                    campoMarca.text = "";
                    campoNome.text="";

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Item incluido com Sucesso!!"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,),
                    );
                  });
                },
                child: Text("Salvar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
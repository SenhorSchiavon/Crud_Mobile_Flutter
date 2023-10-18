import 'package:banco_dados/Produto.dart';
import 'package:banco_dados/alterar.dart';
import 'package:banco_dados/cadastrar.dart';
import 'package:banco_dados/excluir.dart';
import 'package:banco_dados/listar.dart';
import 'package:flutter/material.dart';
import 'banco.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int indiceSelecionado = 0;

  List Telas = [
    Listar(),
    Cadastrar(),
    Alterar(),
    Deletar(),
  ];
  @override
  Widget build(BuildContext context) {
    Banco banco = Banco();
    Produto p = Produto();
    p.id=1;
    p.nome = "Milho";
    p.marca = "IDR";
    p.preco = 200;
    p.validade = "10/02/2097";
    //banco.salvar(p);
    // banco.buscarBanco();
    // banco.getProdutos();
    //banco.alterarProduto(p);
    //banco.apagarProduto;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("imagens/logo.jpg",width: 100,height:60,),
      ),
      body: Telas[indiceSelecionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceSelecionado,
        type: BottomNavigationBarType.shifting,

        onTap: (indice) {
          setState(() {
            indiceSelecionado = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "Listar",
              backgroundColor: Colors.green),

          BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: "Cadastrar",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: "Alterar",
              backgroundColor: Colors.purple),
          BottomNavigationBarItem(
              icon: Icon(Icons.delete),
              label: "Excluir",
              backgroundColor: Colors.red),
        ],
      ),
    );
  }
}

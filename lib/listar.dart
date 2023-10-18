import 'package:banco_dados/Produto.dart';
import 'package:banco_dados/banco.dart';
import 'package:flutter/material.dart';
class Listar extends StatefulWidget {
  const Listar({super.key});

  @override
  State<Listar> createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  @override
  void initState(){
    super.initState();
    getListaProdutos();
  }

  Banco banco = Banco();
  List<Produto> listaProdutos = [];
  getListaProdutos() async{
    List lista = await banco.getProdutos();
    //zerar lista
    lista.forEach((element){
      Produto p = Produto();
      p.id = element["id"];
      p.nome = element["nome"];
      p.marca = element["marca"];
      p.preco = element["preco"];
      p.validade = element["validade"];
      setState(() {
        listaProdutos.add(p);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(15),
      child: ListView.builder(
          itemCount: listaProdutos.length,
          itemBuilder: (context,indice){
            return ListTile(
              title: Text(listaProdutos[indice].nome),
              subtitle: Text("Preço:"+listaProdutos[indice].preco.toString()+" - Marca: "+listaProdutos[indice].marca),
            );
          }),
    );
  }
}

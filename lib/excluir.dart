import 'package:banco_dados/Produto.dart';
import 'package:banco_dados/banco.dart';
import 'package:flutter/material.dart';
class Deletar extends StatefulWidget {
  const Deletar({super.key});

  @override
  State<Deletar> createState() => _DeletarState();
}

class _DeletarState extends State<Deletar> {
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
            return Dismissible(key: Key(listaProdutos[indice].id.toString()),
                child: ListTile(
              title: Text(listaProdutos[indice].nome),
              subtitle: Text("Preço:"+listaProdutos[indice].preco.toString()+" - Marca: "+listaProdutos[indice].marca),
            ),
            direction: DismissDirection.endToStart,
              background: Container(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              onDismissed: (direction){
                  banco.apagarProduto(listaProdutos[indice].id);
                  listaProdutos.removeAt(indice);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Item excluido com Sucesso!!"),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,),
                  );
              },
            );

          }),
    );
  }
}

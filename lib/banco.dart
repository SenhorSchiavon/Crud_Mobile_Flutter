import 'package:sqflite/sqflite.dart';
import 'Produto.dart';
import 'package:path/path.dart';
class Banco{
  buscarBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final localBanco = join(caminhoBanco, "banco.db");
    var bancoDados = await openDatabase(
        localBanco,
        version: 1,
        onCreate: (banco, versaoMaisRecente){
          String sql = "CREATE TABLE produtos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, marca VARCHAR, preco REAL, validade VARCHAR)";
          banco.execute(sql);
        }
    );
    return bancoDados;
  }
  salvar(Produto p) async{
    Database banco = await buscarBanco();
    Map<String, dynamic> produto ={
      "nome":p.nome,
      "marca":p.marca,
      "preco":p.preco,
      "validade":p.validade
    };
    int id = await banco.insert("produtos", produto);
  }
  getProdutos() async{
    Database banco = await buscarBanco();
    List produtos = await banco.rawQuery("SELECT * FROM produtos ORDER BY nome asc");
    return produtos;
  }
  // getProduto(int id)async{
  //   Database banco = await buscarBanco();
  //   List produtos = await banco.query(
  //     "produtos",
  //     columns: ["id","nome","marca","preco","validade"],
  //     where: "id=?",
  //     whereArgs: [id]
  //   );
  //   return produtos;
  // }
  apagarProduto(int id)async{
    Database banco = await buscarBanco();
    int linhasExcluidas = await banco.delete(
        "produtos",
        where: "id=?",
        whereArgs: [id]
    );
  }
  alterarProduto(Produto p)async{
    Database banco = await buscarBanco();
    Map<String,dynamic> dadosProduto = {
      "nome":p.nome,
      "marca":p.marca,
      "preco":p.preco,
      "validade":p.validade
    };
    int numMudancas = await banco.update("produtos",
    dadosProduto,
      where: "id=?",
      whereArgs: [p.id]
    );

  }
}

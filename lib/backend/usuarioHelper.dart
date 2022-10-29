import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'cadastroUsuario.dart';

class UsuarioHelper {
  static final UsuarioHelper _instance = UsuarioHelper._interno();

  factory UsuarioHelper() => _instance;

  UsuarioHelper._interno();

  Database? _banco;

  Future<Database> get banco async {
    if (_banco != null) {
      return _banco!;
    } else {
      _banco = await iniciarBanco();
      return _banco!;
    }
  }

String tabelaUsuario = "usuario";

Future<Database> iniciarBanco() async {
  final caminhoDoBanco = await getDatabasesPath();
  final caminho = join(caminhoDoBanco, "usuarios.db");
  const versao = 1;

  String sqlCriarBanco = 
    "CREATE TABLE $tabelaUsuario ("
    "${UsuarioPropriedades.id} INTEGER PRIMARY KEY , "
    "${UsuarioPropriedades.email} TEXT , "
    "${UsuarioPropriedades.usuario} TEXT , "
    "${UsuarioPropriedades.senha} TEXT , "
    "${UsuarioPropriedades.cpf} TEXT , "
    "${UsuarioPropriedades.endereco} TEXT , "
    "${UsuarioPropriedades.telefone} TEXT  "
    ")";

  String destruirBanco = "DROP TABLE $tabelaUsuario";

  return openDatabase(
    caminho,
    version: versao,
    onCreate: (banco, versaoNova) async {
      print("Criando banco com versão $versaoNova");
      await banco.execute(sqlCriarBanco);
    },
    onUpgrade: (banco, versaoAntiga, versaoNova) async {
      print("Atualizando banco da versão $versaoAntiga para versão $versaoNova");
      await banco.execute(destruirBanco);
      await banco.execute(sqlCriarBanco);
    }
  );
}

  Future<Usuario> salvar(Usuario usuario) async {
    Database bancoUsuario = await banco;
    usuario.id = await bancoUsuario.insert(tabelaUsuario, usuario.toMap());
    return usuario;
  }

  Future<Usuario> consultar (int id) async {
    Database bancoUsario = await banco;
    List<Map> retorno = await bancoUsario.query(tabelaUsuario, 
    columns: [
      UsuarioPropriedades.id,
      UsuarioPropriedades.email,
      UsuarioPropriedades.usuario,
      UsuarioPropriedades.senha,
      UsuarioPropriedades.cpf,
      UsuarioPropriedades.endereco,
      UsuarioPropriedades.telefone
    ],
    where: "${UsuarioPropriedades.id} = ?",
    whereArgs: [id]);
    if (retorno.isNotEmpty) {
      return Usuario.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  Future <List<Usuario>> consultarTodos() async {
    Database bancoUsuario = await banco;
    List<Map> retorno = 
      await bancoUsuario.rawQuery("SELECT * FROM $tabelaUsuario");
    List<Usuario> usuarios = [];
    for (Map usuario in retorno) {
      usuarios.add(Usuario.fromMap(usuario));
    }
    return usuarios;
  }

  Future<int> remover(int id) async {
    Database bancoUsuario = await banco;
    return await bancoUsuario.delete(tabelaUsuario, 
      where: "${UsuarioPropriedades.id} = ?", whereArgs: [id]);
  }

  Future<int> atualizar(Usuario usuario) async {
    Database bancoUsuario = await banco;
    return await bancoUsuario.update(tabelaUsuario, usuario.toMap(),
      where: "${UsuarioPropriedades.id} = ?", whereArgs: [usuario.id]);
  }

  Future<int?> quantidade() async {
    Database bancoUsuario = await banco;
    return Sqflite.firstIntValue(
      await bancoUsuario.rawQuery("SELECT COUNT (*) FROM $tabelaUsuario"));
  }

  Future<Usuario> login(String usuario, String senha) async {
    Database bancoUsuario = await banco;
    List<Map> retorno = await bancoUsuario.query(tabelaUsuario,
      where: "${UsuarioPropriedades.usuario} = ?"
      " AND "
      "${UsuarioPropriedades.senha} = ?",
      whereArgs: [usuario, senha]);
    if (retorno.isNotEmpty) {
      return Usuario.fromMap(retorno.first);
    }
      
    return Usuario();
    
  }

  Future fecharBanco() async {

  }
}
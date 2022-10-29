import 'dart:convert';
import 'dart:io';
import 'package:appaula/backend/cadastroUsuario.dart';
import 'package:path_provider/path_provider.dart';

class PersistenciaArquivoJson {
  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/usuario.json");
  }

  Future<File> gravarUsuario(Usuario usuario) async {
    List<Usuario> listaUsuarios = await lerUsuario();
    listaUsuarios.add(usuario);

    List mapUsuarios = [];
    for (Usuario usuario in listaUsuarios) {
      mapUsuarios.add(usuario.toMap());
    }

    String listaComoString = json.encode(mapUsuarios);
    final arquivo = await _getFile();
    return arquivo.writeAsString(listaComoString);
  }

  Future<List<Usuario>> lerUsuario() async {
    List<Usuario> listaUsuarios = [];

    String listaComoString = "";
    try {
      final arquivo = await _getFile();
      listaComoString = await arquivo.readAsString();
    } catch (e) {
      print("Erro na leitura do arquivo $e");
    }

  List mapUsuarios = [];
  if(listaComoString.isNotEmpty) {
     mapUsuarios = json.decode(listaComoString);
  }

    for (Map usuariosMap in mapUsuarios) {
      listaUsuarios.add(Usuario.fromMap(usuariosMap));
    }
    return listaUsuarios;
  }

    Future gravarUsuarios(List<Usuario> usuarios) async {
    List mapUsuarios = [];
    for (Usuario usuario in usuarios) {
      mapUsuarios.add(usuario.toMap());
    }

    String listaComoString = json.encode(mapUsuarios);
    final arquivo = await _getFile();

    await arquivo.writeAsString(listaComoString);
  }

    Future removerUsuario(int indice) async {
    List<Usuario> listaUsuarios = await lerUsuario();

    listaUsuarios.removeAt(indice);

    await gravarUsuarios(listaUsuarios);
  }

  Future editar(int indice, Usuario usuarioAtualizar) async {
    List<Usuario> listaUsuarios = await lerUsuario();

    listaUsuarios[indice] = usuarioAtualizar;

    await gravarUsuarios(listaUsuarios);
  }

}

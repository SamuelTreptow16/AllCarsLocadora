import 'package:appaula/frontend/alteraCadastro.dart';
import 'package:appaula/persistenciaArquivoJson/persistenciaArquivoJson.dart';
import 'package:appaula/backend/usuarioHelper.dart';
import 'package:flutter/material.dart';
import '../../backend/cadastroUsuario.dart';
import 'opcoesHome/telaOpcoesHome.dart';

class listaCadastros extends StatefulWidget {
  const listaCadastros({Key? key}) : super(key: key);

  @override
  State<listaCadastros> createState() => _listaCadastrosState();
}

class _listaCadastrosState extends State<listaCadastros> {

  PersistenciaArquivoJson paj = PersistenciaArquivoJson();
  List<Usuario> lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barraSuperior(),
      body: corpo(),
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text("Usuários Cadastrados"),
      actions: [
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (builder) => telaOpcoes()));
              },
            )
          ],
    );
  }

  corpo() {
    return Column(
      children: [listaUsuarios()],
    );
  }

  listaUsuarios() {
    return Expanded(
        child: Card(
      margin: const EdgeInsets.all(15),
      child: FutureBuilder<List<Usuario>>(
          future: carregarListaUsuarios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return montarListaUsuarios(snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }

  montarListaUsuarios(List<Usuario> usuarios) {
    return ListView.builder(
      itemCount: usuarios.length,
      itemBuilder: (context, index) {
        return itemDaLista(usuarios[index], index);
      },
    );
  }

  itemDaLista(Usuario usuario, int indice) {
    return ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          usuario.usuario,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: Wrap(children: <Widget>[
          IconButton(
            icon: const Icon(Icons.restore_from_trash, color: Colors.red),
            onPressed: () {
              setState(() {
                //paj.removerUsuario(indice);
                //remover usuario do banco
                UsuarioHelper().remover(lista[indice].id);
                print(indice);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (builder) => alteraCadastro(indice: indice, usuario: usuario,)))
            },
          ),
        ]));
  }

  Future<List<Usuario>> carregarListaUsuarios() async {
    await Future.delayed(const Duration(seconds: 2));
    lista = await UsuarioHelper().consultarTodos();
    return lista;
  }
}

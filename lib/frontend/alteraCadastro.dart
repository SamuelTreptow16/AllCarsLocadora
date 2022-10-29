import 'package:appaula/frontend/listaCadastros.dart';
import 'package:appaula/persistenciaArquivoJson/persistenciaArquivoJson.dart';
import 'package:appaula/backend/usuarioHelper.dart';
import 'package:flutter/material.dart';

import '../backend/cadastroUsuario.dart';

class alteraCadastro extends StatefulWidget {
  final Usuario usuario;
  final int indice;
  const alteraCadastro({Key? key, required this.usuario, required this.indice}) : super(key: key);

  @override
  State<alteraCadastro> createState() => _alteraCadastroState();
}

class _alteraCadastroState extends State<alteraCadastro> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  PersistenciaArquivoJson serviceUser = PersistenciaArquivoJson();

  @override
  void initState() {
    super.initState;
    _usuarioTemporario = widget.usuario;
    _usuarioController.text = _usuarioTemporario.usuario;
    _senhaController.text = _usuarioTemporario.senha;
    _enderecoController.text = _usuarioTemporario.endereco;
    _telefoneController.text = _usuarioTemporario.telefone;
  }
  Usuario _usuarioTemporario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Cadastro de Usuário"),
      ),
      body: cardFormulario(),
    );
  }

  cardFormulario() {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              campoDados(_usuarioController, "Usuário",
                  "Informe o nome de usuário", Icons.person, false),
              campoDados(_senhaController, "Senha", "Informe uma senha",
                  Icons.password_rounded, true),
              campoDados(_enderecoController, "Endereço", "Informe seu endereço", 
                  Icons.house_outlined, false),
              campoDados(_telefoneController, "Telefone", "Insira seu número de telefone",
                  Icons.phone_android_rounded, false),
              botaoAtualizar()
            ],
          )),
    );
  }

  botaoAtualizar() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 5),
      child: ElevatedButton.icon(
        icon: Icon(Icons.add),
        label: Text("Atualizar"),
        onPressed: () {

          _usuarioTemporario.usuario = _usuarioController.text;
          _usuarioTemporario.senha = _senhaController.text;
          _usuarioTemporario.endereco = _enderecoController.text;
          _usuarioTemporario.telefone = _telefoneController.text;
          UsuarioHelper().atualizar(_usuarioTemporario);

          serviceUser.editar(widget.indice, _usuarioTemporario);
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => listaCadastros()));
        },
      ),
    );
  }

  campoDados(TextEditingController controller, String label, String hint,
      IconData icone, bool isSenha) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        style: TextStyle(color: Colors.green[900]),
        controller: controller,
        obscureText: isSenha,
        decoration: InputDecoration(
          icon: Icon(
            icone,
            color: Colors.grey,
          ),
          hintText: hint,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
        ),
        validator: (String? value) {
          return (value == null || value.isEmpty) ? 'Campo obrigatório' : null;
        },
      ),
    );
  }
}

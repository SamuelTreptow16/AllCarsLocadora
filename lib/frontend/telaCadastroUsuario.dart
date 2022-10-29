import 'package:appaula/backend/cadastroUsuario.dart';
//import 'package:appaula/persistenciaArquivoJson/persistenciaArquivoJson.dart';
import 'package:appaula/backend/usuarioHelper.dart';
import 'package:appaula/frontend/telaLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'opcoesHome/telaOpcoesHome.dart';

class telaCadastroCliente extends StatefulWidget {
  const telaCadastroCliente({Key? key}) : super(key: key);

  @override
  State<telaCadastroCliente> createState() => _telaCadastroClienteState();
}

class _telaCadastroClienteState extends State<telaCadastroCliente> {
  GlobalKey<FormState> _chaveForm = new GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usuarioController = new TextEditingController();
  TextEditingController _senhaController = new TextEditingController();
  TextEditingController _cpfController = new TextEditingController();
  TextEditingController _enderecoController = new TextEditingController();
  TextEditingController _telefoneController = new TextEditingController();

  @override
  InsereEmail(TextEditingController controller, String label) {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      style:
          const TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
      decoration: InputDecoration(
          hintText: 'Ex: email@email.com',
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
          icon: const Icon(Icons.alternate_email_rounded)),
      validator: (texto) {
        if (texto!.isEmpty) {
          return "Campo Obrigatório";
        }
      },
    );
  }

  InsereUsuario(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      style:
          const TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
      decoration: InputDecoration(
          hintText: 'Fulano de Tal',
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
          icon: const Icon(Icons.person_pin_rounded)),
      validator: (texto) {
        if (texto!.isEmpty) {
          return "Campo Obrigatório";
        }
      },
    );
  }

  InsereSenha(TextEditingController controller, String label) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      style:
          const TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
          icon: const Icon(Icons.lock_rounded)),
      validator: (texto) {
        if (texto!.isEmpty) {
          return "Campo Obrigatório";
        }
      },
    );
  }

  InsereCPF(TextEditingController controller, String label) {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(11),
      ],
      keyboardType: TextInputType.number,
      controller: controller,
      style:
          const TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
      decoration: InputDecoration(
          hintText: '999.999.999-99',
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
          icon: const Icon(Icons.person_outline_rounded)),
      validator: (texto) {
        if (texto!.isEmpty) {
          return "Campo Obrigatório";
        }
      },
    );
  }

  InsereEndereco(TextEditingController controller, String label) {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      controller: controller,
      style:
          const TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
      decoration: InputDecoration(
          hintText: 'Rua A, 123, Bairro Centro, Camaquã/RS',
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
          icon: const Icon(Icons.house_rounded)),
      validator: (texto) {
        if (texto!.isEmpty) {
          return "Campo Obrigatório";
        }
      },
    );
  }

  InsereTelefone(TextEditingController controller, String label) {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(11),
      ],
      keyboardType: TextInputType.phone,
      controller: controller,
      style:
          const TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
          icon: const Icon(Icons.phone)),
      validator: (texto) {
        if (texto!.isEmpty) {
          print("Campo Obrigatório");
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realize seu Cadastro"),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _chaveForm,
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InsereEmail(_emailController, "Insira seu E-mail"),
              const Divider(),
              InsereUsuario(_usuarioController, "Insira seu Nome de Usuário"),
              const Divider(),
              InsereSenha(_senhaController, "Insira sua Senha"),
              const Divider(),
              InsereCPF(_cpfController, "Insira seu CPF"),
              const Divider(),
              InsereEndereco(_enderecoController, "Insira seu Endereço"),
              const Divider(),
              InsereTelefone(_telefoneController, "Insira seu Telefone"),
              const Divider(),
              ButtonTheme(
                  child: ElevatedButton.icon(
                icon: const Icon(Icons.input_rounded),
                label: const Text(
                  "Concluir Cadastro",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_chaveForm.currentState!.validate()) {
                    print("Campo Obrigatório");
                    Usuario usuario = Usuario();
                    usuario.email = _emailController.text;
                    usuario.usuario = _usuarioController.text;
                    usuario.senha = _senhaController.text;
                    usuario.cpf = _cpfController.text;
                    usuario.endereco = _enderecoController.text;
                    usuario.telefone = _telefoneController.text;
                    //PersistenciaArquivoJson().gravarUsuario(usuario);
                    //salva um usuário no banco
                    UsuarioHelper().salvar(usuario);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const telaLogin()));
                  }
                },
              ))
            ],
          )
        ]),
      )),
    );
  }
}

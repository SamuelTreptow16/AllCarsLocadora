import 'package:appaula/backend/cadastroUsuario.dart';
import 'package:appaula/backend/sistema.dart';
import 'package:appaula/frontend/telaCadastroUsuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backend/usuarioHelper.dart';
import 'opcoesHome/telaOpcoesHome.dart';

class telaLogin extends StatefulWidget {
  const telaLogin({Key? key}) : super(key: key);

  @override
  State<telaLogin> createState() => _telaLoginState();
}

class _telaLoginState extends State<telaLogin> {
  GlobalKey<FormState> _chaveForm = new GlobalKey();
  TextEditingController _usuarioController = new TextEditingController();
  TextEditingController _senhaController = new TextEditingController();
  bool mostraMsg = false;

  final Future<SharedPreferences> _preferencia =
      SharedPreferences.getInstance();
  Future<void> _registraUsuario() async {
    final SharedPreferences preferencia = await _preferencia;
    preferencia.setString('usuario', _usuarioController.text);
  }

  @override
  InsereUsuario(TextEditingController controller, String label) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      style: TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 22),
      decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 22),
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
      autofocus: true,
      obscureText: true,
      controller: controller,
      style: TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
      decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
          icon: const Icon(Icons.lock_rounded)),
      validator: (texto) {
        if (texto!.isEmpty) {
          return "Campo Obrigatório";
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _chaveForm,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InsereUsuario(_usuarioController, "Usuário"),
                  const Divider(),
                  InsereSenha(_senhaController, "Senha"),
                  const Divider(),
                  mensagemErroLogin(),
                  ButtonTheme(
                      child: ElevatedButton.icon(
                    icon: const Icon(Icons.login_rounded),
                    label: const Text(
                      "Efetuar Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (_chaveForm.currentState!.validate()) {
                        sistema.usuarioLogado = await UsuarioHelper().login(
                            _usuarioController.text, _senhaController.text);
                        if (sistema.usuarioLogado.id > 0) {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const telaOpcoes()));
                        } else {
                          mostraMsg = true;
                          setState(() {});
                        }
                      }
                    },
                  )),
                ],
              ),
              //Botão Registrar
              Column(
                children: [
                  ButtonTheme(
                      child: ElevatedButton.icon(
                    icon: const Icon(Icons.app_registration_rounded),
                    label: const Text(
                      "Registrar-se",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  const telaCadastroCliente()))
                    },
                  ))
                ],
              ),
              //Botão Avançar
              Column(
                children: [
                  ButtonTheme(
                      child: ElevatedButton.icon(
                    icon: const Icon(Icons.navigate_next_sharp),
                    label: const Text(
                      "Administrativo",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const telaOpcoes()))
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  mensagemErroLogin() {
    return Visibility(
      child: const Text(
        "Usuário não encontrado",
        style: TextStyle(fontSize: 22, color: Colors.red),
      ),
      visible: mostraMsg,
    );
  }
}

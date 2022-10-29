import 'package:appaula/backend/cadastroUsuario.dart';
import 'package:appaula/frontend/telaEmConstrucao.dart';
import 'package:appaula/persistenciaArquivoJson/persistenciaArquivoJson.dart';
import 'package:appaula/frontend/telaBemVindo.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../backend/sistema.dart';
import '../listaCadastros.dart';
import 'efetuarReserva.dart';

class telaOpcoes extends StatefulWidget {
  const telaOpcoes({Key? key}) : super(key: key);

  @override
  State<telaOpcoes> createState() => _telaOpcoesState();
}

class _telaOpcoesState extends State<telaOpcoes> {
  List<Usuario> usuarios = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PersistenciaArquivoJson().lerUsuario().then((value) {
      usuarios = value;
      print(usuarios);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Olá, ${sistema.usuarioLogado.usuario}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const telaBemVindo()));
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const telaBemVindo()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/bannertelainicial.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Escolha a opção desejada",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.vpn_key),
                      label: const Text(
                        "Efetuar Reserva",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => efetuarReserva()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 100, right: 100, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))))
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.format_list_numbered_sharp),
                      label: const Text("Visualizar Reservas Ativas",
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const telaEmConstrucao()));
                        //tela para visualizar as reservas ativas
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 52, right: 52, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))))
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.price_change_outlined),
                      label: const Text("Tabela de Preços",
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const telaEmConstrucao()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 92, right: 92, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))))
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.credit_card),
                      label: const Text("Cartões Cadastrados",
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const telaEmConstrucao()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 73, right: 73, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))))
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.supervised_user_circle_rounded),
                      label: const Text("Visualizar Usuários",
                          style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const listaCadastros()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 80, right: 80, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))))
                ],
              )
            ],
          ),
        ));
  }
}

import 'package:appaula/frontend/telaLogin.dart';
import 'package:flutter/material.dart';

class telaBemVindo extends StatefulWidget {
  const telaBemVindo({Key? key}) : super(key: key);

  @override
  State<telaBemVindo> createState() => _telaBemVindoState();
}

class _telaBemVindoState extends State<telaBemVindo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    avancarTelaBemVindo();
  }

  void avancarTelaBemVindo() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const telaLogin()));
    });
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        botao = true;
      });
    });
  }

  bool botao = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AllCars Locadora"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "AllCars Locadora",
              style: TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 3, 73, 179)),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          Center(
            child: Text(
              "Bem-Vindo",
              style: TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 3, 73, 179)),
            ),
          ),
          SizedBox(height: 30),
          Visibility(
            visible: botao,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const telaLogin()));
              },
              icon: Icon(Icons.arrow_forward_rounded),
              label: const Text(
                "Entrar",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          )
        ],
      ),
    );
  }
}

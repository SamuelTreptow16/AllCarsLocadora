import 'package:flutter/material.dart';

class telaEmConstrucao extends StatefulWidget {
  const telaEmConstrucao({ Key? key }) : super(key: key);

  @override
  State<telaEmConstrucao> createState() => _telaEmConstrucaoState();
}

class _telaEmConstrucaoState extends State<telaEmConstrucao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela em Construção"),),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 120,),
              Text("Tela em Construção...", style: TextStyle(fontSize: 26),),
              SizedBox(height: 60,),
              Image.asset('assets/images/engrenagem.png')
            ],
          )),
    );
  }
}
import 'package:appaula/frontend/opcoesHome/telaOpcoesHome.dart';
import 'package:flutter/material.dart';

class efetuarReserva extends StatefulWidget {
  efetuarReserva({Key? key}) : super(key: key);

  @override
  State<efetuarReserva> createState() => _efetuarReservaState();
}

class _efetuarReservaState extends State<efetuarReserva> {
  List<String> tiposVeiculos = [
    'Econômico',
    'Econômico + Ar Condicionado',
    'Conforto',
    'Premium'
  ];
  String? itemSelecionado = 'Econômico';
  DateTime dateRet = DateTime(2022, 09, 22);
  DateTime dateDev = DateTime(2022, 09, 22);
  TextEditingController _nomeRetirada = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Efetuar Reserva"),
        ),
        body: corpo());
  }

  corpo() {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(height: 15),
        const Text(
          "Selecione a Categoria de Locação",
          style: TextStyle(fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 5, color: Colors.blue))),
            value: itemSelecionado,
            items: tiposVeiculos
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 24),
                    )))
                .toList(),
            onChanged: (item) => setState(() => itemSelecionado = item),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        //Retirada do Veículo
        const Text(
          "Data de Retirada do Veículo",
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          '${dateRet.day}/${dateRet.month}/${dateRet.year}',
          style: TextStyle(fontSize: 25),
        ),
        ElevatedButton(
          child: const Text(
            "Selecione a Data",
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: dateRet,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (newDate == null) return;
            setState(() => dateRet = newDate);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        //Devolução do Veículo
        const Text(
          "Data de Devolução do Veículo",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          '${dateDev.day}/${dateDev.month}/${dateDev.year}',
          style: TextStyle(fontSize: 25),
        ),
        ElevatedButton(
          child: const Text(
            "Selecione a Data",
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: dateDev,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (newDate == null) return;
            setState(() => dateDev = newDate);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Nome de Quem Retira o Veículo: ",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        nomeRetirada(_nomeRetirada, ""),
        const SizedBox(height: 20),
        ElevatedButton.icon(
            icon: const Icon(Icons.next_plan_outlined),
            label: const Text(
              "Realizar Reserva",
              style: TextStyle(fontSize: 24),
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const telaOpcoes()));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Reserva Efetuada com Sucesso")));
            })
      ],
    ));
  }
}

nomeRetirada(TextEditingController controller, String label) {
  return TextFormField(
    controller: controller,
    style:
        const TextStyle(color: Color.fromARGB(255, 3, 73, 179), fontSize: 20),
    decoration: const InputDecoration(icon: Icon(Icons.person_rounded)),
    validator: (texto) {
      if (texto!.isEmpty) {
        return "Campo Obrigatório";
      }
    },
  );
}

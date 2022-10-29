import 'dart:ffi';

class UsuarioPropriedades{
  static String id = "id";
  static String email = "email";
  static String usuario = "usuario";
  static String senha = "senha";
  static String cpf = "cpf";
  static String endereco = "endereço";
  static String telefone = "telefone";
}

class Usuario {
  int id = 0;
  String email = "";
  String usuario = "";
  String senha = "";
  String cpf = "";
  String endereco = "";
  String telefone = "";

  Usuario({this.usuario = "Visitante", this.senha = "123456"}) {
    cpf = "12345678900";
    endereco = "Rua A, 123, Bairro Centro, Camaquã/RS";
    telefone = "51980340337";
    //construtor
  }

  //Cria um objeto do tipo Map
  Usuario.fromMap(Map map) {
    id = map[UsuarioPropriedades.id] ?? 0;
    email = map[UsuarioPropriedades.email];
    usuario = map[UsuarioPropriedades.usuario];
    senha = map[UsuarioPropriedades.senha];
    cpf = map[UsuarioPropriedades.cpf];
    endereco = map[UsuarioPropriedades.endereco];
    telefone = map[UsuarioPropriedades.telefone];
  }

  //Converte o objeto Map em String para gravar no banco
  Map<String, Object> toMap() {
    Map<String, Object> map = {
      UsuarioPropriedades.email: email,
      UsuarioPropriedades.usuario: usuario,
      UsuarioPropriedades.senha: senha,
      UsuarioPropriedades.cpf: cpf,
      UsuarioPropriedades.endereco: endereco,
      UsuarioPropriedades.telefone: telefone
    };
    if(id > 0) {
      map[UsuarioPropriedades.id] = id;
    }
    return map;
  }
}
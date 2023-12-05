//import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';

bool contieneCaracteres(String texto) {
  // Utiliza una expresión regular para verificar que haya al menos un carácter que no sea un espacio en blanco
  RegExp expresionRegular = RegExp(r'\S');

  // La función any() devuelve true si la expresión regular coincide con al menos un carácter no blanco
  return expresionRegular.hasMatch(texto);
}

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _Name = TextEditingController();
  final TextEditingController _Email = TextEditingController();
  final TextEditingController _Number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Crear Cuenta',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
                child: TextField(
                  controller: _Name,
                  decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)),
                )),
            const SizedBox(height: 16.0),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
                child: TextField(
                  controller: _Email,
                  decoration: const InputDecoration(
                      labelText: 'Correo Electrónico',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)),
                )),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300]),
              child: TextField(
                maxLength: 10,

                //inputFormatters: [LengthLimitingTextInputFormatter(10)],
                keyboardType: TextInputType.phone,
                controller: _Number,
                //maxLines: 10,
                //   maxLengthEnforcement: true,
                //  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: 'Numero de Telefono',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)),
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  final emailRegex =
                      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                  final nameRegex = RegExp(r'^[a-zA-Z ]+$');
                  if (contieneCaracteres(_Name.text) == false ||
                      contieneCaracteres(_Email.text) == false ||
                      contieneCaracteres(_Number.text) == false) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Termina de llenar el formulario',
                          textAlign: TextAlign.center,
                        ),
                        content: const Icon(
                          Icons.error_outline,
                          size: 100,
                          color: Colors.amber,
                        ),
                        //error_round
                        actions: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (emailRegex.hasMatch(_Email.text) == false) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'El Correo no existe',
                          textAlign: TextAlign.center,
                        ),
                        content: const Icon(
                          Icons.error_outline,
                          size: 100,
                          color: Colors.amber,
                        ),
                        //error_round
                        actions: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (nameRegex.hasMatch(_Name.text) == false) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Por favor Introduce tu verdadero Nombre',
                          textAlign: TextAlign.center,
                        ),
                        content: const Icon(
                          Icons.error_outline,
                          size: 100,
                          color: Colors.amber,
                        ),
                        //error_round
                        actions: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (_Number.text.length < 10) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Te falta que termines de llenar tu numero ',
                          textAlign: TextAlign.center,
                        ),
                        content: const Icon(
                          Icons.error_outline,
                          size: 100,
                          color: Colors.amber,
                        ),
                        //error_round
                        actions: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    try {
                      final response = await http.post(
                        Uri.parse("http://192.168.1.76:3001/du"),
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                        },
                        body: jsonEncode(
                          <String, String>{
                            "Name": _Name.text,
                            "Email": _Email.text,
                            "Number": _Number.text
                          },
                        ),
                      );
                      if (response.statusCode == 200) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateUser(),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'EL numero ya se esta usando en otra cuenta',
                              textAlign: TextAlign.center,
                            ),
                            content: const Icon(
                              Icons.error_outline,
                              size: 100,
                              color: Colors.amber,
                            ),
                            //error_round
                            actions: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'ERROR DE CONEXION',
                            textAlign: TextAlign.center,
                          ),
                          content: const Icon(
                            Icons.cloud_off_rounded,
                            size: 100,
                            color: Colors.blueGrey,
                          ),
                          //error_round
                          actions: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Siguiente ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  var _user_img;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //  shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Craer usuario",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text("Foto de perfil"),
              // Padding(padding: EdgeInsets.symmetric(vertical: 20),ch)
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: TextButton(
                  onPressed: () async {
                    var img = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png'],
                    );
                    _user_img =
                        img != null ? '${img.files.single.path}' : _user_img;
                    setState(() {});
                  },
                  child: _user_img == null
                      ? Icon(
                          Icons.account_circle,
                          size: deviceWidth / 2.5,
                          color: Colors.blueGrey[600],
                          //color: Colo,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(_user_img),
                            width: deviceWidth / 2.5,
                            height: deviceWidth / 2.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
                child: const TextField(
                  //     controller: passwordController,
                  //  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Usuario',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
                child: const TextField(
                  //     controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]),
                child: const TextField(
                  //     controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Confirma la Contraseña',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)),
                ),
              ),
              const SizedBox(height: 20),
              //   Image.asset(
              //   user_img,
              //  width: 200.0, // Ajusta el ancho según tus necesidades
              // height: 200.0, // Ajusta la altura según tus necesidades
              // ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () async {
                    //      print(_user_img);
                    //await ImagePicker().pickImage(source: ImageSource.gallery);

                    //     await ImagePicker().pickImage();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    /*  Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false);*/
                    //Navigator.of(context).canPop();
                    //  print(canPop);
                    //Navigator.pop(context);
                    //   Navigator.removeRoute(context, Navigator.of(context).history[1]);
                  },
                  child: const Text(
                    'Terminar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

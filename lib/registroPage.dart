import 'package:blinkedid/escaneo.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  late double w, h;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                _banner(),
                _titulo(),
                _textoSig(),
                _email(),
                _password(),
                _comenzar(),
                _olvideContra(),
                SizedBox(height: 50),
                _ptLogo(),
                SizedBox(height: 25)
              ],
            ),
          ),
        ));
  }

  _ptLogo() {
    return Container(
      height: 100,
      width: w,
      alignment: Alignment.center,
      child: Container(
          width: 65,
          height: 65,
          child: Image.asset("assets/images/ptLogo.jpeg", fit: BoxFit.cover)),
    );
  }

  _olvideContra() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: w,
      alignment: Alignment.center,
      child: Text(
        "Olvidé mi contraseña",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xffE8122E),
            fontSize: 15,
            //fontWeight: FontWeight.w500,
            letterSpacing: 1),
      ),
    );
  }

  _comenzar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: w,
      alignment: Alignment.center,
      child: Container(
          child: FlatButton(
        minWidth: 200,
        height: 54,
        color: Color(0xffDB3028),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => EscaneoPage(),
          ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text("Comenzar",
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                letterSpacing: 2,
                fontWeight: FontWeight.bold)),
      )),
    );
  }

  _email() {
    return _textForm("Email", false);
  }

  _password() {
    return _textForm("Password", true);
  }

  _textForm(String label, bool isPassword) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: w,
      alignment: Alignment.center,
      child: Container(
        width: w * 0.75,
        child: TextFormField(
          obscureText: isPassword,
          decoration: InputDecoration(labelText: label),
        ),
      ),
    );
  }

  _textoSig() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: w,
      alignment: Alignment.center,
      child: Text(
        "Mi elección,\nmi registro.",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xff211915),
            fontSize: 25,
            //fontWeight: FontWeight.w500,
            letterSpacing: 2),
      ),
    );
  }

  _titulo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: w,
      alignment: Alignment.center,
      child: Text(
        "Bienvenidos",
        style: TextStyle(
            color: Color(0xffDB3028),
            fontSize: 40,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  _banner() {
    return Container(
      height: 100,
      width: w,
      child: Image.asset("assets/images/fondoRojo.jpeg", fit: BoxFit.fitWidth),
    );
  }
}

import 'package:blinkedid/encuesta2.dart';
import 'package:flutter/material.dart';

class EncuestaPage1 extends StatefulWidget {
  @override
  _EncuestaPage1State createState() => _EncuestaPage1State();
}

class _EncuestaPage1State extends State<EncuestaPage1> {
  late double w, h;
  int valGroup = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: _banner(),
          elevation: 0,
          //toolbarHeight: ,
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
                //_banner(),
                _titulo(),
                _textoSig(),
                //_scanear(),
                SizedBox(height: 25),
                _opciones(),
                SizedBox(height: 25),
                _enviar(),
                SizedBox(height: 120),
                _ptLogo(),
                SizedBox(height: 25)
              ],
            ),
          ),
        ));
  }

  _opciones() {
    return Column(
      children: [
        _opcion(1, "Sí"),
        _opcion(2, "No"),
      ],
    );
  }

  _opcion(int val, String text) {
    return Container(
      width: w,
      alignment: Alignment.center,
      //margin: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio(
            value: val,
            groupValue: valGroup,
            onChanged: (value) {
              setState(() {
                valGroup = val;
              });
            },
            activeColor: Color(0xffDB3028),
          ),
          Container(
            width: 50,
            child: Text(text, style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  _enviar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: w,
      alignment: Alignment.center,
      child: Container(
          child: FlatButton(
        minWidth: 180,
        height: 54,
        color: Color(0xffDB3028),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => EncuestaPage2(),
          ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Icon(
          Icons.arrow_forward,
          size: 30,
          color: Colors.white,
        ) /*Text("Enviar",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                letterSpacing: 2,
                fontWeight: FontWeight.bold))*/
        ,
      )),
    );
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

  _textoSig() {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 5),
      width: w,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "¿Votarías por el Partido\ndel Trabajo?",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xff211915),
            fontSize: 18,
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
        "Sondeo de\nopinión",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xffDB3028),
            fontSize: 25,
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

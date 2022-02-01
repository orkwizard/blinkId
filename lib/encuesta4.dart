import 'package:flutter/material.dart';

class EncuestaPage4 extends StatefulWidget {
  @override
  _EncuestaPage4State createState() => _EncuestaPage4State();
}

class _EncuestaPage4State extends State<EncuestaPage4> {
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
                SizedBox(height: 25),
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
        _opcion(1, "Seguridad"),
        _opcion(2, "Limpieza"),
        _opcion(3, "Opciones culturales"),
        //_opcion(4, "Lo desapruebo mucho"),
      ],
    );
  }

  _opcion(int val, String text) {
    return Container(
      width: w,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
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
            //width: 50,
            child: Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
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
          /* Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => EncuestaPage4(),
          ));*/
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
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: w,
      alignment: Alignment.center,
      child: Text(
        "Marca la opción que tenga más importancia para tu comunidad",
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

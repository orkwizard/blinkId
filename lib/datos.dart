import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:blinkid_flutter/microblink_scanner.dart';

class DatosPage extends StatefulWidget {
  String datos,
      fullDocumentFrontImageBase64,
      fullDocumentBackImageBase64,
      faceImageBase64;
  DatosPage(
      {required this.datos,
      required this.fullDocumentFrontImageBase64,
      required this.fullDocumentBackImageBase64,
      required this.faceImageBase64});
  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  late double w, h;

  late String datos,
      _fullDocumentFrontImageBase64,
      _fullDocumentBackImageBase64,
      _faceImageBase64;
  late Widget fullDocumentFrontImage = SizedBox();
  late Widget fullDocumentBackImage = SizedBox();
  late Widget faceImage = SizedBox();
  @override
  void initState() {
    // TODO: implement initState
    datos = this.widget.datos;
    _fullDocumentFrontImageBase64 = this.widget.fullDocumentFrontImageBase64;
    _fullDocumentBackImageBase64 = this.widget.fullDocumentBackImageBase64;
    _faceImageBase64 = this.widget.faceImageBase64;
    super.initState();
  }

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
                _textoSig("Datos"),
                _datosString(),
                _fotoFacial(),
                _fotoFrontal(),
                _fotoTrasera(),
                _enviar(),
                SizedBox(height: 50),
                _ptLogo(),
                SizedBox(height: 25)
              ],
            ),
          ),
        ));
  }

  _fotoFacial() {
    if (_faceImageBase64 != null && _faceImageBase64 != "") {
      faceImage = Column(
        children: <Widget>[
          _textoSig("Imagen facial"),
          Image.memory(
            Base64Decoder().convert(_faceImageBase64),
            height: 150,
            width: 100,
          )
        ],
      );
      return faceImage;
    }
  }

  _fotoFrontal() {
    //Widget _fullDocumentFrontImage =  fullDocumentFrontImage;
    if (_fullDocumentFrontImageBase64 != null &&
        _fullDocumentFrontImageBase64 != "") {
      fullDocumentFrontImage = Column(
        children: <Widget>[
          _textoSig("Imagen Frontal"),
          Image.memory(
            Base64Decoder().convert(_fullDocumentFrontImageBase64),
            height: 180,
            width: 350,
          )
        ],
      );
    }
    return fullDocumentFrontImage;
  }

  _fotoTrasera() {
    if (_fullDocumentBackImageBase64 != null &&
        _fullDocumentBackImageBase64 != "") {
      fullDocumentFrontImage = Column(
        children: <Widget>[
          _textoSig("Imagen Posterior"),
          Image.memory(
            Base64Decoder().convert(_fullDocumentBackImageBase64),
            height: 180,
            width: 350,
          )
        ],
      );
    }
    return fullDocumentBackImage;
  }

  _datosString() {
    return Text(datos);
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
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text("Enviar",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                letterSpacing: 2,
                fontWeight: FontWeight.bold)),
      )),
    );
  }

  _textoSig(String texto) {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 5),
      width: w,
      alignment: Alignment.center,
      child: Text(
        texto,
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
        "Datos capturados",
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

import 'dart:convert';

import 'package:blinkedid/encuesta1.dart';
import 'package:flutter/material.dart';
import 'package:blinkid_flutter/microblink_scanner.dart';

class DatosPage extends StatefulWidget {
  String fullDocumentFrontImageBase64,
      fullDocumentBackImageBase64,
      faceImageBase64,
      datosString;
  BlinkIdCombinedRecognizerResult datos;
  DatosPage(
      {required this.datos,
      required this.fullDocumentFrontImageBase64,
      required this.fullDocumentBackImageBase64,
      required this.faceImageBase64,
      required this.datosString});
  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  late double w, h;

  late String _fullDocumentFrontImageBase64,
      _fullDocumentBackImageBase64,
      _faceImageBase64,
      datosString;
  late BlinkIdCombinedRecognizerResult datos;
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
    datosString = this.widget.datosString;
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
                _textoSig("Datos"),
                _datoValor("Nombre", datos.fullName ?? ""),
                _datoValor("Dirección", datos.address ?? ""),
                _datoValor("CURP", datos.personalIdNumber ?? ""),
                _datoValor("Número de\ndocumento", datos.documentNumber ?? ""),
                _datoValor("Clave", datos.documentAdditionalNumber ?? ""),
                _datoValor(
                    "Sexo", (datos.sex ?? "M") == "M" ? "Mujer" : "Hombre"),
                _datoValor("Nacionalidad", datos.nationality ?? ""),
                _datoValor(
                    "Fecha de\nnacimiento", buildDateResult(datos.dateOfBirth)),
                _datoValor("Edad", datos.age?.toString() ?? ""),
                _datoValor(
                    "Fecha de\nemisión", buildDateResult(datos.dateOfIssue)),
                _datoValor("Fecha de\nexpiración",
                    buildDateResult(datos.dateOfExpiry)),
                //_datosString(),
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

  String buildDateResult(Date? result) {
    if (result == null || result.year == 0) {
      return "";
    }

    return buildResult("${result.day}/${result.month}/${result.year}");
  }

  String buildResult(String? result) {
    if (result == null || result.isEmpty) {
      return "";
    }

    return result;
  }

  _datoValor(String dato, String valor) {
    return Container(
        height: 70,
        width: w,
        //alignment: Alignment.center,
        child: Container(
          //width: 65,
          margin: EdgeInsets.symmetric(horizontal: 40),
          height: 65,
          child: Row(
            children: [
              Text(
                dato + ": ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                //width: 170,
                child: TextField(
                  enabled: false,
                  //expands: true,
                  //maxLength: 100,
                  maxLines: 2,
                  minLines: 1,
                  controller: TextEditingController(text: valor),
                ),
              )
            ],
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
    print(datos.fullName);
    return Text(datosString);
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => EncuestaPage1(),
          ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text("Continuar",
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
        child:
            Image.asset("assets/images/fondoRojo.jpeg", fit: BoxFit.fitWidth));
  }
}

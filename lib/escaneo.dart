import 'package:blinkedid/datos.dart';
import 'package:flutter/material.dart';
import 'package:blinkid_flutter/microblink_scanner.dart';

class EscaneoPage extends StatefulWidget {
  @override
  _EscaneoPageState createState() => _EscaneoPageState();
}

class _EscaneoPageState extends State<EscaneoPage> {
  late double w, h;

  String _resultString = "";
  String _fullDocumentFrontImageBase64 = "";
  String _fullDocumentBackImageBase64 = "";
  String _faceImageBase64 = "";

  Future<void> scan() async {
    String license;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      license =
          "sRwAAAEbc3BoZXJlcy5ibGlua2VkSUQuYmxpbmtlZGlk5bG+fKiPMlVZ0Sx1wMabzdUdtR0gmNRlzdStaNXIxBilXptTWdJhGxsykPN5CIwQI9jBxgCOoAYLcUQ/hB9jhx+dSsPtT1p+oOH1s6WX/eH8fxJ15vMl3TyJTgmLU5u62q/UQlvNmIhNLz3ft7NAuRdFsziRoW3EafvgxDrimhFH/7kUHKP/34NfSLBblF64a1Da4omHCFFQHgRELYR2vTMVSPNv6rpya0jUxlA4c+k=";
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      license =
          "sRwAAAAbc3BoZXJlcy5ibGlua2VkSUQuYmxpbmtlZGlkz86zxMbHSl6X2nntAgY9TUt45PfDByg0Vr+LocAwuHQVJ+9P8tDFBupM6kmo3EHcdiGyK4btt81oMqtcfqkzSAyhpA5iRCRdT3NIBZFleraY30KMI/wnJyl2lwWNEKFXhibCMekpEQhUFFbJvC4MTMsj3nBiKvClUwIaEJHJT8ow/TwQhMnc+SdqVyXTZElEV1UGXf/4z66a9puuAS3xlCcPZ6GMn5CO2STnOmfqQIg=";
    } else {
      license = "";
    }

    var idRecognizer = BlinkIdCombinedRecognizer();
    idRecognizer.returnFullDocumentImage = true;
    idRecognizer.returnFaceImage = true;

    BlinkIdOverlaySettings settings = BlinkIdOverlaySettings();

    var results = await MicroblinkScanner.scanWithCamera(
        RecognizerCollection([idRecognizer]), settings, license);

    if (!mounted) return;

    if (results.length == 0) return;
    for (var result in results) {
      if (result is BlinkIdCombinedRecognizerResult) {
        if (result.mrzResult?.documentType == MrtdDocumentType.Passport) {
          _resultString = getPassportResultString(result);
        } else {
          _resultString = getIdResultString(result);
          print(result.fullName);
        }

        setState(() {
          _resultString = _resultString;
          _fullDocumentFrontImageBase64 = result.fullDocumentFrontImage ?? "";
          _fullDocumentBackImageBase64 = result.fullDocumentBackImage ?? "";
          _faceImageBase64 = result.faceImage ?? "";
        });

        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => DatosPage(
            datos: result,
            fullDocumentFrontImageBase64: _fullDocumentFrontImageBase64,
            fullDocumentBackImageBase64: _fullDocumentBackImageBase64,
            faceImageBase64: _faceImageBase64,
            datosString: _resultString,
          ),
        ));

        return;
      }
    }
  }

  String getIdResultString(BlinkIdCombinedRecognizerResult result) {
    return buildResult(result.firstName, "First name") +
        buildResult(result.lastName, "Last name") +
        buildResult(result.fullName, "Full name") +
        buildResult(result.localizedName, "Localized name") +
        buildResult(result.additionalNameInformation, "Additional name info") +
        buildResult(result.address, "Address") +
        buildResult(
            result.additionalAddressInformation, "Additional address info") +
        buildResult(result.documentNumber, "Document number") +
        buildResult(
            result.documentAdditionalNumber, "Additional document number") +
        buildResult(result.sex, "Sex") +
        buildResult(result.issuingAuthority, "Issuing authority") +
        buildResult(result.nationality, "Nationality") +
        buildDateResult(result.dateOfBirth, "Date of birth") +
        buildIntResult(result.age, "Age") +
        buildDateResult(result.dateOfIssue, "Date of issue") +
        buildDateResult(result.dateOfExpiry, "Date of expiry") +
        buildResult(result.dateOfExpiryPermanent.toString(),
            "Date of expiry permanent") +
        buildResult(result.maritalStatus, "Martial status") +
        buildResult(result.personalIdNumber, "Personal Id Number") +
        buildResult(result.profession, "Profession") +
        buildResult(result.race, "Race") +
        buildResult(result.religion, "Religion") +
        buildResult(result.residentialStatus, "Residential Status") +
        buildDriverLicenceResult(result.driverLicenseDetailedInfo);
  }

  String buildResult(String? result, String propertyName) {
    if (result == null || result.isEmpty) {
      return "";
    }

    return propertyName + ": " + result + "\n";
  }

  String buildDateResult(Date? result, String propertyName) {
    if (result == null || result.year == 0) {
      return "";
    }

    return buildResult(
        "${result.day}.${result.month}.${result.year}", propertyName);
  }

  String buildIntResult(int? result, String propertyName) {
    if (result == null || result < 0) {
      return "";
    }

    return buildResult(result.toString(), propertyName);
  }

  String buildDriverLicenceResult(DriverLicenseDetailedInfo? result) {
    if (result == null) {
      return "";
    }

    return buildResult(result.restrictions, "Restrictions") +
        buildResult(result.endorsements, "Endorsements") +
        buildResult(result.vehicleClass, "Vehicle class") +
        buildResult(result.conditions, "Conditions");
  }

  String getPassportResultString(BlinkIdCombinedRecognizerResult? result) {
    if (result == null) {
      return "";
    }

    var dateOfBirth = "";
    if (result.mrzResult?.dateOfBirth != null) {
      dateOfBirth = "Date of birth: ${result.mrzResult!.dateOfBirth?.day}."
          "${result.mrzResult!.dateOfBirth?.month}."
          "${result.mrzResult!.dateOfBirth?.year}\n";
    }

    var dateOfExpiry = "";
    if (result.mrzResult?.dateOfExpiry != null) {
      dateOfExpiry = "Date of expiry: ${result.mrzResult?.dateOfExpiry?.day}."
          "${result.mrzResult?.dateOfExpiry?.month}."
          "${result.mrzResult?.dateOfExpiry?.year}\n";
    }

    return "First name: ${result.mrzResult?.secondaryId}\n"
        "Last name: ${result.mrzResult?.primaryId}\n"
        "Document number: ${result.mrzResult?.documentNumber}\n"
        "Sex: ${result.mrzResult?.gender}\n"
        "$dateOfBirth"
        "$dateOfExpiry";
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
                _scanear(),
                _enviar(),
                SizedBox(height: 50),
                _ptLogo(),
                SizedBox(height: 25)
              ],
            ),
          ),
        ));
  }

  _scanear() {
    return Container(
        height: 280,
        width: w,
        alignment: Alignment.center,
        child: InkWell(
          radius: 15,
          onTap: () {
            scan();
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffBABABA),
            ),
            width: 65,
            height: 65,
            child: Icon(Icons.camera_alt),
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
          scan();
        },
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
      //margin: EdgeInsets.symmetric(vertical: 5),
      width: w,
      alignment: Alignment.center,
      child: Text(
        "Escanea tu INE",
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
        "Registra tu\nINE",
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

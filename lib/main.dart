import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          title: "Calculadora de IMC",
          home: Home()
      )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";
  String _imcInfo = "";

  void _resetForm() {
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = "Informe seus dados!";
      _imcInfo = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double result = weight/(height*height);

      if(result < 17.0) {
        _infoText = "Muito abaixo do Peso";
      } else if(result >= 17.0 && result < 18.49) {
        _infoText = "Abaixo do Peso";
      } else if(result >= 18.49 && result < 24.9) {
        _infoText = "Peso Ideal";
      } else if(result >= 24.9 && result < 29.9) {
        _infoText = "Levemente Acima do Peso";
      } else if(result >= 29.9 && result < 34.9) {
        _infoText = "Obesidade Grau I";
      } else if(result >= 34.9 && result < 39.9) {
        _infoText = "Obesidade Grau II";
      } else {
        _infoText = "Obesidade Grau III";
      }

      _imcInfo = "(${result.toStringAsPrecision(4)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetForm,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira o seu Peso!";
                  } else if (double.tryParse(value) == null) {
                    return "Insira um valor numérico correto!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira a sua Altura!";
                  } else if (double.tryParse(value) == null) {
                    return "Insira um valor numérico correto!";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: Container(
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        _calculate();
                        FocusScope.of(context).requestFocus(new FocusNode());
                      }
                    },
                    child: Text(
                      "CALCULAR",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    _imcInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 30.0),
                  )
              ),
            ],
          ),
        )
      )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:simple_weather_app/restApiSrvc.dart';
import 'package:simple_weather_app/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _inputCtrl = TextEditingController();
  bool submitBtnEnabled = true;
  String output = "Result goes here";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Weather App", style: TextStyle(color: Colors.black)),
        leading: const Icon(Icons.sunny, color: Colors.yellow)
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        //main scroll view
        child: SingleChildScrollView(

          //Main column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //input fields
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height/4,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Center(
                  child:  TextFormField(
                      controller: _inputCtrl,
                      decoration: const InputDecoration(labelText: "Please enter your city", hintText: "Eg: London"),
                    )
                )
              ),
              const SizedBox(height: 20),

              //Button
              Container(
                width: 130,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: submitBtnEnabled? getWeather : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lime),
                    foregroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  child: const Center(child: Text("Get Weather"))
                ),
              ),

              //Output display
              SizedBox(
                height: MediaQuery.of(context).size.height/2.5,
                child: Center(child: SelectableText(output))
              )
            ]
          )
        )
      )
    );
  }

  void getWeather() async {
    if(_inputCtrl.text.isNotEmpty) {
      String out;
      try {
        setState(() {
          output = "Waiting for network!";
          submitBtnEnabled = false;
        });
        Weather ans = await RestApiSrvc().callApi(_inputCtrl.text);
        out = ans.getWeather();
      }
      catch (e) {
        out = e.toString();
      }
      setState(() {
        output = out;
        submitBtnEnabled = true;
      });
    }
  }
}

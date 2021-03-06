import 'dart:html';
import 'dart:io';

import 'package:WebAppTestOne/MultiLayerPerceptron.dart';
import 'package:WebAppTestOne/linearsvmPage.dart';
import 'package:WebAppTestOne/polySVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:csv/csv.dart';

import 'oneDConvNN.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NoML Maker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String selectedText;
  Color selectedColor = Colors.blue;

  Map<String, bool> map = {'uploading_file':false, 'checking_file': false, 'analyzing_params': false, 'structuring_data':false};

  int noOfColumns;
  List<List<dynamic>> listOfColumns;

  bool canEnableButton = false;
  var convertedStringList;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        backgroundColor: selectedColor,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: MediaQuery.of(context).size.width < 912 ? Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[


                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("Hi there!", style: TextStyle(
                            fontSize: 36.0,
                            color: Colors.black,
                          ),),

                        ),

                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child:
                          Text("Before you can start customizing this model, I would need the sample dataset information. For now, let's skip dataset upload and move on with some sample data which I will expla"
                              "in you.", textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),),
                        ),

                        new DropdownButton<String>(
                          value: selectedText,
                          items: <String>['Linear Support Vector Machine', 'Polynomial Support Vector Machine', 'Multi-layer Perceptron model', '1D Convolution Neural Network'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text("Select a model"),
                          onChanged: (_) {

                            selectedText = _;

                            switch(_) {
                              case 'Linear Support Vector Machine': selectedColor = Colors.blue; break;
                              case 'Polynomial Support Vector Machine': selectedColor = Colors.deepPurple; break;
                              case 'Multi-layer Perceptron model': selectedColor = Colors.green; break;
                              case '1D Convolution Neural Network': selectedColor = Colors.pink; break;
                            }

                            setState(() {

                            });


                          },
                        ),




                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            color: selectedColor,
                            textColor: Colors.white,
                            onPressed: () async {

                              InputElement uploadInput = FileUploadInputElement();
                              uploadInput.click();


                              uploadInput.onChange.listen((e) {
                                map['uploading_file'] = true;
                                final files = uploadInput.files;
                                if (files.length == 1) {
                                  final file = files[0];

                                  print(file.type.toString());

                                  final reader = new FileReader();

                                  reader.onLoadEnd.listen((e) {

                                    map['analyzing_params'] = true;
                                    listOfColumns = const CsvToListConverter(textEndDelimiter: "*", ).convert(reader.result);
                                    noOfColumns = listOfColumns[0].length;



                                    convertedStringList = new List<String>.from(listOfColumns[0]);

                                    print(noOfColumns);
                                    debugPrint(convertedStringList);

                                  });
                                  reader.readAsText(file);
                                }
                              });

                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16,16,16,16),
                              child: Text("Upload Dataset (simplified)"),
                            ),
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child:
                          RaisedButton(
                            elevation: 16.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            onPressed: () {
                              if(selectedText == "Linear Support Vector Machine") {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LinearSVM(noOfColumns: noOfColumns, columnNames: convertedStringList == null ?  [''] : convertedStringList,)));
                              } else if(selectedText == "Polynomial Support Vector Machine") {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PolySVM(noOfColumns: noOfColumns, columnNames: convertedStringList == null ?  [''] : convertedStringList,)));

                              } else if (selectedText == "Multi-layer Perceptron model") {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MultiLayerPerceptron(noOfColumns: noOfColumns, columnNames: convertedStringList == null ?  [''] : convertedStringList,)));

                              }
                            },
                            textColor: Colors.white,
                            color: selectedColor,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 16,16,16),
                              child: Text("Let's get Started!",),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )
              ),
            ),
          ),
        ) : Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[


                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("Hi there!", style: TextStyle(
                            fontSize: 36.0,
                            color: Colors.black,
                          ),),

                        ),

                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child:
                          Text("Based on the model you select, you might be required to install different packages for proper functioning.", textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),),
                        ),

                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child:
                          DropdownButton<String>(
                            value: selectedText,
                            items: <String>['Linear Support Vector Machine', 'Polynomial Support Vector Machine', 'Multi-layer Perceptron model', '1D Convolution Neural Network'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: Text(value)
                              );
                            }).toList(),
                            hint: Text("Select a model"),
                            onChanged: (_) {

                              selectedText = _;

                              switch(_) {
                                case 'Linear Support Vector Machine': selectedColor = Colors.blue; break;
                                case 'Polynomial Support Vector Machine': selectedColor = Colors.deepPurple; break;
                                case 'Multi-layer Perceptron model': selectedColor = Colors.green; break;
                                case '1D Convolution Neural Network': selectedColor = Colors.pink; break;
                              }

                              setState(() {

                              });


                            },
                          ),

                        ),



                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            color: selectedColor,
                            textColor: Colors.white,
                            onPressed: () async {

                              InputElement uploadInput = FileUploadInputElement();
                              uploadInput.click();


                              uploadInput.onChange.listen((e) {
                                final files = uploadInput.files;
                                if (files.length == 1) {
                                  final file = files[0];
                                  print(file.type.toString());
                                  final reader = new FileReader();
                                  reader.readAsText(file);



                                  reader.onLoadEnd.listen((e) {

                                    String dataString = reader.result;
                                    List<String> okay = dataString.split("\n");
                                    convertedStringList = okay[0].split(",");
                                    print(okay[0]);


                                  });
                                }
                              });

                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16,16,16,16),
                              child: Text("Upload Dataset (simplified)"),
                            ),
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child:
                          RaisedButton(
                            elevation: 16.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            onPressed: () {
                              if(selectedText == "Linear Support Vector Machine") {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LinearSVM(noOfColumns: noOfColumns, columnNames: convertedStringList == null ?  [''] : convertedStringList,)));
                              } else if(selectedText == "Polynomial Support Vector Machine") {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PolySVM(noOfColumns: noOfColumns, columnNames: convertedStringList == null ?  [''] : convertedStringList,)));

                              } else if (selectedText == "Multi-layer Perceptron model") {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MultiLayerPerceptron(noOfColumns: noOfColumns, columnNames: convertedStringList == null ?  [''] : convertedStringList,)));

                              } else if(selectedText == "1D Convolution Neural Network") {

                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OneDNN(noOfColumns: noOfColumns, columnNames: convertedStringList == null ?  [''] : convertedStringList,)));

                              }
                            },
                            textColor: Colors.white,
                            color: selectedColor,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 16,16,16),
                              child: Text("Let's get Started!",),
                            ),
                          ),
                        ),


                      ],
                    ),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

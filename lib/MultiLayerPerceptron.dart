import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MultiLayerPerceptron());

class MultiLayerPerceptron extends StatelessWidget {
  MultiLayerPerceptron({Key key, this.noOfColumns, this.columnNames}) : super(key: key);
  final int noOfColumns;
  final List<String> columnNames;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiLayerPerceptronStateful(
        title: "Multilayer Perceptron Designing",
        noOfColumns: noOfColumns,
        columnNames: columnNames,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MultiLayerPerceptronStateful extends StatefulWidget {
  MultiLayerPerceptronStateful({Key key, this.title, this.noOfColumns, this.columnNames}) : super(key: key);
  final String title;
  final int noOfColumns;
  final List<String> columnNames;

  State<MultiLayerPerceptronStateful> createState() => MultiLayerPerceptronState();
}

class MultiLayerPerceptronState extends State<MultiLayerPerceptronStateful> {

  Color selectedColor = Colors.green;

  List<String> selectedChoices = List();
  TextEditingController controllerForDatasetName = new TextEditingController();
  TextEditingController controllerForPredictionDatasetName = new TextEditingController();

  List<Widget> hiddenLayers = new List();
  List<TextEditingController> hiddenNeuronsCount = new List();
  int presentNumber = -1;
  double learningRateNumber = 0;

  TextEditingController noOfEpochs = new TextEditingController();

  String modelOptimizer;


  @override
  Widget build(BuildContext context) {


    _buildChoiceList() {
      List<Widget> choices = List();
      widget.columnNames.forEach((item) {
        choices.add(Container(
          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            selectedColor: selectedColor,
            backgroundColor: Colors.deepPurple,
            label: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(item.toString(), style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),),
            ),
            selected: selectedChoices.contains(item.toString()),
            onSelected: (selected) {

              setState(() {
                selectedChoices.contains(item.toString())
                    ? selectedChoices.remove(item.toString())
                    : selectedChoices.add(item.toString());
              });

            },
          ),
        ));
      });
      return choices;
    }

    debugPrint(widget.columnNames.toString());

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[


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
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Parameters required for code generation", style: TextStyle(
                              fontSize: 20.0,
                            ),),
                          ),


                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("** Suggestions can be seen here", style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.deepPurple,
                            ),),
                          ),


                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("** Warnings can be seen here", style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.red,
                            ),),
                          ),


                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child:
                                  Text("Name of the dataset: ", style: TextStyle(
                                    fontSize: 16.0,
                                  ),),
                                ),

                                Flexible(
                                  flex: 2,
                                  child:
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                    child:
                                    TextField(
                                      obscureText: false,
                                      controller: controllerForDatasetName,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),






                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child:
                                  Text("Name of the prediction dataset: ", style: TextStyle(
                                    fontSize: 16.0,
                                  ),),
                                ),

                                Flexible(
                                  flex: 2,
                                  child:
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                    child:
                                    TextField(
                                      obscureText: false,
                                      controller: controllerForPredictionDatasetName,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),



                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Select the Output nodes of Neural Network",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),


                          Row(
                            children: <Widget>[

                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),


                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                                child: Text("- Input parameters"),
                              ),

                            ],
                          ),




                          Row(
                            children: <Widget>[

                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                  ),
                                ),
                              ),


                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                                child: Text("- Output parameters"),
                              ),
                            ],
                          ),



                          SingleChildScrollView(
                            child:
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 16, 16, 16),
                              child:
                              Wrap(
                                children: _buildChoiceList(),
                              ),
                            ),
                            scrollDirection: Axis.horizontal,
                          ),


                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Add Hidden layers (optional)", style: TextStyle(
                              fontSize: 16.0,
                            ),),
                          ),



                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(16.0),
                            child:  Row(
                              children: <Widget>[

                                Row(
                                  children: hiddenLayers,
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(16.0, 0,0,0),
                                  child:
                                  FloatingActionButton(
                                    child: Icon(Icons.add),
                                    backgroundColor: selectedColor,
                                    onPressed: () {

                                      hiddenNeuronsCount.add(new TextEditingController());
                                      presentNumber = presentNumber + 1;
                                      hiddenLayers.add(

                                        Container(
                                          width: 100,
                                          height: 100,
                                          child:

                                          Padding(
                                            padding: EdgeInsets.fromLTRB(16.0, 0,0,0),
                                            child:
                                            TextField(
                                              obscureText: false,
                                              controller: hiddenNeuronsCount[presentNumber],
                                            ),
                                          ),

                                        ),
                                      );

                                      setState(() {

                                      });
                                    },
                                  ),
                                ),



                              ],
                            ),
                          ),


                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child:
                                  Text("Epochs / Iterations / Steps :", style: TextStyle(
                                    fontSize: 16.0,
                                  ),),
                                ),

                                Flexible(
                                  flex: 2,
                                  child:
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                    child:
                                    TextField(
                                      obscureText: false,
                                      controller: noOfEpochs,

                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),



                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child:
                                  Text("Model Optimizer :", style: TextStyle(
                                    fontSize: 16.0,
                                  ),),
                                ),

                                Flexible(
                                  flex: 2,
                                  child:
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                                    child:

                                      DropdownButton<String>(
                                      value: modelOptimizer,
                                      items: <String>['adam', 'mse', 'Something else'].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      hint: Text("Select one"),
                                      onChanged: (_) {
                                        modelOptimizer = _;

                                        setState(() {

                                        });


                                      },
                                    ),

                                  ),
                                ),

                              ],
                            ),
                          ),



                          Center(
                            child:
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: RaisedButton(
                                color: selectedColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                onPressed: () {

                                  List<String> remElems = new List();
                                  for(String a in selectedChoices) {
                                    for(String x in widget.columnNames) {
                                      if(a == x) {

                                      } else {
                                        remElems.add(x);
                                      }
                                    }
                                  }

                                  int u = 1;
                                  String hiddenLayers;
                                  bool isNull = hiddenNeuronsCount.length < 1  ? true : false;
                                  if(isNull) {
                                    hiddenLayers = "layer$u = Dense(units=${selectedChoices.length}, activation='relu', kernel_initializer='uniform', input_dim = inputDimension)\nnetwork.add(layer$u)";
                                  } else {
                                    TextEditingController firstOne =  hiddenNeuronsCount[0];
                                    hiddenLayers = "layer$u = Dense(units=${firstOne.text}, activation='relu', kernel_initializer='uniform', input_dim = inputDimension)\nnetwork.add(layer$u)";
                                    hiddenNeuronsCount.removeAt(0);

                                    for(TextEditingController e in hiddenNeuronsCount){
                                      u = u+1;
                                      hiddenLayers = hiddenLayers + "\nlayer$u = Dense(units=${e.text}, activation='relu', kernel_initializer='uniform')\nnetwork.add(layer$u)";
                                    }

                                  }

                                  String apple = '''
import numpy as np
import pandas as pd
import keras
from keras.models import Sequential
from keras.layers import Dense
import csv
from sklearn.model_selection import train_test_split

dataset = np.loadtxt("${controllerForDatasetName.text}", delimiter="'")

X = dataset.drop($selectedChoices, axis=1)
y = dataset.drop($remElems, axis=1)


X_train, X_test, Y_train, Y_test = train_test_split(X, y, test_size=0.33)

inputDimension = ${widget.noOfColumns - selectedChoices.length}
network = Sequential()
$hiddenLayers
network.compile(optimizer='$modelOptimizer',
		loss='mse',
		metrics=['accuracy'])

history = network.fit(X_Train, Y_Train, epochs=${noOfEpochs.text}, batch_size=20)
network.save("model1.h5")''';

                                  Clipboard.setData(new ClipboardData(text: apple));
                                  //_showReportDialog();

                                },
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text("Generate Training model code!", style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                )
                              ),
                            ),
                          ),


                          Center(
                            child:
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: RaisedButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                onPressed: () {



                                  String apple = '''
import keras
import numpy as np

#Dataset which we need to use for the model
test_dataset = np.loadtxt('${controllerForPredictionDatasetName.text}', delimiter=',')

network = keras.models.load_model('model1.h5')

prediction_value = network.predict(test_dataset)
for x in range(len(prediction_value)):
    print(prediction_value[x])
''';

                                  Clipboard.setData(new ClipboardData(text: apple));
                                  //_showReportDialog();

                                },
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text("Generate Prediction model code!", style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                )
                              ),
                            ),
                          ),




                        ],
                      ),
                    ),
                  ),
              ),
          ),
        ),
      ),
    );
  }




}

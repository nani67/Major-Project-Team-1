import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(PolySVM());

class PolySVM extends StatelessWidget {
  PolySVM({Key key, this.noOfColumns, this.columnNames}) : super(key: key);
  final int noOfColumns;
  final List<dynamic> columnNames;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PolySVMStateful(
        title: "Polynomial SVM Designing",
        noOfColumns: noOfColumns,
        columnNames: columnNames,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PolySVMStateful extends StatefulWidget {
  PolySVMStateful({Key key, this.title, this.noOfColumns, this.columnNames}) : super(key: key);
  final String title;
  final int noOfColumns;
  final List<dynamic> columnNames;

  State<PolySVMStateful> createState() => PolySVMState();
}

class PolySVMState extends State<PolySVMStateful> {

  Color selectedColor = Colors.deepPurple;


  List<String> remElems = new List();

  String selectedChoices = "";
  TextEditingController controllerForDatasetName = new TextEditingController();
  TextEditingController controllerForPredictionDatasetName = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    _buildChoiceList() {
      List<Widget> choices = List();
      widget.columnNames.forEach((item) {
        choices.add(Container(
          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            selectedColor: selectedColor,
            backgroundColor: Colors.red,
            label: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(item.toString(), style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),),
            ),
            selected: selectedChoices == item,
            onSelected: (selected) {

              setState(() {
                selectedChoices = item;
              });

            },
          ),
        ));
      });
      return choices;
    }


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

                        Text(widget.columnNames[0] + widget.columnNames[1] + widget.noOfColumns.toString()),

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
                          "Select the Output parameters of the classification model",
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
                                color: Colors.red,
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



                      Center(
                        child:
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: RaisedButton(
                            color: selectedColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            onPressed: () {
                                for(String x in widget.columnNames) {
                                  if(selectedChoices == x) {

                                  } else {
                                    remElems.add(x);
                                  }
                                }

                              String apple = '''
import numpy as np
import pandas as pd
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split

dataset = np.loadtxt("${controllerForDatasetName.text}", delimiter="'")

X = dataset.drop($selectedChoices, axis=1)
y = dataset.drop($remElems, axis=1)

X_train, X_test, Y_train, Y_test = train_test_split(X, y, test_size=0.33)

svClassifierLinear = SVC(kernel="poly", degree = 8)
svClassifierLinear.fit(X_train, y_train)

y_predLin = svClassifierLinear.predict(X_test)

from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
print("Linear SVM")
print(accuracy_score(y_test, y_predLin))
print(confusion_matrix(y_test, y_predLin))
print(classification_report(y_test, y_predLin))
from joblib import dump
dump(svClassifierLinear, "polySVM.joblib")''';

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
dataset = np.loadtxt("${controllerForPredictionDatasetName.text}", delimiter="'")
from joblib import load
svClassifierLinear = load('polySVM.joblib')
y_predLin = svClassifierLinear.predict(dataset)
print(y_predLin)
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

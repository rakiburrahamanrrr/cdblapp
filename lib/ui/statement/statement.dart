import 'package:cdbl/models/statements_model.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../loading_animation.dart';


class StatementPage extends StatelessWidget{
  List<Statement> statements;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Map<String, dynamic> isinName =
        ModalRoute.of(context).settings.arguments;
    var isinname = isinName['isinName'];

    getData() async {
      List statement = await AuthApi().getStatementData(isinname);
      return statement;
    }

    final columns = ['Date', 'Quantity', 'Transaction Type'];

    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Statement Details',
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade300,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
              child: Container(
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List isin = snapshot.data;
                      if (isin.length == 0) {
                        return Container(
                          child: SafeArea(
                              child: Center(
                                  child:
                                      Text("You have no Statement at this moment"))),
                        );
                      } else {
                        return Container(
                          child: SafeArea(
                            child: Column(
                              children: [
                                Container(
                                  child: Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                5.0),),
                                        padding: EdgeInsets.all(5),
                                        height: size.height * .116,
                                        child: Card(color: Colors
                                          .green.shade100,
                                          shadowColor: Colors.green,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * .02,
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: size.height * .02,
                                                        ),
                                                        Text(
                                                          "${isinname.isinname}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize:
                                                              18,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Expanded(
                                    flex: 9,
                                    child: Container(
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          child: DataTable(
                                            columns: getColumns(columns),
                                            rows: getRows(isin),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return loadingAnimation();
                  },
                ),
              ),
          ),
        ));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
          ))
      .toList();

  List<DataRow> getRows(List<Statement> statements) =>
      statements.map((Statement isin) {
        final cells = [isin.trnDate, isin.qty, isin.trnType];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

}

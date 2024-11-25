import 'package:cdbl/models/bo_modify.dart';
import 'package:cdbl/models/statements_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../api.dart';
import '../../loading_animation.dart';


class ModifyHistoryPage extends HookWidget {
  List<BoModify> boModify;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Map<String, dynamic> data =
        ModalRoute.of(context).settings.arguments;
    var boData = data['userdata'];

    getData() async {
      List modify = await AuthApi().getModificationData(boData);
      return modify;
    }

    final columns = ['Field Name','Old Value', 'New Value', 'Modification Date'];

    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Modify History',
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
                    List bomodify = snapshot.data;
                    if (bomodify.length == 0) {
                      return Container(
                        child: SafeArea(
                            child: Center(
                                child:
                                Text("You have no Modifications Yet"))),
                      );
                    } else {
                      return Container(
                        child: SafeArea(
                          child: Column(
                            children: [
                              Container(
                                child: Expanded(
                                  flex: 1,
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
                                                        boData,
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
                                          rows: getRows(bomodify),
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

  List<DataRow> getRows(List<BoModify> boModify) =>
      boModify.map((BoModify bomodify) {
        final cells = [bomodify.field, bomodify.oldvalue,bomodify.newvalue, bomodify.modifyDate];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

}

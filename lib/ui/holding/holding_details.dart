import 'package:flutter/material.dart';

class BalanceDetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> balanceData =
        ModalRoute.of(context).settings.arguments;
    var balance = balanceData["balanceData"];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Holding Details',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 15, right: 16,bottom: 30 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'ISIN Name',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        balance.isinShortName,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //    textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'ISIN',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        balance.dpAddCcyCode,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        // textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Holdings',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        balance.dpAdTotalBalance,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        // textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Close Price',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        balance.closeRate,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Value',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        balance.value,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //  textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Close Price on',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        balance.currDate,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                        //  textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

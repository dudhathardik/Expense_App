import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        // NewTransaction(_addNewTrasaction),
        // SizedBox(height: 20),
        // TransactionList(_userTransactions),
      ],
    );
  }
}

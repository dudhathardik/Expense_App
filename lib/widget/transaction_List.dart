import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  // ignore: use_key_in_widget_constructors
  const TransactionList(
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: ((ctx, constraints) {
              return Column(
                children: <Widget>[
                  const Text(
                    'No transaction added yet!',
                    // style: Theme.of(context).textTheme.titleLarge,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'asset/image/hardik.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            }),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                // color: Color.fromARGB(255, 233, 236, 236),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 47, 147, 160),
                    foregroundColor: Colors.white,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? TextButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                          onPressed: () => deleteTx(transactions[index].id),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}

// Container(
//                   height: 80,
//                   child: Card(
//                     color: const Color.fromARGB(255, 47, 147, 160),
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: const Color.fromARGB(255, 255, 228, 145),
//                             border: Border.all(
//                                 color: const Color(0xFF9C27B0), width: 2),
//                             borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10)),
//                           ),
//                           child: Text(transactions[index].id),
//                         ),
//                         const SizedBox(width: 10),
//                         Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.black, width: 2),
//                               color: Colors.amber),
//                           child: Text(
//                             '\$${transactions[index].amount.toStringAsFixed(2)}',
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                         ),
//                         const SizedBox(width: 30),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               transactions[index].title,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 16),
//                             ),
//                             Text(
//                               DateFormat.yMMMd()
//                                   .format(transactions[index].date),
//                               style: const TextStyle(color: Colors.black54),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );

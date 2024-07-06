import 'dart:io';
import 'package:demo/model/transaction.dart';
import 'package:demo/widget/new_Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'widget/transaction_List.dart';
import './widget/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transaction App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 47, 147, 160),
          secondary: const Color.fromARGB(255, 47, 147, 160),
        ),
        fontFamily: 'BalsamiqSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontFamily: 'BalsamiqSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              titleMedium: const TextStyle(
                  fontFamily: 'BalsamiqSans',
                  fontSize: 16,
                  color: Colors.black),
              titleSmall: const TextStyle(
                  fontFamily: 'BalsamiqSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 'T1',
    //   title: 'Shoes',
    //   amount: 20.40,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'T2',
    //   title: 'Shirt',
    //   amount: 15.60,
    //   date: DateTime.now(),
    // ),
  ];

  // it is used for switch
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // add new transaction
  void _addNewTrasaction(String txTitle, double txAmount, DateTime chodenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chodenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //
    // open input slide from bottom side
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTrasaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

// delete add data from device
  void _deleteTransaction(String id) {
    // print(id);
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

//
// eter methode which is used for to get last 7 days chart data and chart list
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    /* make widget here for appBar calling 
     then i used this widget directly into 
     my app where i called this appBar widget*/

    Widget _buildAppBar() {
      return Platform.isIOS
          ? CupertinoNavigationBar(
              middle: const Text('Expense App'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: const Icon(CupertinoIcons.add),
                    onTap: () => _startAddNewTransaction(context),
                  )
                ],
              ),
            )
          : AppBar(
              title: Text(
                'Expense App',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: const Icon(Icons.add),
                ),
              ],
            );
    }

    //
    // i used mediaQuery variable here to replace MediaQuery.of(context)
    final mediaQuery = MediaQuery.of(context);
    /*isLandscape Used for here to show chart and transaction list differently
     for potrait we showed both chart as well as transaction list
     Landscape mode = we used switch here to change chart to transaction list
      and transaction list to chart*/
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    //AppBar widget
    final dynamic appBar = _buildAppBar();
    //transaction list
    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

// build widget(LandSacape) which is used for readeble code and clear code
    List<Widget> _buildLandscapeContent(Widget txListWidget) {
      return [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Show Chart'),
          Switch.adaptive(
              activeColor: const Color.fromARGB(255, 47, 147, 160),
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ]),
        _showChart
            ? SizedBox(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: Chart(_recentTransactions),
              )
            : txListWidget
      ];
    }

// This Widget(Potrait) is used for readeble ans clean code
    List<Widget> _buildPotraitContent(Widget txListWidget) {
      return [
        SizedBox(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.25,
          child: Chart(_recentTransactions),
        ),
        txListWidget
      ];
    }

    // page body
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                ..._buildLandscapeContent(
                  txListWidget,
                ),

              /*Calling chart class / with only 7 days 
            because I used here _receneTransaction which is used for
            Print seven days chart.  That get methode shown above*/
              if (!isLandscape)
                ..._buildPotraitContent(
                  txListWidget,
                ),
            ]),
      ),
    );

//
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(Icons.add),
                    backgroundColor: Theme.of(context).colorScheme.secondary),
          );
  }
}

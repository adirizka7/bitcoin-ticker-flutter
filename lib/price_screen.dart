import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'USD';
  Map rate = {'BTC': '?', 'ETH': '?', 'LTC': '?'};

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String currency in currenciesList) {
      dropdownMenuItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      )); // DropdownMenuItem
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          setRateData();
        });
      },
    ); // DropdownButton<String>
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          setRateData();
        });
      },
      children: pickerItems,
    ); // CupertinoPicker
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    }

    return androidDropdown();
  }

  void setRateData() async {
    for (String crypto in cryptoList) {
      try {
        var rateInDecimals =
            await coinData.getCoinData(crypto: crypto, fiat: selectedCurrency);
        setState(() {
          rate[crypto] = rateInDecimals.toStringAsFixed(2);
        });
      } catch (e) {
        print('Error setting rate data $e');
      }
    }
  }

  Card buildCoinCard({String coin}) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ), // RoundedRectangleBorder
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $coin = ${rate["$coin"]} $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ), // TextStyle
        ), // Text
      ), // Padding
    ); // Card
  }

  @override
  void initState() {
    super.initState();

    setRateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('???? Coin Ticker'),
      ), // AppBar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildCoinCard(coin: 'BTC'),
                buildCoinCard(coin: 'ETH'),
                buildCoinCard(coin: 'LTC'),
              ], // <Widget>
            ), // Row
          ), // Padding
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ), // Container
        ], // <Widget>
      ), // Column
    ); // Scaffold
  }
}

/*
*/

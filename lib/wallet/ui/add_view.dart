import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
  ];

  String dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            value: dropdownValue,
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: coins.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: "Coin Amount",
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: MaterialButton(
              onPressed: () async {
                // var model = Coin();
                // switch (dropdownValue) {
                //   case "bitcoin":
                //     model = Coin(bitcoin: double.parse(_amountController.text));
                //     break;
                //
                //   case "ethereum":
                //     model =
                //         Coin(ethereum: double.parse(_amountController.text));
                //     break;
                //   case "tether":
                //     model = Coin(tether: double.parse(_amountController.text));
                //     break;
                //   default:
                //     break;
                // }
                // final walletModel = WalletModel(coin: model);
                // await WalletDataManager.addCoin(walletModel);
                // Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}

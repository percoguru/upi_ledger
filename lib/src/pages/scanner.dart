import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/add_expense.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  Barcode? _barcode;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    void handleBarcode(BarcodeCapture barcodes) {
      if (mounted) {
        String? url = barcodes.barcodes.firstOrNull?.displayValue;

        if (url != null) {
          var uri = Uri.dataFromString(url);

          String receiverUpiAddress = uri.queryParameters['pa'] ?? '';
          String receiverName = uri.queryParameters['pn'] ?? '';
          String transactionRef = uri.queryParameters['tr'] ?? '';
          String amount = uri.queryParameters['cu'] ?? '235';

          Navigator.restorablePushNamed(context, AddExpenseView.routeName,
              arguments: {
                'upiAddress': receiverUpiAddress,
                'name': receiverName,
                'amount': amount
              });
        }
        setState(() {
          _barcode = barcodes.barcodes.firstOrNull;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Simple scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: handleBarcode,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _buildBarcode(_barcode))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

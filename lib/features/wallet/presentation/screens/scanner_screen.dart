import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sizer/sizer.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isScanerActivated = true;
  final MobileScannerController _controller = MobileScannerController(
    autoZoom: true,
    // shoud be DetectionSpeed.noDuplicates
    detectionSpeed: DetectionSpeed.unrestricted,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => context.goNamed('wallet'),
            icon: Icon(Icons.arrow_back_ios),
          ),
          isScanerActivated
              ? Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.6),
                  ),
                  child: MobileScanner(
                    overlayBuilder: (context, constraints) {
                      return Container(
                        height: 20.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      );
                    },
                    controller: _controller,
                    onDetect: (value) {
                      final List<Barcode> barcodes = value.barcodes;
                      for (final barcode in barcodes) {
                        print('-----------');
                        print(barcode.rawValue);
                        print('-----------');
                      }
                    },
                  ),
                )
              : SizedBox(),
          ElevatedButton(
            onPressed: () => setState(() {
              isScanerActivated = !isScanerActivated;
            }),
            child: Text('Add a card manually'),
          ),
        ],
      ),
    );
  }
}

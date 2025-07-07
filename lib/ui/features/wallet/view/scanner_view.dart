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
  final MobileScannerController _scannerController = MobileScannerController(
    autoZoom: true,
    detectionSpeed: DetectionSpeed.normal,
  );

  @override
  void dispose() {
    _scannerController.stop();
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.goNamed('wallet'),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.6),
            ),
            child: MobileScanner(
              controller: _scannerController,
              overlayBuilder: (context, constraints) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 20.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
              onDetect: (value) async {
                final Barcode codeValue = value.barcodes.first;
                if (codeValue.rawValue != null) {
                  context.goNamed(
                    'newcard',
                    extra: {'value': codeValue.rawValue},
                  );
                }
              },
              scanWindow: Rect.fromCenter(
                center: Offset(50.w, 35.h),
                width: 70.w,
                height: 20.h,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed('newcard');
            },
            child: Text('Add a card manually'),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int currentIdx = 0;
  final CarouselSliderController controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    // TODO remove Scaffold
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            leading: Icon(Icons.arrow_back_ios),
            actions: [
              TextButton.icon(
                onPressed: () => context.goNamed('newcard'),
                label: Text('Dodaj kartę'),
                icon: Icon(Icons.add_circle),
                style: ButtonStyle(
                  overlayColor: WidgetStateColor.transparent,
                ),
              ),
            ],
          ),
          CarouselSlider(
            options: CarouselOptions(
              initialPage: currentIdx,
              height: 70.h,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: (nextIdx, reason) {
                setState(() {
                  currentIdx = nextIdx;
                });
              },
            ),
            carouselController: controller,
            items: List<Widget>.generate(
              6,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  color: index % 2 == 0 ? Colors.amber : Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('Card name $index'),
                          trailing: Icon(Icons.edit),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: SizedBox(
                            width: 20.h,
                            height: 20.h,
                            child: Placeholder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: AnimatedSmoothIndicator(
              activeIndex: currentIdx,
              count: 6,
              effect: SwapEffect(dotHeight: 1.h, dotWidth: 1.h),
            ),
          ),
        ],
      ),
    );
  }
}

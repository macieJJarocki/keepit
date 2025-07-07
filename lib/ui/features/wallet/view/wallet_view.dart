import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keepit/data/model/card_entity.dart';
import 'package:keepit/ui/features/wallet/view_model/wallet_view_model.dart';
import 'package:provider/provider.dart';
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
    final viewModel = Provider.of<WalletViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () => context.goNamed('home'),
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () => context.goNamed('scanner'),
                  label: Text('Dodaj kartę'),
                  icon: Icon(Icons.add_circle),
                  style: ButtonStyle(
                    overlayColor: WidgetStateColor.transparent,
                  ),
                ),
              ],
            ),
            Consumer<WalletViewModel>(
              builder: (context, value, child) => CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  height: 65.h,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (nextIdx, reason) {
                    setState(() {
                      currentIdx = nextIdx;
                    });
                  },
                ),
                items: viewModel.cards.isEmpty
                    ? [Text('No cards')]
                    : List<Widget>.generate(
                        viewModel.cards.length,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            color: index % 2 == 0 ? Colors.amber : Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(1.w),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(viewModel.cards[index].name),
                                    subtitle: Text(
                                      viewModel.cards[index].value,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () => context.goNamed(
                                            'newcard',
                                            extra: CardEntity.fromCard(
                                              viewModel.cards[index],
                                            ).toJson(),
                                          ),

                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () => viewModel.deleteCard(
                                            viewModel.cards[index].id!,
                                          ),
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: AnimatedSmoothIndicator(
                activeIndex: currentIdx,
                count: viewModel.cards.length,
                effect: SwapEffect(
                  dotHeight: 1.h,
                  dotWidth: 1.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

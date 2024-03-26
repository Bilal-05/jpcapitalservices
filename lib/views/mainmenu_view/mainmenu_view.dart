// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jp_app/theme/colors.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/mainmenu_view/mainmenu_vm.dart';
import 'package:jp_app/views/mainmenu_view/widget/expanded_girdview.dart';
import 'package:stacked/stacked.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => MainMenuVM(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, vModel, child) {
        // final List<Widget> imageSliders = vModel.imgList
        //     .map((item) => SizedBox(
        //           child: Container(
        //             margin: const EdgeInsets.all(5.0),
        //             child: ClipRRect(
        //                 borderRadius:
        //                     const BorderRadius.all(Radius.circular(5.0)),
        //                 child: Stack(
        //                   children: <Widget>[
        //                     Image.network(item,
        //                         fit: BoxFit.fill, width: 1000.0),
        //                     Positioned(
        //                       bottom: 0.0,
        //                       left: 0.0,
        //                       right: 0.0,
        //                       child: Container(
        //                         decoration: const BoxDecoration(
        //                           gradient: LinearGradient(
        //                             colors: [
        //                               Color.fromARGB(200, 0, 0, 0),
        //                               Color.fromARGB(0, 0, 0, 0)
        //                             ],
        //                             begin: Alignment.bottomCenter,
        //                             end: Alignment.topCenter,
        //                           ),
        //                         ),
        //                         padding: const EdgeInsets.symmetric(
        //                             vertical: 10.0, horizontal: 20.0),
        //                         child: Text(
        //                           'No. ${vModel.imgList.indexOf(item)} image',
        //                           style: const TextStyle(
        //                             color: Colors.white,
        //                             fontSize: 20.0,
        //                             fontWeight: FontWeight.bold,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 )),
        //           ),
        //         ))
        //     .toList();

        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 0.3.sh,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 0.05.sw,
                        top: 0.05.sh,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: InkWell(
                              onTap: () {
                                vModel.setFalse();
                              },
                              child: Text(
                                'Welcome Back',
                                style: Style.medium20ptb.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          20.verticalSpace,
                          SizedBox(
                            width: 0.75.sw,
                            child: Text(
                              'Let\'s find your top service! 🛠',
                              style: Style.semiBold35ptw.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // margin: EdgeInsets.only(
                      //     top: 0.02.sh,
                      //     left: 0.02.sw,
                      //     right: 0.02.sw,
                      //     bottom: 0.02.sh),
                      child: const ServicesGirdView(),
                    ),
                  ),
                  // Expanded(
                  //   child:
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

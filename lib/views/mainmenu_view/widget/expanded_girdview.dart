import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:jp_app/theme/colors.dart';
import 'package:jp_app/theme/text.dart';
import 'package:jp_app/views/mainmenu_view/mainmenu_vm.dart';
import 'package:stacked/stacked.dart';

class ServicesGirdView extends StatelessWidget {
  const ServicesGirdView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => MainMenuVM(),
      builder: (context, vModel, child) {
        final double height = MediaQuery.of(context).size.height;
        return SizedBox(
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 0.75,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlay: true,
            ),
            items: vModel.services.service
                .map(
                  (item) => Hero(
                    tag: "${item['serviceName']!}",
                    child: InkWell(
                      onTap: () {
                        vModel.navigateToEstimation(
                          item['serviceName']!,
                        );
                      },
                      child: ClipRRect(
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.network(
                                item['imageUrl']!,
                                fit: BoxFit.cover,
                                height: height,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 1.sw,
                                    height: 100,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  // ignore: avoid_unnecessary_containers
                                  Container(
                                    child: Text(
                                      item['serviceName']!,
                                      style: Style.semiBold20ptb.copyWith(
                                          color: Colors.black, fontSize: 30),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
        // return GridView.builder(
        //   shrinkWrap: true,
        //   itemCount: vModel.services.service.length,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       childAspectRatio: 0.80,
        //       mainAxisSpacing: 30,
        //       crossAxisSpacing: 0),
        //   itemBuilder: (context, index) {
        //     return Hero(
        //       tag: vModel.services.service[index]['serviceName'],
        //       child: InkWell(
        //         onTap: () {
        //           vModel.navigateToEstimation(
        //             vModel.services.service[index]['serviceName'],
        //           );
        //         },
        //         child: Container(
        //           margin: EdgeInsets.only(
        //             left: 0.02.sw,
        //             right: 0.02.sw,
        //           ),
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //               width: 2,
        //               color: AppColors.secondaryColor,
        //             ),
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //           child: Container(
        //             margin: EdgeInsets.only(top: 0.02.sh),
        //             child: Column(
        //               children: [
        //                 Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(20),
        //                   ),
        //                   width: 0.35.sw,
        //                   height: 0.15.sh,
        //                   child: Image.asset(
        //                     vModel.services.service[index]['imageUrl'],
        //                     // fit: BoxFit.cover,
        //                   ),
        //                 ),
        //                 20.verticalSpace,
        //                 SizedBox(
        //                   child: Text(
        //                     // vModel.services['serviceName'],
        //                     vModel.services.service[index]['serviceName'],
        //                     style: Style.semiBold16ptb
        //                         .copyWith(color: Colors.black),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // );
      },
    );
  }
}


// StreamBuilder<QuerySnapshot>(
//           stream: vModel.services.snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Skeletonizer(
//                 enabled: true,
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   itemCount: 5,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.80,
//                       mainAxisSpacing: 30,
//                       crossAxisSpacing: 0),
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.only(
//                         left: 0.02.sw,
//                         right: 0.02.sw,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           width: 2,
//                           color: AppColors.secondaryColor,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Container(
//                         margin: EdgeInsets.only(top: 0.02.sh),
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               width: 0.35.sw,
//                               child:
//                                   Image.asset('assets/images/personLaptop.png'),
//                             ),
//                             20.verticalSpace,
//                             SizedBox(
//                               child: Text(
//                                 'Service Name',
//                                 style: Style.semiBold16ptb
//                                     .copyWith(color: Colors.black),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }

//             if (snapshot.connectionState == ConnectionState.done) {
//               // data local banao bilal
//               return GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: 5,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.80,
//                     mainAxisSpacing: 30,
//                     crossAxisSpacing: 0),
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot services = snapshot.data!.docs[index];
//                   vModel.getUrl(services);
//                   return Container(
//                     margin: EdgeInsets.only(
//                       left: 0.02.sw,
//                       right: 0.02.sw,
//                     ),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 2,
//                         color: AppColors.secondaryColor,
//                       ),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Container(
//                       margin: EdgeInsets.only(top: 0.02.sh),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             width: 0.35.sw,
//                             child: Image.network(
//                               vModel.image,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           20.verticalSpace,
//                           SizedBox(
//                             child: Text(
//                               services['serviceName'],
//                               style: Style.semiBold16ptb
//                                   .copyWith(color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }

//             return GridView.builder(
//               shrinkWrap: true,
//               itemCount: 5,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.80,
//                   mainAxisSpacing: 30,
//                   crossAxisSpacing: 0),
//               itemBuilder: (context, index) {
//                 DocumentSnapshot services = snapshot.data!.docs[index];
//                 vModel.getUrl(services);
//                 return Container(
//                   margin: EdgeInsets.only(
//                     left: 0.02.sw,
//                     right: 0.02.sw,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 2,
//                       color: AppColors.secondaryColor,
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Container(
//                     margin: EdgeInsets.only(top: 0.02.sh),
//                     child: Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           width: 0.35.sw,
//                           child: Image.network(
//                             vModel.image,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         20.verticalSpace,
//                         SizedBox(
//                           child: Text(
//                             services['serviceName'],
//                             style: Style.semiBold16ptb
//                                 .copyWith(color: Colors.black),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
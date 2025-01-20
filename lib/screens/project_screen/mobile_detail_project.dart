import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartfunding/screens/project_screen/widgets/warranty_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/comment/comment_bloc.dart';
import '../../bloc/projects/project_bloc.dart';
import '../../bloc/projects/project_event.dart';
import '../../bloc/projects/project_state.dart';
import '../../constant/scheme.dart';
import '../../data/model/projects/Projects.dart';
import '../../utils/cache_image.dart';
import 'widgets/attachment_widget.dart';
import 'widgets/calculate_widget.dart';
import 'widgets/comment_widget.dart';
import 'widgets/date_chart.dart';
import 'widgets/description_widget.dart';
import 'widgets/info_widget.dart';
import 'widgets/inversters_widget.dart';
import 'widgets/top_detail.dart';

class MobileDetailScreen extends StatefulWidget {
  final ScrollController scrollController;
  Project _project;
  MobileDetailScreen(this.scrollController, this._project, {super.key});

  @override
  State<MobileDetailScreen> createState() => _MobileDetailScreenState();
}

class _MobileDetailScreenState extends State<MobileDetailScreen> {
  @override
  // late VideoPlayerController _controller;
  // late CustomVideoPlayerController _customVideoPlayerController;
  // late VideoPlayerController _videoPlayerController;

  // late CustomVideoPlayerWebController _customVideoPlayerWebController;
  // PageController _page2Controller = PageController();
  // final CustomVideoPlayerSettings _customVideoPlayerSettings =
  //     const CustomVideoPlayerSettings(showSeekButtons: true);
  // late final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
  //     CustomVideoPlayerWebSettings(src: ''
  //         // src: widget._project.videos.length > 0
  //         //     ? widget._project.videos[0].originalUrl
  //         //     : '',
  //         );
  int _currentPage = 0;
  PageController _pageController = PageController();
  //final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    // _customVideoPlayerWebController = CustomVideoPlayerWebController(
    //   webVideoPlayerSettings: _customVideoPlayerWebSettings,
    // );
    BlocProvider.of<ProjectBloc>(context)
        .add(ProjectInversterEvent(widget._project.uuid!));
  }

  void dispose() {
    // _videoPlayerController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      controller: widget.scrollController,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: 350,
              color: Colors.white,
            ),
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(color: Color(0xff074EA0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const PhosphorIcon(
                        PhosphorIconsBold.arrowLeft,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        'assets/images/revers_logo .png',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 65,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: widget._project.images != ''
                    ? Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: PageView.builder(
                              itemCount: widget._project.images!.length,
                              controller: _pageController,
                              allowImplicitScrolling: true,
                              onPageChanged: (index) {
                                // Update the current page when the user swipes
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return Hero(
                                  tag: widget._project.id!,
                                  child: CachedImage(
                                    imageUrl: widget
                                        ._project.images![index].originalUrl,
                                    topLeftradious: 5,
                                    topRightradious: 5,
                                    bottomLeftradious: 5,
                                    bottomRightradious: 5,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SmoothPageIndicator(
                            onDotClicked: (index) {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            controller: _pageController,
                            count: widget._project.images!.length,
                            effect: WormEffect(
                              dotColor: Colors.lightBlue.shade100,
                              dotHeight: 10,
                              dotWidth: 10,
                              type: WormType.thin,
                            ),
                          ),
                        ],
                      )
                    : Image.asset(
                        "assets/images/placeholder.jpg",
                      ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TopContainer.buildContainer(
            400,
            project: widget._project,
            context: context,
            width: MediaQuery.of(context).size.width * 0.90,
            isDesktop: false,
            scrollController: widget.scrollController,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        widget._project.timeTable == null
            ? Container()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Text(
                      'زمان بندی طرح',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: DateChart.buildContainer(200,
                        context: context,
                        project: widget._project,
                        width: MediaQuery.of(context).size.width * 0.9,
                        isDesktop: false,
                        scrollController: widget.scrollController),
                  ),
                ],
              ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                'جزئیات طرح',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Container(
              //height: 550,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300, // Set the border color
                  width: 1.0, // Set the border width
                ),
                //border: Border.all(width: 0.5, color: Colors.grey),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // if (widget._project.videos!.length > 0) ...{
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //     child: SizedBox(
                  //       height: 200,
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: CustomVideoPlayerWeb(
                  //             customVideoPlayerWebController:
                  //                 _customVideoPlayerWebController),
                  //       ),
                  //     ),
                  //   ),
                  // },
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildDescriptionSection(
                      false,
                      context,
                      '',
                      widget._project.description!,
                      null,
                      null,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: buildInfoContainer(context, false, widget._project),
        ),
        BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectInvestersLoadingState) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  // width: 300.0,
                  //  color: AppColorScheme.scafoldCollor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              'سرمایه گذاران',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Shimmer.fromColors(
                            period: const Duration(milliseconds: 500),
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.white,
                            child: Column(
                              children: [
                                for (int i = 0; i < 5; i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Container(
                                      height: 95,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: i == 0
                                                  ? Radius.circular(10)
                                                  : Radius.circular(0),
                                              topRight: i == 0
                                                  ? Radius.circular(10)
                                                  : Radius.circular(0),
                                              bottomRight: i == 4
                                                  ? Radius.circular(10)
                                                  : Radius.circular(0),
                                              bottomLeft: i == 4
                                                  ? Radius.circular(10)
                                                  : Radius.circular(0)),
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                ]
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else {
              if (state is ProjectInverstersResponseState) {
                return state.getInvesters.fold(
                  (l) => Container(),
                  (r) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      //  color: Colors.accents[0],
                      child: Column(
                        children: [
                          buildInvesters(
                              context,
                              r,
                              MediaQuery.of(context).size.width * 0.9,
                              500,
                              false,
                              widget.scrollController,
                              widget._project.uuid!),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            return Container();
          },
        ),
        if (widget._project.waranty != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: WarrantyWidget(
              waranty: widget._project.waranty,
            ),
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: CalculatorWidget(
            project: widget._project,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
          ),
        ),
        if (widget._project.attachments != '')
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: buildAttachmentSection(
              context,
              widget._project,
              MediaQuery.of(context).size.width * 0.89,
              widget._project.attachments!.length * 66,
            ),
          ),
        const SizedBox(
          height: 0,
        ),
        BlocProvider(
          create: (context) => CommentBloc(),
          child: BuildCommentWidget(
            project: widget._project,
            width: MediaQuery.of(context).size.width * 0.89,
            height: 300,
            scrollController: widget.scrollController,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:outlook/components/side_menu.dart';
import 'package:outlook/providers/expert_provider.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/screens/expert/expert_info_screen.dart';
import 'package:outlook/screens/main/components/expert_card.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfExperts extends StatefulWidget {
  // Press "Command + ."
  const ListOfExperts({
    Key key,
  }) : super(key: key);

  @override
  _ListOfExpertsState createState() => _ListOfExpertsState();
}

class _ListOfExpertsState extends State<ListOfExperts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _controller = ScrollController();
  int oldLength = 0;
  @override
  void initState() {
    super.initState();
    // final container = ProviderContainer();
    // final String uid = context.read(firebaseAuthProvider).currentUser.uid;
    context.read(expertPaginationControllerProvider).setQueryVal({});
    _controller.addListener(() async {
      // print('pixel is ${_controller.position.pixels}');
      // print('max is ${_controller.position.maxScrollExtent}');
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent -
              MediaQuery.of(context).size.height -
              30) {
        if (context
                .read(expertPaginationControllerProvider.state)
                .isRefreshing ==
            false) {
          //       paginationState.experts.indexOf(post) >=
          // paginationState.experts.length - 2 &&

          // make sure ListView has newest data after previous loadMore
          context.read(expertPaginationControllerProvider).loadMorePost();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: SideMenu(),
        ),
        body: Consumer(builder: (ctx, watch, child) {
          final paginationController =
              watch(expertPaginationControllerProvider);
          final paginationState =
              watch(expertPaginationControllerProvider.state);
          oldLength = paginationState.experts?.length ?? 0;
          if (paginationState.refreshError) {
            return _ErrorBody(message: paginationState.errorMessage);
          } else if (paginationState.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
            color: kBgDarkColor,
            child: SafeArea(
              right: false,
              child: Column(
                children: [
                  // This is our Seearch bar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        // Once user click the menu icon the menu shows like drawer
                        // Also we want to hide this menu icon on desktop
                        if (!Responsive.isDesktop(context))
                          IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                        if (!Responsive.isDesktop(context)) SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            onChanged: (input) {
                              context
                                  .read(expertPaginationControllerProvider)
                                  .searchExperts({"name": input});
                            },
                            onSubmitted: (input) {
                              context
                                  .read(expertPaginationControllerProvider)
                                  .searchExperts({"name": input});
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              fillColor: kBgLightColor,
                              filled: true,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(
                                    kDefaultPadding * 0.75), //15
                                child: WebsafeSvg.asset(
                                  "assets/Icons/Search.svg",
                                  width: 24,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Row(
                      children: [
                        WebsafeSvg.asset(
                          "assets/Icons/Angle down.svg",
                          width: 16,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Sort by date",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        MaterialButton(
                          minWidth: 20,
                          onPressed: () {},
                          child: WebsafeSvg.asset(
                            "assets/Icons/Sort.svg",
                            width: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: () {
                          return context
                              .refresh(expertPaginationControllerProvider)
                              .refreshexperts();
                        },
                        child: Scrollbar(
                          isAlwaysShown: true,
                          child: ListView.builder(
                            controller: _controller,
                            itemCount: paginationState.experts.length,

                            // On mobile this active dosen't mean anything
                            itemBuilder: (context, index) {
                              if (index == paginationState.experts.length - 1) {
                                return LinearProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                );
                              }
                              return ExpertCard(
                                isActive: Responsive.isMobile(context)
                                    ? false
                                    : index == 0,
                                expert: paginationState.experts[index],
                                press: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ExpertInfoScreen(
                                          expert:
                                              paginationState.experts[index]));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ExpertInfoScreen(email: emails[index]),
                                  //   ),
                                  // );
                                },
                              );
                            },
                          ),
                        )

                        //  ListView.builder(
                        //   controller: _controller,
                        //   itemCount: paginationState.experts.length,
                        //   itemBuilder: (context, index) {
                        //     // last element (progress bar, error or 'Done!' if reached to the last element)
                        //     if (index == paginationState.experts.length - 1) {
                        //       return LinearProgressIndicator(
                        //         valueColor:
                        //             AlwaysStoppedAnimation<Color>(Colors.blue),
                        //       );
                        //     }
                        //     // use the index for pagination
                        //     // paginationController.handleScrollWithIndex(index);

                        //     return artivleListView(
                        //         context,
                        //         paginationState.experts[index],
                        //         paginationState,
                        //         paginationController);
                        //     // _MovieBox(movie: paginationState.movies[index]);
                        //   },
                        // ),
                        ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    Key key,
    @required this.message,
  })  : assert(message != null, 'A non-null String must be provided'),
        super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => context
                .refresh(expertPaginationControllerProvider)
                .awaitExpertsList(),
            child: Text("Try again"),
          ),
        ],
      ),
    );
  }
}

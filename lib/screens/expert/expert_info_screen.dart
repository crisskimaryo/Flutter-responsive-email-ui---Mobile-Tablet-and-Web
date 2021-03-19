import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outlook/models/expert_model.dart';
import 'package:outlook/screens/expert/components/expert_services_list.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'package:flutter_tags/flutter_tags.dart';
import '../../constants.dart';
import 'components/header.dart';

class ExpertInfoScreen extends StatelessWidget {
  const ExpertInfoScreen({
    Key key,
    this.expert,
  }) : super(key: key);

  final ExpertModel expert;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = new ScrollController();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Header(),
              Divider(thickness: 1),
              Expanded(
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 24,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(expert.profileImageUrl),
                        ),
                        SizedBox(width: kDefaultPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            text: expert.businessName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                            children: [
                                              TextSpan(
                                                  text: "  ${expert.email} ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                            ],
                                          ),
                                        ),
                                        // Text(
                                        //   "Inspiration for our new home",
                                        //   style: Theme.of(context)
                                        //       .textTheme
                                        //       .headline6,
                                        // )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(width: kDefaultPadding / 2),
                                  // Text(
                                  //   "Today at 15:32",
                                  //   style: Theme.of(context).textTheme.caption,
                                  // ),
                                ],
                              ),
                              SizedBox(height: kDefaultPadding),
                              LayoutBuilder(
                                builder: (context, constraints) => SizedBox(
                                  width: constraints.maxWidth > 850
                                      ? 800
                                      : constraints.maxWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${expert.bio}",
                                        style: TextStyle(
                                          height: 1.5,
                                          color: Color(0xFF4D5875),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      SizedBox(height: kDefaultPadding),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "6 attachments",
                                      //       style: TextStyle(fontSize: 12),
                                      //     ),
                                      //     Spacer(),
                                      //     Text(
                                      //       "Download All",
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .caption,
                                      //     ),
                                      //     SizedBox(width: kDefaultPadding / 4),
                                      //     WebsafeSvg.asset(
                                      //       "assets/Icons/Download.svg",
                                      //       height: 16,
                                      //       color: kGrayColor,
                                      //     ),
                                      //   ],
                                      // ),

                                      Divider(thickness: 1),
                                      SizedBox(height: kDefaultPadding / 2),

                                      _outdateSpecializationLists(expert),
                                      // _specializationLists(expert),
                                      ServiceCatergoriesScreen(
                                        expert: expert,
                                      ),
                                      // SizedBox(
                                      //   height: 200,
                                      //   child: StaggeredGridView.countBuilder(
                                      //     physics:
                                      //         NeverScrollableScrollPhysics(),
                                      //     crossAxisCount: 4,
                                      //     itemCount: 3,
                                      //     itemBuilder: (BuildContext context,
                                      //             int index) =>
                                      //         ClipRRect(
                                      //       borderRadius:
                                      //           BorderRadius.circular(8),
                                      //       child: Image.asset(
                                      //         "assets/images/Img_$index.png",
                                      //         fit: BoxFit.cover,
                                      //       ),
                                      //     ),
                                      //     staggeredTileBuilder: (int index) =>
                                      //         StaggeredTile.count(
                                      //       2,
                                      //       index.isOdd ? 2 : 1,
                                      //     ),
                                      //     mainAxisSpacing: kDefaultPadding,
                                      //     crossAxisSpacing: kDefaultPadding,
                                      //   ),
                                      // ),

                                      SizedBox(
                                        height: 100,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _outdateSpecializationLists(ExpertModel expert) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Outdated Service Category'),
          Divider(thickness: 1),
          Container(
              padding: EdgeInsets.only(top: 5),
              child: Tags(
                itemCount: expert.category.length, // required
                itemBuilder: (int index) {
                  final item = expert.category[index];
                  // print(item);
                  return ItemTags(
                    highlightColor: null,
                    // removeButton: ItemTagsRemoveButton(
                    //     color: feigreenlightColor.withOpacity(.9)),
                    onPressed: null,

                    active: false,
                    // activeColor: feigreenlightColor.withOpacity(.9),
                    // color: Colors.white,
                    pressEnabled: false,
                    // Each ItemTags must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets.
                    key: Key(index.toString()),
                    index: index, // required
                    title: item,
                    // active: item.active,
                    // customData: item.customData,
                    textStyle: TextStyle(
                      fontSize: 12,
                    ),
                    // combine: ItemTagsCombine.withTextBefore,
                    borderRadius: BorderRadius.zero,
                  );
                },
              ))
        ],
      ),
    );
  }
}

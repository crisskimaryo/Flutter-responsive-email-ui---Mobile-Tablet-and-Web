import 'package:flutter/material.dart';
import 'package:outlook/models/expert_model.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';
import '../../../extensions.dart';

class ExpertCard extends StatelessWidget {
  const ExpertCard({
    Key key,
    this.isActive = true,
    this.expert,
    this.press,
  }) : super(key: key);

  final bool isActive;
  final ExpertModel expert;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        onTap: press,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: isActive ? kPrimaryColor : kBgDarkColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  // expert.profileImageUrl
                  Row(
                    children: [
                      SizedBox(
                        width: 32,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          // backgroundImage: NetworkImage(expert.profileImageUrl),
                          child: Image.network(expert.profileImageUrl),
                        ),
                      ),
                      SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: "${expert.businessName} \n",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isActive ? Colors.white : kTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: expert.categoryString,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color:
                                          isActive ? Colors.white : kTextColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Column(
                      //   children: [
                      //     Text(
                      //       expert.time,
                      //       style: Theme.of(context).textTheme.caption.copyWith(
                      //             color: isActive ? Colors.white70 : null,
                      //           ),
                      //     ),
                      //     SizedBox(height: 5),
                      //     if (expert.isAttachmentAvailable)
                      //       WebsafeSvg.asset(
                      //         "assets/Icons/Paperclip.svg",
                      //         color: isActive ? Colors.white70 : kGrayColor,
                      //       )
                      //   ],
                      // ),
                    ],
                  ),
                  // SizedBox(height: kDefaultPadding / 2),
                  // Text(
                  //   expert.body,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: Theme.of(context).textTheme.caption.copyWith(
                  //         height: 1.5,
                  //         color: isActive ? Colors.white70 : null,
                  //       ),
                  // )
                ],
              ),
            ).addNeumorphism(
              blurRadius: 15,
              borderRadius: 15,
              offset: Offset(5, 5),
              topShadowColor: Colors.white60,
              bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
            ),
            // if (!expert.isChecked)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kBadgeColor,
                ),
              ).addNeumorphism(
                blurRadius: 4,
                borderRadius: 8,
                offset: Offset(2, 2),
              ),
            ),
            // if (expert.tagColor != null)
            // Positioned(
            //   left: 8,
            //   top: 0,
            //   child: WebsafeSvg.asset(
            //     "assets/Icons/Markup filled.svg",
            //     height: 18,
            //     color: expert.tagColor,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

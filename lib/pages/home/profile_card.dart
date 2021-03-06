import 'package:acs_upb_mobile/authentication/model/user.dart';
import 'package:acs_upb_mobile/authentication/service/auth_provider.dart';
import 'package:acs_upb_mobile/authentication/view/edit_profile_page.dart';
import 'file:///D:/Work/acs-upb-mobile/lib/pages/settings/view/source_page.dart';
import 'package:acs_upb_mobile/generated/l10n.dart';
import 'package:acs_upb_mobile/navigation/bottom_navigation_bar.dart';
import 'package:acs_upb_mobile/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String profilePictureURL;
  User user;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    user = authProvider.currentUserFromCache;
    if (user != null) {
      if (user.sources == null && !AppBottomNavigationBar.didOpenSourcePage) {
        AppBottomNavigationBar.didOpenSourcePage = true;
        debugPrint(AppBottomNavigationBar.didOpenSourcePage.toString());
        Navigator.of(context)
            .push(MaterialPageRoute<SourcePage>(builder: (context) =>
            SourcePage()
        ));

      }
    }
    authProvider
        .getProfilePictureURL(context: context)
        .then((value) => setState(() {
              profilePictureURL = value;
            }));
    authProvider.currentUser.then((value) => setState(() {
          user = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    String userName;
    //final User user = authProvider.currentUserFromCache;
    String userGroup;
    if (user != null) {
      userName = '${user.firstName} ${user.lastName}';
      userGroup = user.classes?.isNotEmpty ?? false ? user.classes.last : null;
    }

    // if (user != null) {
    //   if (user.sources == null && !AppBottomNavigationBar.didOpenSourcePage) {
    //     AppBottomNavigationBar.didOpenSourcePage = true;
    //     debugPrint(AppBottomNavigationBar.didOpenSourcePage.toString());
    //       Navigator.of(context)
    //           .push(MaterialPageRoute<SourcePage>(builder: (context) =>
    //         SourcePage()
    //       ));
    //
    //   }
    // }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            user != null && profilePictureURL != null
                                ? NetworkImage(profilePictureURL)
                                : const AssetImage(
                                    'assets/illustrations/undraw_profile_pic.png',
                                  )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            child: Text(
                              userName ?? S.of(context).stringAnonymous,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .apply(fontWeightDelta: 2),
                            ),
                          ),
                          if (userGroup != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(userGroup,
                                  style: Theme.of(context).textTheme.subtitle1),
                            ),
                          InkWell(
                            onTap: () {
                              Utils.signOut(context);
                            },
                            child: Text(
                                authProvider.isAnonymous
                                    ? S.of(context).actionLogIn
                                    : S.of(context).actionLogOut,
                                style: Theme.of(context)
                                    .accentTextTheme
                                    .subtitle2
                                    .copyWith(fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (user != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            color: Theme.of(context).textTheme.button.color,
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute<EditProfilePage>(
                                  builder: (context) => const EditProfilePage(),
                                ),
                              );
                              final authProvider = Provider.of<AuthProvider>(
                                  context,
                                  listen: false);
                              final value = await authProvider
                                  .getProfilePictureURL(context: context);
                              setState(() {
                                profilePictureURL = value;
                              });
                            }),
                      ],
                    ),
                ],
              ),
              AccountNotVerifiedWarning(),
            ],
          ),
        ),
      ),
    );
  }
}

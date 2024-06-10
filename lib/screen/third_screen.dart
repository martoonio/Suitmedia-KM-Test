import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitmedia_test/provider/user_provider.dart';
import 'package:suitmedia_test/utils/constants.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });
  }

  void _onRefresh() async {
    await Provider.of<UserProvider>(context, listen: false).fetchUsers();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    Provider.of<UserProvider>(context, listen: false).loadMore();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appBar(context, "Third Screen"),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading && userProvider.users.isEmpty) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (userProvider.users.isEmpty) {
            return const Center(
              child: Text(
                'No Users Available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
                )
              );
          } else {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: userProvider.hasMoreData,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                itemCount: userProvider.users.length,
                itemBuilder: (context, index) {
                  final user = userProvider.users[index];
                  return ListTile(
                    minVerticalPadding: 15,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.avatar,
                      ),
                      maxRadius: 30,
                      minRadius: 30,
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle:
                        Text(user.email, style: const TextStyle(fontSize: 10)),
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        userProvider.selectedUserName =
                            '${user.firstName} ${user.lastName}';
                        Navigator.of(context).pop();
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey[300],
                    thickness: 0.5,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

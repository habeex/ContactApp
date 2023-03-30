import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reqresapp/bloc/user_bloc.dart';
import 'package:reqresapp/feature/user/add_user_screen.dart';
import 'package:reqresapp/feature/widget/user_tile.dart';
import 'package:reqresapp/model/user_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int page = 1;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void _onRefresh() async {
    context.read<UserCubit>().getUsers();
  }

  void _onLoading() async {
    context.read<UserCubit>().getUsers(page: page++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact',
            style: TextStyle(color: Colors.black, fontSize: 24)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext s) => AddUserScreen(
                              bloc: this.context.read<UserCubit>(),
                            )));
              },
              child: const Text('Add contact',
                  style: TextStyle(color: Colors.blue, fontSize: 14))),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is LoadedUserState) {
              users = state.users;
              _refreshController.loadComplete();
              _refreshController.refreshToIdle();
              setState(() {});
            }

            if (state is ErrorUserState) {
              _refreshController.loadFailed();
              setState(() {});
            }

            if (state is NoDataUserState) {
              _refreshController.loadNoData();
              setState(() {});
            }
          },
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            header: const WaterDropHeader(),
            footer: CustomFooter(
              builder: (context, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("Pull up to load more");
                } else if (mode == LoadStatus.loading) {
                  body = const CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Unable to load more");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("Release to load more.");
                } else {
                  body = const SizedBox();
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: ListView.builder(
                itemCount: users.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.only(top: 15),
                itemBuilder: (context, index) => UserTile(user: users[index])),
          ),
        ),
      ),
    );
  }
}

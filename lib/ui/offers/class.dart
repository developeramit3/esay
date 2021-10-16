// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:esay/widgets/offer_secret_icons.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// // class CustomIndicatorConfig {
// //   final IndicatorBuilder builder;
// //
// //   const CustomIndicatorConfig({
// //   this.builder,
// //   });
// // }
//
// class Reff extends StatefulWidget {
//   const Reff({Key key}) : super(key: key);
//
//   @override
//   _ReffState createState() => _ReffState();
// }
//
// class _ReffState extends State<Reff> {
//   List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//   void _onRefresh() async {
//     // monitor network fetch
//     await Future.delayed(Duration(milliseconds: 1000));
//     // if failed,use refreshFailed()
//     _refreshController.refreshCompleted();
//   }
//
//   void _onLoading() async {
//     // monitor network fetch
//     await Future.delayed(Duration(milliseconds: 1000));
//     // if failed,use loadFailed(),if no data return,use LoadNodata()
//     items.add((items.length + 1).toString());
//     if (mounted) setState(() {});
//     _refreshController.loadComplete();
//   }
//
//   ScrollController scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.eighteen_mp), onPressed: () => _onLoading),
//       ),
//       body: SmartRefresher(
//         enablePullDown: true,
//         enablePullUp: true,
//         header: TwoLevelHeader(
//           decoration: BoxDecoration(color: Colors.white),
//           refreshingIcon: offerSecretIcons(),
//           idleIcon: offerSecretIcons(),
//           canTwoLevelIcon: offerSecretIcons(),
//           displayAlignment: TwoLevelDisplayAlignment.fromCenter,
//           canTwoLevelText: '',
//           height: 200,
//           releaseIcon: offerSecretIcons(),
//           completeText: '',
//           idleText: '',
//           refreshingText: '',
//           releaseText: '',
//           twoLevelWidget: offerSecretIcons(),
//         ),
//         footer: CustomFooter(
//           builder: (BuildContext context, LoadStatus mode) {
//             Widget body;
//             if (mode == LoadStatus.idle) {
//               body = Text("pull up load");
//             } else if (mode == LoadStatus.loading) {
//               body = CupertinoActivityIndicator();
//             } else if (mode == LoadStatus.failed) {
//               body = Text("Load Failed!Click retry!");
//             } else if (mode == LoadStatus.canLoading) {
//               body = Text("release to load more");
//             } else {
//               body = Text("No more Data");
//             }
//             return Container(
//               height: 55.0,
//               child: Center(child: body),
//             );
//           },
//         ),
//         controller: _refreshController,
//         onLoading: _onLoading,
//         onRefresh: _onRefresh,
//         child: ListView.builder(
//           itemBuilder: (c, i) =>
//               Card(color: Colors.red, child: Center(child: Text(items[i]))),
//           itemExtent: 100.0,
//           itemCount: items.length,
//         ),
//       ),
//     );
//   }
// }
// onRefresh: () {
// Provider.of<AccountProvider>(context, listen: false)
//     .offerScr
// ? OnRefresh.onRef(context, _controller, () {
// _onRefresh(context);
// }, controllerTopCenter)
//     : _onRefresh(context);
// },

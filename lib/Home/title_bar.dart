// !提示命名必须是小写加_，而且必须有_………………
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatefulWidget {
  String title;
  TitleBar({Key? key, required this.title});
  // const TitleBar({super.key});
  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    // !注意上下两个super.initState的顺序不同……
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Row(
        //   children: [
        //     Expanded(
        //         child: DragToMoveArea(
        //       child: Text(widget.title),
        //     )),
        //     // Positioned(
        //     //     child:
        //     Row(
        //       children: [
        //         IconButton(
        //           // !解决了radius后还是用回IconButton，因为另外的OutlineButton即使设置了padding依然过长，IconButton的样式就挺合适
        //           iconSize: 20,
        //           icon: const Icon(Icons.remove),
        //           alignment: Alignment.center,
        //           splashRadius: 1,
        //           // !必须>0……
        //           tooltip: '最小化',

        //           // ~~尝试OutlinedButton，甚至无法使用style咳咳你下面用着了……
        //           // child: Icon(Icons.remove, size: 20,color: Colors.black,),

        //           // style: ButtonStyle(
        //           //   splashFactory: NoSplash.splashFactory,
        //           //   // shape: MaterialStateProperty.all(CircleBorder()),
        //           //   // shape: Rect.fromCenter(center: 0, width: 0, height: 0)
        //           // ),

        //           // style: RoundedRectangleBorder(
        //           //     borderRadius: BorderRadius.circular(0)
        //           // ),
        //           // color: WindowCaptionButton.close(),

        //           style: OutlinedButton.styleFrom(
        //               splashFactory: NoSplash.splashFactory,
        //               padding: const EdgeInsets.all(5),
        //               shape: const RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.zero)),
        //           onPressed: () {
        //             windowManager.minimize();
        //           },
        //         ),
        //         // ),
        //         IconButton(
        //           iconSize: 20,
        //           icon: const Icon(Icons.square_outlined),
        //           alignment: Alignment.center,
        //           splashRadius: 1,
        //           // !必须>0……
        //           tooltip: '最大化',
        //           style: OutlinedButton.styleFrom(
        //               splashFactory: NoSplash.splashFactory,
        //               padding: const EdgeInsets.all(5),
        //               shape: const RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.zero)),
        //           onPressed: () {
        //             windowManager.maximize();
        //           },
        //         ),
        //         IconButton(
        //           iconSize: 20,
        //           icon: const Icon(Icons.close),
        //           alignment: Alignment.center,
        //           hoverColor: Colors.red[400],
        //           splashRadius: 1,
        //           // !必须>0……
        //           tooltip: '关闭',
        //           style: OutlinedButton.styleFrom(
        //               splashFactory: NoSplash.splashFactory,
        //               padding: const EdgeInsets.all(5),
        //               shape: const RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.zero)),
        //           onPressed: () {
        //             windowManager.close();
        //           },
        //         ),
        //       ],
        //     )
        //     // ))
        //   ],
        //   // ),
        // );
        DragToMoveArea(
            child: AppBar(
                // !还是得用AppBar……不然OpenContainer显示不了BackBtn……
                // !就算返回AppBar也无法赋给scaffold的appBar属性……The argument type 'TitleBar' can't be assigned to the parameter type 'PreferredSizeWidget?'.
                title: Text(widget.title),
                // !没办法还是只能在AppBar外面加Drag……
                // title: DragToMoveArea(child: Expanded(child: Text(widget.title))),
                centerTitle: true,
                elevation: 0,
                toolbarHeight: 30,
                // flexibleSpace:
                // DragToMoveArea(child: Container(child: Text(widget.title))),
                // !这里DragToMoveArea似乎不是一个Area而是定位到了第一个实际Widge，也就是Text，就算前面加了Center，Expend都只有Text部分能拖动
                backgroundColor: Colors.grey[200],
                actions: <Widget>[
          // Material(borderRadius: const BorderRadius.all(Radius.zero),child:
          TitleBarBtn(
              icon: Icons.remove,
              tooltip: '最小化',
              onPressed: () {
                windowManager.minimize();
              }),
          TitleBarBtn(
              icon: Icons.square_outlined,
              tooltip: '最大化',
              onPressed: () {
                windowManager.maximize();
              }),
          TitleBarBtn(
              icon: Icons.close,
              tooltip: '关闭',
              hoverColor: Colors.red[400],
              onPressed: () {
                windowManager.close();
              }),
        ]));
  }
}

class TitleBarBtn extends StatelessWidget {
  late IconData icon;
  late String tooltip;
  late VoidCallback? onPressed;
  late Color hoverColor;
  TitleBarBtn(
      {required this.icon,
      required this.tooltip,
      required this.onPressed,
      Color? hoverColor})
      : hoverColor = hoverColor ?? Colors.grey[300]!;
  // !md混乱……下面这个就是死都不行……
  // this.hoverColor = const Colors.grey[200]!});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      icon: Icon(icon),
      alignment: Alignment.center,
      hoverColor: hoverColor,
      splashRadius: 1,
      // !必须>0……
      tooltip: tooltip,
      style: OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.all(5),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      onPressed: onPressed,
    );
  }
}

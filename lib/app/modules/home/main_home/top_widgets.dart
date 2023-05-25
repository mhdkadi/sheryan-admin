part of 'home_view.dart';

Widget appBar(BuildContext context, MainHomeController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      SizedBox(
        width: 50,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            ZoomDrawer.of(context)?.open();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
            padding: EdgeInsets.zero,
          ),
          child: const Icon(
            Icons.dehaze,
            color: AppColors.font,
          ),
        ),
      ),
      const SizedBox(),
    ],
  );
}

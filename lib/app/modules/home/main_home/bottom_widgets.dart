part of 'home_view.dart';

Widget orderWidget({
  required BuildContext context,
}) {
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();
  final form = FormGroup({
    "pathologicalCase": FormControl<String>(
      validators: [
        Validators.maxLength(40),
      ],
    ),
    "hospitalType": FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(40),
      ],
      value: "حكومي",
    ),
  });
  return DraggableScrollableSheet(
    controller: draggableScrollableController,
    maxChildSize: 0.39,
    minChildSize: 0.04,
    initialChildSize: 0.39,
    builder: (context, scrollController) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: ScreenSizer(
          builder: (customSize) {
            return Container(
              color: AppColors.background,
              width: double.infinity,
              height: 200,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                controller: scrollController,
                child: StateBuilder<MainHomeController>(
                    id: "orderWidget",
                    disableState: true,
                    initialWidgetState: WidgetState.loaded,
                    builder: (widgetState, controller) {
                      return ReactiveForm(
                        formGroup: form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.font,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: AppColors.font,
                                ),
                              ],
                            ),
                            StateBuilder<MainHomeController>(
                              id: "pathologicalCases",
                              disableState: true,
                              initialWidgetState: WidgetState.loading,
                              builder: (fieldState, controller) {
                                return StateHeaderDropdownField(
                                  widgetState: widgetState,
                                  fieldState: fieldState,
                                  formControlName: "pathologicalCase",
                                  hintText: "إختر الحالة المرضيّة (إختياري)",
                                  items: controller.pathologicalCases
                                      .map((e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.name),
                                          ))
                                      .toList(),
                                  header: "الحالة المرضيّة",
                                  onRetry: controller.getPathologicalCases,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            StateBuilder<MainHomeController>(
                              id: "hospitalTypes",
                              disableState: true,
                              initialWidgetState: WidgetState.loaded,
                              builder: (fieldState, controller) {
                                return StateHeaderDropdownField(
                                  widgetState: widgetState,
                                  fieldState: fieldState,
                                  formControlName: "hospitalType",
                                  hintText: "إختر نوع المشفى",
                                  items: ["حكومي", "خاص"]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  header: "نوع المشفى",
                                  onRetry: controller.getPathologicalCases,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedStateButton(
                                widgetState: widgetState,
                                onPressed: () {
                                  if (form.valid) {
                                    FocusScope.of(context).unfocus();
                                    controller.order(
                                      pathologicalCase: form
                                          .value["pathologicalCase"]
                                          .toString(),
                                    );
                                  } else {
                                    form.markAllAsTouched();
                                  }
                                },
                                child: const Text(
                                  "طلب إسعاف",
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            );
          },
        ),
      );
    },
  );
}

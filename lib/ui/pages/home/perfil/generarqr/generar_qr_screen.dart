import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/widget/annotate_region_widget.dart';
import 'package:upla/ui/pages/home/widget/app_bar_ca_widget.dart';

class GenerarQrScreen extends StatefulWidget {
  static String id = "generar_qr_page";

  const GenerarQrScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GenerarQrScreen> createState() => _GenerarQrState();
}

class _GenerarQrState extends State<GenerarQrScreen> {
  AppProvider? appProvider;

  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() async {
    super.dispose();
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBarCaWidget(title: "QR de Identificación").build(context),
      body: AnnotateRegionWidget(children: _main(size)).build(context),
    );
  }

  Widget _main(Size size) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: QrImageView(
                data: appProvider!.session.docNumId!,
                version: QrVersions.auto,
                size: 250.0,
                gapless: false,
                // embeddedImage: const AssetImage('assets/icons/logo.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

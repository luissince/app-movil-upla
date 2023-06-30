import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/financiero/estadocuenta/estado_deuda_screen.dart';
import 'package:upla/ui/pages/home/financiero/pagorealizados/pagos_realizados_screen.dart';
import 'package:upla/ui/pages/home/financiero/realizarpagartramite/realizar_pago_tramite_screen.dart';
import 'package:upla/ui/pages/home/widget/button_home.dart';
import 'package:upla/ui/pages/home/widget/headboard_home.dart';
import 'package:upla/ui/pages/home/widget/title_home.dart';

import '../widget/background_home.dart';

class FinancieroScreen extends StatefulWidget {
  const FinancieroScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FinancieroScreen> createState() => _FinancieroScreenState();
}

class _FinancieroScreenState extends State<FinancieroScreen>
    with AutomaticKeepAliveClientMixin {
  AppProvider? appProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;

    appProvider = Provider.of<AppProvider>(context);

    return BackgroundHome(
      onRefresh: () async {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /**
           * 
           */
          HeadBoardHome(
            size: size,
            docNumId: appProvider!.session.docNumId!,
            bottom: 10,
          ),

          /**
           * 
           */
          TitleHome(
            title: "Universidad Peruana Los Andes",
            subTitle: "FINANCIERO",
            content:
                'A continuación tiene las opciones de revisar su "Estado de Deuda", "Realizar Pagos y Tramites".',
          ),

          /**
           * 
           */
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: [
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      EstadoDeudaScreen.id,
                    );
                  },
                  title: "Estado de Deuda",
                  icon: Icons.attach_money,
                ),
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RealizarPagoTramiteScreen.id,
                    );
                  },
                  title: "Realizar Pagos y Tramites",
                  icon: Icons.payments,
                ),
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PagosRealizadosScreen.id,
                    );
                  },
                  title: "Pagos realizados",
                  icon: Icons.library_books,
                ),
                /**
                 * 
                 */
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upla/provider/app_provider.dart';
import 'package:upla/ui/pages/home/academico/constanciamatricula/constancia_matricula_screen.dart';
import 'package:upla/ui/pages/home/academico/encuesta/encuenta_screen.dart';
import 'package:upla/ui/pages/home/academico/mallacurricular/malla_curricular_screen.dart';
import 'package:upla/ui/pages/home/academico/progresocurricular/progreso_curricular_screen.dart';
import 'package:upla/ui/pages/home/academico/registrarmatricula/registrar_matricula_screen.dart';
import 'package:upla/ui/pages/home/academico/visualizarnota/visualizar_nota_screen.dart';
import 'package:upla/ui/pages/home/widget/button_home.dart';
import 'package:upla/ui/pages/home/widget/headboard_home.dart';
import 'package:upla/ui/pages/home/widget/title_home.dart';

import '../widget/background_home.dart';

class AcademicoScreen extends StatefulWidget {
  const AcademicoScreen({Key? key}) : super(key: key);

  @override
  State<AcademicoScreen> createState() => _AcademicoScreenState();
}

class _AcademicoScreenState extends State<AcademicoScreen>
    with AutomaticKeepAliveClientMixin {
  AppProvider? appProvider;


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
            subTitle: "ACADÉMICO",
            content:
                'A continuación tiene las opciones de revisar su "Horario de Clases con su Constancia de Matrícula", "Visualización de Notas", "Malla Curricular", "Progreso Curricular", "Encuesta" y "Mátricula".',
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
                      ConstanciaMatriculaScreen.id,
                    );
                  },
                  title: "Constancia de Matrícula",
                  icon: Icons.calendar_today,
                ),
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      VisualizarNotaScreen.id,
                    );
                  },
                  title: "Visualización de Notas",
                  icon: Icons.notes,
                ),
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      MallaCurricularScreen.id,
                    );
                  },
                  title: "Malla Curricular",
                  icon: Icons.list_alt,
                ),
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ProgresoCurrillarScreen.id,
                    );
                  },
                  title: "Progreso Curricular",
                  icon: Icons.query_stats,
                ),
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      EncuetaScreen.id,
                    );
                  },
                  title: "Encuesta",
                  icon: Icons.rule,
                ),
                /**
                 * 
                 */
                ButtonHome(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RegistrarMatriculaScreen.id,
                    );
                  },
                  title: "Matricula",
                  icon: Icons.history_edu,
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

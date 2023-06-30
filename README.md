# APP MOVIL UPLA

<img src="assets/images/logo_text.svg" alt="Imagen go" width="200" />

**Aplicación movil de la universidad peruana los andes**

## Inicio

Este proyecto está desarrollado en Flutter.
<img src="assets/images/flutter.svg" alt="Imagen go" width="50" />

A continuación, se mencionan algunos recursos necesarios para iniciar con este proyecto:

- [Flutter](https://flutter.dev/): Flutter es un SDK de código fuente abierto de desarrollo de aplicaciones móviles creado por Google. Suele usarse para desarrollar interfaces de usuario para aplicaciones en Android, iOS y Web así como método primario para crear aplicaciones para Google Fuchsia.​
- [Dart](https://dart.dev/): Dart es un lenguaje de programación de código abierto, desarrollado por Google. Fue revelado en la conferencia goto; en Aarhus, Dinamarca el 10 de octubre de 2011.​
- [Visual Studio Code](https://code.visualstudio.com/): Editor de código para diversos lenguajes de programación.
- [Git](https://git-scm.com/): Sistema de control de versiones.
- [GitHub](https://github.com/): Plataforma de alojamiento de proyectos.
- [FireBase](https://firebase.google.com/?hl=es): Firebase es una plataforma para el desarrollo de aplicaciones web y aplicaciones móviles lanzada en 2011 y adquirida por Google en 2014.
## Instalación

Siga los pasos para iniciar el desarrollo:

1. Clona el proyecto o agrague el ssh al repositorio para contribuir en nuevos cambios [Git Hub - UPLA APP MOVIL](https://github.com/luissince/app-movil-upla)

    1.1. Agregue por ssh para la integración

    #Code

        /** 
        ** Para el proceso de integración **
        **/

        // ejecute en su consola cmd, bash, git los siguientes comandos
        
        // Generar tu clave ssh para poder contribuir al proyecto
        ssh-keygen -t rsa -b 4096 -C "tu email"

        // Configuración global del nombre
        git config --global user.name "John Doe"

        // Configuración global del email
        git config --global user.email johndoe@example.com

        // crea una carpeta
        mkdir app-movil-upla

        // moverse a la carpeta
        cd app-movil-upla
        
        // comando que inicia git
        git init

        // comando que agrega la referencia de la rama
        git remote add origin git@github.com:luissince/app-movil-upla.git
    
        // comando que descarga los archivos al working directory
        git fetch origin master
        
        // comando que une los cambios al staging area
        git merge origin/master

    2.2 Clonar

        #code

        /** 
        ** Para el proceso de clonación **
        **/

        // Clonar al proyecto
        git clone https://github.com/luissince/app-movil-upla.git

2. Instale flutter 

    #Code

        /**
        ** Siga los pasos de instalación de la página oficinal
        **/
        
        // Página oficial
        https://flutter.dev/

3. Ejecute en la carpeta la clonada **flutter pub get** para descargar las dependencias del proyecto

    #Code

        flutter pub get

4. Configure las rutas de apis lib/constants.dart

    #code

        // Ruta para guardar los archivos logs
        apiUrl=

        // Dirección IP o nombre del servidor
        apiUplaEduPe=
        

6. Ejecute **flutter run** para iniciar ejecutar el servicio   

    #Code

        flutter run

7. Ejecute **flutter build apk** para generar un apk que puede ser distribuido entre telefonos con android  

    #Code

        flutter build apk

7. Ejecute **flutter build appbuild** para crear una nueva distribución para su publicación   

    #Code

        flutter build appbuild

8. Cuando se realiza nuevos cambios se tiene que registrar y publicar en la rama correspondiente

    #Code

        // Comando que agrega los cambios realizados en los archivos al área de preparación.
        git add .

        // Comando que agrega los cambios al área de preparación para guardar los cambios en el historial de repositorio.
        git commit -m "Informar cambios"

        // Comando que envía los cambios al repositorio remoto.
        git push origin master


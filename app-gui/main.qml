import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {


    height: 900
    width: 500
    visible: true
    title: "Heatify"

    Loader {
        id: pageLoader
        source: "Controlls.qml"

    /*    transform : [
          Rotation {
                angle: 90
            },

            Translate {
                x: pageLoader.height
            }
        ]
*/
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/

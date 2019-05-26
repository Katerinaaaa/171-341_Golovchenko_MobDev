//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1


Page{ //ЛР 7 Шифрование

    header:Rectangle{ // заголовок

         ToolBar {
            RowLayout {
                spacing: 20
                anchors.fill: parent

                ToolButton {
                    contentItem: Image {
                        source: "qrc:/resources/icons8-menu-48.png"
                    }
                    onClicked: drawer.open()
                }
            }
        }

         Draw{
             id: drawer

         }

        color: "#003580"
        height: 60

        Label{ // заголовок странички
            x: parent.height
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.7 - Шифрование</span>'
            font.weight: Font.Bold
            font.family: "Consolas"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    ColumnLayout{
        anchors.fill: parent
        Layout.alignment: Qt.AlignCenter


        TextField{
            id: key
            placeholderText: "Ключ шифрования"
            Layout.alignment: Qt.AlignCenter
            background:
                Rectangle{
                id: lg1
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "transparent"
                    }
        }
        Button{
                text: "Зашифровать"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                if(key.text == "" ){
                  key.placeholderText= "ВВЕДИТЕ КЛЮЧ"
                  key.placeholderTextColor = "red"
                   return
                }
                    encryptIt(key.text);
                }
        }

        Button{
                text: "Расшифровать"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                if(key.text == "" ){
                  key.placeholderText= "ВВЕДИТЕ КЛЮЧ"
                  key.placeholderTextColor = "red"
                   return
                }
                    decryptIt(key.text);
                }
        }
    }

}

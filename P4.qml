//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1

Page{ // ЛР 4 Запросы
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
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.4 - Запросы</span>'
            font.weight: Font.Bold
            font.family: "Consolas"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10
        RowLayout{
            Layout.alignment: Qt.AlignCenter
            Button{
                text: "Посмотреть код страницы и узнать температуру по ощущениям"
                onClicked: {
                    _myV.getPageInfo();
                }
            }
//                    Button{
//                        text: "Узнать температуру по ощущениям"
//                        onClicked: {
//                            _myV.onPageInfo();
//                        }
//                    }
        }
        ScrollView{
            focusPolicy: Qt.WheelFocus // прокручивание колесиком
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 0.6 * window.height
            Layout.preferredWidth: 0.8 * window.width

            TextArea{
                id: text_area
                objectName: "text_area"
                font.pixelSize: 12
                color: "white"
                wrapMode: Text.WrapAnywhere
            }
        }

        RowLayout{
            Label {
                id: lbl_1
                Layout.alignment: Qt.AlignCenter
                font.pixelSize: 20
                font.bold: true
                text: "Температура в Москве (по ощущениям):"
            }

            TextEdit{
                id: text_edit
                objectName: "text_edit"
                readOnly: true
                color: "white"
                font.pointSize: 9
            }
        }
    }
}

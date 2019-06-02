//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.3


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
        //Layout.alignment: Qt.AlignCenter

        Button{
            text: "Выбрать файл для шифрования"
            Layout.alignment: Qt.AlignCenter
            onClicked: {
                fileDialog.open();
            }
        }

        FileDialog {
            id: fileDialog
            title: "Выберите файл, который вы хотите зашифровать"
            folder: shortcuts.home
            nameFilters: [ "Text files (*.txt)", "HTML files (*.html *.htm)", "Documents (*.doc *.docs)", "All files (*.txt *.html *.htm *.doc *.docs)" ]
            onAccepted: {
                console.log("Вы выбрали: " + fileDialog.fileUrls)
                file.text += fileDialog.fileUrls;
                //_myS.getFileName(file.text);
            }
            onRejected: {
                console.log("Закрыто")
            }
            //Component.onCompleted: visible = true
        }

        Label{
            id: file
            text: ""
            visible: false
        }


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
        RowLayout{
            Layout.alignment: Qt.AlignCenter
            Button{
                    text: "Зашифровать"
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                    if(key.text == "" ){
                      key.placeholderText= "ВВЕДИТЕ КЛЮЧ"
                      key.placeholderTextColor = "red"
                       return
                    }
                        _myS.encryptIt(key.text, file.text);
                    }
            }

            Button{
                    text: "Расшифровать"
                    Layout.alignment: Qt.AlignCenter
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
        ScrollView{
            focusPolicy: Qt.WheelFocus // прокручивание колесиком
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 0.6 * window.height
            Layout.preferredWidth: 0.8 * window.width

            TextArea{
                id: our_text
                objectName: "our_text"
                font.pixelSize: 12
                color: "white"
                wrapMode: Text.WrapAnywhere
            }
        }
    }

}

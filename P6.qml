//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1


Page{ // ЛР 6 Список друзей
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
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.6 - Список друзей</span>'
            font.weight: Font.Bold
            font.family: "Consolas"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    ScrollView{
        anchors.fill: parent
        Image{
            id: background
            source: "qrc:/resources/nebo.jpg"
            width: parent.width
            height: parent.height*2
            sourceSize.width: -1
            fillMode: Image.TileHorizontally
            y: -grid.contentY / 3 | -list.contentY / 3
        }


    ColumnLayout{

        anchors.fill: parent
        Layout.alignment: Qt.AlignHCenter

    RowLayout{
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

        RadioButton{ // выбор, что отображается на страничке
            id: rad_1 // id
            //Layout.alignment: Qt.AlignLeft
            text: "Столбцы" // подпись
            checked: true // выбран по умолчанию
            onCheckedChanged: // если сменен выбор
                if(rad_1.checked === true){ // если выбран rad1
                    grid.visible = true
                    list.visible = false
                }
        }
        RadioButton{ // выбор, что отображается на страничке
            id: rad_2 // id
            //Layout.alignment: Qt.AlignRight
            text: "Строки" // подпись
            checked: false
            onCheckedChanged: // если вменен выбор
                if(rad_2.checked === true){ // если выбран rad2
                    list.visible = true // видео не отображается
                    grid.visible = false // слайдер не отображается
                }
        }
    }


        GridView{
            id: grid
            visible: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            enabled: true
            cellHeight: 150
            cellWidth: 300
            model: friends_model

            //spacing: 10

            delegate: Rectangle{
                color: "white"
                width: 300
                height: 150
                border.color: "pink"
                Layout.margins: 10
                GridLayout{
                    anchors.fill: parent
                    columns: 3
                    rows: 3
                    //Layout.margins: 20
                    Image{
                        source: photo
                        Layout.column: 0
                        Layout.row: 0
                        Layout.rowSpan: 3
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        Layout.margins: 5
                        fillMode: Image.PreserveAspectFit
                    }
                    Label{ // имя
                        color: "black"
                        text: name
                        Layout.column: 1
                        Layout.row: 1
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        //Layout.margins: 20
                    }
                    Label{ // фамилия
                        color: "black"
                        text: surname
                        Layout.column: 1
                        Layout.row: 2
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        //Layout.margins: 20
                    }
                    Label{ // ID
                        color: "black"
                        text: "ID" + friend_id
                        Layout.column: 1
                        Layout.row: 3
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        //Layout.margins: 20
                    }
                }
            }
        }

        ListView{
            id: list
            visible: false
            Layout.fillHeight: true
            Layout.fillWidth: true
            enabled: true
            model: friends_model
            spacing: 30

            delegate: Rectangle{
                color: "white"
                width: 600
                height: 100
                border.color: "pink"
                Layout.margins: 10
                GridLayout{
                    anchors.fill: parent
                    columns: 3
                    rows: 3
                    //Layout.margins: 20
                    Image{
                        source: photo
                        Layout.column: 0
                        Layout.row: 0
                        Layout.rowSpan: 3
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        Layout.margins: 5
                        fillMode: Image.PreserveAspectFit
                    }
                    Label{ // имя
                        color: "black"
                        text: name
                        Layout.column: 1
                        Layout.row: 1
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        //Layout.margins: 20
                    }
                    Label{ // фамилия
                        color: "black"
                        text: surname
                        Layout.column: 2
                        Layout.row: 1
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        //Layout.margins: 20
                    }
                    Label{ // ID
                        color: "black"
                        text: "ID" + friend_id
                        Layout.column: 3
                        Layout.row: 1
                        Layout.fillHeight: true
                        Layout.preferredWidth: 100
                        //Layout.margins: 20
                    }
                }
            }
        }
    }
    }
}

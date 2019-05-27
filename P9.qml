import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1


Page { // ЛР 9

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
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.9 - Сообщения</span>'
            font.weight: Font.Bold
            font.family: "Consolas"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
        }
    }

        Image{
            id: background
            source: "qrc:/resources/wonder.jpg"
            width: parent.width
            height: parent.height*2
            sourceSize.width: -1
            fillMode: Image.PreserveAspectCrop
            y: -soob.contentY / 3
        }

ColumnLayout{
    anchors.fill: parent
    Layout.alignment: Qt.AlignCenter
    ListView{ // список сообщений
        id: soob
        anchors.fill: parent
        Layout.fillHeight: true
        Layout.preferredWidth: 150
        enabled: true
        model: message_model
        //focus: true
        spacing: 30
        delegate: Rectangle{
            radius: 5
            width: 150
            height: 150
            //spacing: 5
            //color: "lightblue"
            anchors.right:
                (sender === "self")
                ?parent.right
                :"*"
            anchors.left:
                (!sender === "self")
                ?parent.left
                :"*"
            GridLayout{
                anchors.fill: parent
                columns: 1
                rows: 3
                Image{
                    source: photo
                    //Layout.fillWidth: true
                    Layout.preferredHeight: 150
                    Layout.preferredWidth: 150
                    Layout.row: 0
                    Layout.column: 0
                    Layout.rowSpan: 3
                }
                Label{
                    anchors.fill: parent
                    text: first
                    Layout.column: 1
                    Layout.row: 3
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                    color: "#E667AF"
                    font.weight: Font.Bold
                }
            }
        }
    }
    ListModel{
        id: message_model
        ListElement{
            first: "Message1"
            Type: "incoming"
            photo: "qrc:/resources/blue.jpg"
            sender: "self"
            datetime: "17:10:00 27.05.2019"
        }
        ListElement{
            first: "Message2"
            Type: "outcoming"
            photo: "qrc:/resources/grey.jpg"
            sender: "inkognito"
            datetime: "17:10:00 27.05.2019"
        }
        ListElement{
            first: "Message3"
            Type: "incoming"
            photo: "qrc:/resources/blue.jpg"
            sender: "self"
            datetime: "17:10:00 27.05.2019"
        }
        ListElement{
            first: "Message4"
            Type: "outcoming"
            photo: "qrc:/resources/grey.jpg"
            sender: "inkognito"
            datetime: "17:10:00 27.05.2019"
        }

    }
    RowLayout{
        Layout.preferredHeight: 50
        Layout.fillWidth: true

        TextField{
            id: edMess
            Layout.fillWidth: true
            color: "black"
            placeholderText: "Ваше сообщение..."
            placeholderTextColor: "black"
        }

        Button{
            Layout.preferredHeight: 50
            Layout.preferredWidth: 100
            text: "Send"
            onClicked: {
                sendMess(edMess.text);
            }

        }
    }
}
   }

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
    height: parent.height*1.5
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
        model: chat_model
        delegate: Rectangle{
            id: m
            width: 150
            height: 150
            color: "transparent"
            anchors.right:
                (sender === "Kate")
                ?parent.right
                :"*"
            anchors.left:
                (!sender === "Kate")
                ?parent.left
                :"*"
            GridLayout{
                anchors.fill: parent
                columns: 1
                rows: 6
                Image{
                    id: im_mess
                    source: (sender === "PikVik")?"qrc:/resources/pink.png":"qrc:/resources/green.png"
                    Layout.preferredHeight: 150
                    Layout.preferredWidth: 150
                    Layout.row: 0
                    Layout.column: 0
                    Layout.rowSpan: 6
                    opacity: 0.7
                }
//                Label{
//                    text: sender
//                    Layout.column: 0
//                    Layout.row: 1
//                    Layout.preferredHeight: 10
//                    Layout.preferredWidth: 100
//                    Layout.alignment: Qt.AlignCenter
//                    font.pixelSize: 12
//                    color: "white"
//                    font.weight: Font.Bold
//                }
                Label{
                    text: message
                    Layout.column: 0
                    Layout.row: 1
                    Layout.preferredHeight: 10
                    Layout.preferredWidth: 100
                    Layout.alignment: Qt.AlignCenter
                    font.pixelSize: 15
                    color: "white"
                    font.weight: Font.Bold
                }
                Label{
                    text: time
                    Layout.column: 0
                    Layout.row: 4
                    Layout.preferredHeight: 10
                    Layout.preferredWidth: 100
                    Layout.alignment:Qt.AlignRight
                    font.pixelSize: 11
                    color: "#081272"
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
            sender: "self"
            name: "you"
            time: "17:10:00"
        }
        ListElement{
            first: "Message2"
            Type: "outcoming"
            sender: "inkognito"
            name: "Sara"
            time: "17:10:00"
        }
        ListElement{
            first: "Message3"
            Type: "incoming"
            sender: "self"
            name: "you"
            time: "17:10:00"
        }
        ListElement{
            first: "Message4"
            Type: "outcoming"
            sender: "inkognito"
            name: "Sara"
            time: "17:10:00"
        }
    }

    Rectangle{
        radius: 5
        Layout.fillWidth: true
        height: 50
        border.color: "white"
        color: "#9db6f4"
    RowLayout{
        Layout.preferredHeight: 50
        Layout.fillWidth: true

        Rectangle{
            color: "transparent"
            height: 40
            width: 20
        }

            TextField{
                id: edMess
                Layout.fillWidth: true
                color: "black"
                placeholderText: "  Ваше сообщение..."
                placeholderTextColor: "black"
                Layout.preferredWidth: 480
                Layout.alignment: Qt.AlignLeft
                background: Rectangle{
                    radius: 10
                    Layout.fillWidth: true
                    height: 40
                    border.color: "#872F6A"
                    color: "white"
                }
            }

            Button{
                id: sent
                Layout.alignment: Qt.AlignRight
                Layout.preferredHeight: 50
                Layout.preferredWidth: 50
                flat: true
                onPressed: {
                    pushanimation.start();
                    sendMess(edMess.text);
                    //processMessage(edMess.text);                    
                    edMess.text = ""
                }
                background: Image{
                    source: "qrc:/resources/sent.png"
                    sourceSize.height: 50
                    sourceSize.width: 50
                }
            }
//            Button{
//                id: renew
//                Layout.alignment: Qt.AlignRight
//                Layout.preferredHeight: 50
//                Layout.preferredWidth: 50
//                flat: true
//                text: "Обновить"
//                onPressed: {
//                    pushanimation1.start();
//                    //sendMess(edMess.text);
//                    processMessage(edMess.text);
//                    //edMess.text = ""
//                }
////                background: Image{
////                    source: "qrc:/resources/sent.png"
////                    sourceSize.height: 50
////                    sourceSize.width: 50
////                }
//            }
        }
    }
    ScaleAnimator{ // анимация вдавливания для кнопки
        id: pushanimation
        target: sent
        from: 1.0
        to: 0.9
        duration: 200
    }
//    ScaleAnimator{ // анимация вдавливания для кнопки
//        id: pushanimation1
//        target: renew
//        from: 1.0
//        to: 0.9
//        duration: 200
//    }
}
}

import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1


Page { // ЛР 8 Базы данных

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
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.8 - Базы данных</span>'
            font.weight: Font.Bold
            font.family: "Consolas"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    ColumnLayout{
        Layout.alignment: Qt.AlignHCenter
            TableView {
                id: tableView
                Layout.preferredWidth: 600
                Layout.preferredHeight: 300

                TableViewColumn {
                    role: "friend_id"
                    title: "Friend_id"
                    width: 100
                }
                TableViewColumn {
                    role: "name"
                    title: "FriendName"
                    width: 150
                }
                TableViewColumn {
                    role: "surname"
                    title: "FriendSurname"
                    width: 150
                }
                TableViewColumn {
                    role: "photo"
                    title: "FriendPhoto"
                }

                //model: friends_model
            }

            Button{
                text: "Показать друзей"
                onClicked: {
                    db_read();
                    tableView.model = friends_model;
                }

            }
        }
}

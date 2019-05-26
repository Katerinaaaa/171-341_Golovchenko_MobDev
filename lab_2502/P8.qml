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
        Layout.alignment: Qt.AlignCenter
        Button{
            text: "Показать друзей"
            onClicked: {
                db_write();
                //tableView.model = friends_model;
            }

        }
            TableView {
                id: tableView
                Layout.preferredWidth: 600
                Layout.preferredHeight: 500

                TableViewColumn {
                    role: "Friend_id"
                    title: "Friend_id"
                }
                TableViewColumn {
                    role: "FriendName"
                    title: "FriendName"
                }
                TableViewColumn {
                    role: "FriendSurname"
                    title: "FriendSurname"
                }
                TableViewColumn {
                    role: "FriendPhoto"
                    title: "FriendPhoto"
                }

                //model: friends_model
            }
        }
}

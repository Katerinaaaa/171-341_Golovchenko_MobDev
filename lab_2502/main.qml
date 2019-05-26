//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1
import QtWebView 1.1


ApplicationWindow {
    id: window
    visible: true
    width: 600 // ширина окна
    height: 800 // высота окна
    title: qsTr("Tabs")
    signal onAuth(string login, string password);
    signal restRequest();
    signal encryptIt(string key);
    signal decryptIt(string key);
    signal db_read();
    //signal success();

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        P1{  // ЛР 1. GUI

        }

        P2{ // ЛР 2. Запись и воспроизведение мультимедиа-файлов

        }

        P3{ //ЛР 3. Взаимодействие кода C++ и QML

        }

        P4{ // ЛР 4

        }

        P5{ // ЛР 5

        }

        P6{ // ЛР 6

        }

        P7{ //ЛР 7

        }

        P8{ //ЛР 8

        }


    }

    footer: TabBar { // нижнее меню
        id: tabBar
        currentIndex: swipeView.currentIndex

        // странички нижнего меню

        TabButton {
            text: qsTr("ЛР 1")
        }
        TabButton {
            text: qsTr("ЛР 2")
        }
        TabButton {
            text: qsTr("ЛР 3")
        }
        TabButton {
            text: qsTr("ЛР 4")
        }
        TabButton {
            text: qsTr("ЛР 5")
        }
        TabButton {
            text: qsTr("ЛР 6")
        }
        TabButton {
            text: qsTr("ЛР 7")
        }
        TabButton {
            text: qsTr("ЛР 8")
        }
    }
}


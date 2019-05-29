//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1
import QtWebEngine 1.8
import QtWebView 1.1
import QtWebEngine 1.8

Page{ // ЛР 5 Авторизация в ВК
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
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.5 - Авторизация в вк</span>'
            font.weight: Font.Bold
            font.family: "Consolas"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
        }
    }

ColumnLayout{
    anchors.fill: parent

    WebView{
        id: webView
        url: "https://oauth.vk.com/authorize?client_id=6993642&redirect_uri=http://oauth.vk.com/blank.html&display=mobile&scope=friends&response_type=token&v=5.92&"
        Layout.preferredWidth: 600
        Layout.preferredHeight: 500
        Layout.alignment: Qt.AlignCenter
        //scale: 0.5
        //smooth: false
        onLoadingChanged: {
            final_ac.text = webView.url
        }
    }
    Button{
        Layout.alignment: Qt.AlignCenter
        text: "Вывести друзей"
        onClicked: {
            success(final_ac.text);
            webView.goBack();
            restRequest();
        }
    }
    Label{
        id: final_ac
        visible: false
    }

}

//    ColumnLayout{
//        id: skrit
//        objectName: "skrit"

//        anchors.fill: parent;


//        TextField{
//            id: login
//            placeholderText: "Логин"
//            Layout.alignment: Qt.AlignCenter
//            background:
//                Rectangle{
//                id: lg
//                    anchors.fill: parent
//                    color: "transparent"
//                    border.color: "transparent"
//                    }
//        }

//        TextField{
//            id: pass
//            placeholderText: "Пароль"
//            Layout.alignment: Qt.AlignCenter
//            echoMode: TextInput.Password // скрытие символов
//            background:
//                Rectangle{
//                id: ps
//                    anchors.fill: parent
//                    color: "transparent"
//                    border.color: "transparent"
//                    }
//        }
//        Button{
//                text: "Выполнить вход"
//                Layout.alignment: Qt.AlignHCenter
//                onClicked: {
//                if(login.text == "" ){
//                  login.placeholderText= "ВВЕДИТЕ ЛОГИН"
//                  login.placeholderTextColor = "red"
//                   return
//                }
//                if(pass.text == ""){
//                   pass.placeholderText= "ВВЕДИТЕ ПАРОЛЬ"
//                   pass.placeholderTextColor = "red"
//                   return
//                }
//                    onAuth(login.text,pass.text); // вызываем функцию
//                                                    // авторизации с полученными
//                                                    // из формы логином и паролем
//                    restRequest();

//                }
//        }
////                Label {
////                    id: lbl_3
////                    objectName: "lbl_3"
////                    Layout.alignment: Qt.AlignCenter
////                    font.pixelSize: 20
////                    font.bold: true
////                    text: "Авторизация прошла успешно!"
////                    visible: false
////                }
//    }
//        RowLayout{
//            anchors.fill: parent
//            Layout.alignment: Qt.AlignCenter
//            //Layout.alignment: Qt.AlignHCenter
//            Label {
//                id: lbl_2
//                objectName: "lbl_2"
//                Layout.alignment: Qt.AlignCenter
//                font.pixelSize: 20
//                font.bold: true
//                text: "Полученный токен:"
//                visible: false
//            }

//        TextEdit{
//            id: text_edit1
//            objectName: "text_edit1"
//            readOnly: true
//            color: "white"
//            font.pointSize: 9
//        }
//    }

}

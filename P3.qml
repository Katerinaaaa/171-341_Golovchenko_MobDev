//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1

Page{ //ЛР 3. Взаимодействие кода C++ и QML
    // эффекты, используемые в лабораторной работе:
    // ['FastBlur', 'MaskedBlur', 'OpacityMask']

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
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.3 - Фото</span>'
            font.weight: Font.Bold
            font.family: "Consolas"
            font.pixelSize: 30
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    GridLayout {

        anchors.fill: parent
        rows: 6
        columns: 3
        Image{ // первая картинка
            id: im3
            sourceSize.width: 200
            sourceSize.height: 200
            source:"qrc:/resources/bear.jpg"
            visible: false
        }

        OpacityMask { // маска
            id: op
            Layout.preferredHeight: im3.height // по размеру картинки
            Layout.preferredWidth: im3.width
            source: im3
            maskSource: rectangleMask
            Layout.alignment: Qt.AlignCenter
        }
        Slider{ // слайдер для контроля изменения эффекта
            id: sldr3
            from: 0.0
            to: 1.0
        }
        Rectangle { // прямоугольник (маска)
            id: rectangleMask
            Layout.preferredHeight: im3.height
            Layout.preferredWidth: im3.width
            radius: sldr3.position*height // зависимось позиции слайдера от степени изменения эффекта
            opacity: 0.0
            smooth: true
        }
        Label{ // подпись
            text: "OpacityMask. "
            font.family: "Castellar"
            Layout.alignment: Qt.AlignCenter
        }

        Label{ // подпись
            text: "Try to invert it!"
            font.family: "Castellar"
            Layout.alignment: Qt.AlignCenter
        }
        Switch{ // переключатель для invert
            id: sw
            onClicked: {
                if(sw.position === 1){
                    op.invert = true
                }
                else{
                    op.invert = false
                }
            }
        }

        Image{ // вторая картинка
            id: im1
            sourceSize.width: 200
            sourceSize.height: 200
            source:"qrc:/resources/bear.jpg"
            visible: false

        }
        FastBlur { // размытие картинки
            radius: sldr1.position*20 // степень размытия зависит от положения слайдера
            Layout.preferredHeight: im1.height // по размеру картинки
            Layout.preferredWidth: im1.width
            source: im1
            Layout.alignment: Qt.AlignCenter
        }
        Slider{ // слайдер для изменения эффекта
            id: sldr1
            from: 1
            to: 64
        }
        Label{}

        Label{ // подпись
            text: "FastBlur"
            Layout.alignment: Qt.AlignCenter
            font.family: "Castellar"
        }
        Label{}
        Label{}


        Image{ // третья картинка
            id: im2
            sourceSize.width: 200
            sourceSize.height: 200
            source: "qrc:/resources/bear.jpg"
            visible: false
        }
        MaskedBlur { // эффект размытия градиентом
            //anchors.fill: im2
            Layout.preferredHeight: im2.height
            Layout.preferredWidth: im2.width
            source: im2
            maskSource: mask
            radius: sldr2.position*50 // зависисимость степени размытия от позиции слайдера
            samples: 25
            Layout.alignment: Qt.AlignCenter
        }
        Slider{ // слайдер для контроля изменения эффекта
            id: sldr2
            from: 1.0
            to: 4.0
        }

        Label{}
        Label{ // подпись
            text: "MaskedBlur"
            Layout.alignment: Qt.AlignCenter
            font.family: "Castellar"
        }
        LinearGradient { // линейный градиент
               id: mask
               //anchors.fill: im2
               Layout.preferredHeight: im2.height
               Layout.preferredWidth: im2.width
               opacity: 0.0
               source: Image{ // источником служит картинка
                   source: "qrc:/resources/btfl.png"
               }
               gradient: Gradient {
                   GradientStop { position: 0.2; color: "#ffffffff" }
                   GradientStop { position: 0.5; color: "#00ffffff" }
               }
               start: Qt.point(0, 0) // эффект до середины картинки
               end: Qt.point(250, 0)
               //visible: false
           }
    }
}

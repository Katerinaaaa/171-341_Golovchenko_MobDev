//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1

Page { // ЛР 1. GUI

    // шаблон header взят с мобильного приложения booking.com:
    // https://imag.malavida.com/mvimgbig/download-fs/booking-com-11438-1.jpg
    header:Rectangle{ // заголовок
        ToolBar {
           RowLayout {
               spacing: 20
               anchors.fill: parent

               ToolButton { // кнопочка для Drawer
                   contentItem: Image {
                       source: "qrc:/resources/icons8-menu-48.png"
                   }
                   onClicked: drawer.open() // при нажатии открывается drawer
               }
           }
       }
    Draw{
        id: drawer
    }

    color: "#003580"
    height: 60


        // ГРАДИЕНТ
       // gradient: Gradient{
       //    orientation: Gradient.Horizontal
       //     GradientStop{
       //        color: "blue"
       //       position: 1.0
       //     }
       //     GradientStop{
       //         color: "steelblue"
       //         position: 0.0
       //     }
       // }


        Label{ // название страницы
            x: parent.height
            text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.1 - GUI</span>'
            font.weight: Font.Bold // жирность
            font.pixelSize: 30 // размер
            font.family: "Consolas" // шрифт
            //anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            //anchors.margins: 10 // отступы в 10 пикселей

            // anchors.top:
            // anchors.right:
            // anchors.bottom:
            // anchors. fill: - сразу 4 границы

            // если не нужно настраивать габариты, а нужно только центрирование, то
            // anchors.centerIn: - сразу горизонталь и вертикаль
            // anchors.horizontalCenter:
            // anchors.verticalCenter:

        }
    }
    GridLayout {

        anchors.fill: parent
        rows: 4
        columns: 3

        Label{ // текст
            id: lbl
            text: qsTr("Вы на страничке 1")
            Layout.fillWidth: true
        }
        ComboBox{ // выбор одного элемента из списка
            Layout.fillWidth: true
            model: ["Красный", "Оранжевый", "Желтый", "Зеленый", "Голубой", "Синий", "Фиолетовый"]
        }
        Button{ // кнопка
            text: qsTr("Кнопочка")
            // Layout.preferredHeight: 100
            // Layout.preferredWidth: 100
            highlighted: true
            onClicked:{ // при нажатии
                lbl.text += qsTr(" :D ") // добавление нового текста в label
            }
        }
        Switch{ // переключатель
            text: qsTr("Переключалка")
        }
        RadioButton{
            text: ("Выбери")
        }
        CheckBox{
            text: ("Не обязательно")
        }
        Slider{ // вертикальный слайдер с фиксированным значением
            orientation: "Vertical"
            from: 0
            value: 25
            to: 100
        }
        Tumbler{ // тамблер (возможность выставить число/дату
            model: 10
        }
        Dial{ // круговой
            from: 0
            value: 10
            to: 100
        }
    }
}

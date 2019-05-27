import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0

   Drawer { // описание drawer
       id: drawer
       width: 0.66 * window.width // ширина (на сколько выдвигается)
       height: window.height // высота - полностью окно

       ListView {
           id: listView // список старичек в drawer
           currentIndex: -1
           anchors.fill: parent

           delegate: ItemDelegate {
               width: parent.width
               text: model.title
               highlighted: ListView.isCurrentItem
               onClicked: {
                   if (listView.currentIndex != index) {
                       listView.currentIndex = index // задаем индекс
                       tabBar.currentIndex = listView.currentIndex // нижнее меню переключаниется
                   }
                   drawer.close()
               }
           }

       model: ListModel { // ссылки в drawer
           ListElement {
               title: "Лабораторная 1 - GUI"; source: "qrc:/P1.qml"
           }
           ListElement {
               title: "Лабораторная 2 - Запись и воспроизведение мультимедиа-файлов"; source: "qrc:/P2.qml"
           }
           ListElement {
               title: "Лабораторная 3 - Взаимодействие кода C++ и QML"; source: "qrc:/P3.qml"
           }
           ListElement {
               title: "Лабораторная 4 - Запросы"; source: "qrc:/P4.qml"
           }
           ListElement {
               title: "Лабораторная 5 - Авторизация в ВК"; source: "qrc:/P5.qml"
           }
           ListElement {
               title: "Лабораторная 6 - Список друзей"; source: "qrc:/P6.qml"
           }
           ListElement {
               title: "Лабораторная 7 - Шифрование"; source: "qrc:/P7.qml"
           }
           ListElement {
               title: "Лабораторная 8 - Базы данных"; source: "qrc:/P8.qml"
           }
       }

       ScrollIndicator.vertical: ScrollIndicator { } //скролл
       }
   }

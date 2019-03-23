//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.8
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0


ApplicationWindow {
    id: window
    visible: true
    width: 500
    height: 800
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page { // ЛР 1. GUI

            // шаблон header взят с мобильного приложения booking.com:
            // https://imag.malavida.com/mvimgbig/download-fs/booking-com-11438-1.jpg

            header:Rectangle{

                ToolBar {
                   RowLayout {
                       spacing: 20
                       anchors.fill: parent

                       ToolButton {
                           contentItem: Image {
                               source: "qrc:/resources/icons8-menu-48.png"
                           }
                           onClicked: drawer1.open()
                       }
                   }
               }

               Drawer {
                   id: drawer1
                   width: 0.66 * window.width
                   height: window.height

                   ListView {
                       id: listView1
                       currentIndex: -1
                       anchors.fill: parent

                       delegate: ItemDelegate {
                           width: parent.width
                           text: model.title
                           highlighted: ListView.isCurrentItem
                           onClicked: {
                               if (listView1.currentIndex != index) {
                                   listView1.currentIndex = index
                               }
                               drawer1.close()
                           }
                       }

                   model: ListModel {
                       ListElement { title: "Лабораторные 1 - 3"; source: "qrc:/main.qml" }
                   }

                   ScrollIndicator.vertical: ScrollIndicator { }
                   }
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


                Label{
                    x: parent.height
                    text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.1 - GUI</span>'
                    font.weight: Font.Bold
                    font.pixelSize: 30
                    font.family: "Consolas"
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

                Label{
                    id: lbl
                    text: qsTr("Вы на страничке 1")
                    Layout.fillWidth: true
                }

                ComboBox{
                    Layout.fillWidth: true
                    model: ["Красный", "Оранжевый", "Желтый", "Зеленый", "Голубой", "Синий", "Фиолетовый"]
                }

                Button{
                    text: qsTr("Кнопочка")
                    // Layout.preferredHeight: 100
                    // Layout.preferredWidth: 100
                    highlighted: true
                    onClicked:{
                        lbl.text += qsTr(" :D ")
                    }
                }

                Switch{
                    text: qsTr("Переключалка")
                }

                RadioButton{
                    text: ("Выбери")
                }

                CheckBox{
                    text: ("Не обязательно")
                }

                Slider{
                    orientation: "Vertical"
                    from: 0
                    value: 25
                    to: 100
                }

                Tumbler{
                    model: 10
                }

                Dial{
                    from: 0
                    value: 10
                    to: 100
                }
            }
        }

        Page { // ЛР 2. Запись и воспроизведение мультимедиа-файлов

            // работа с ВЕБ, безопасная аутентификация ВК
            //nk260an
            // декларативное программирование

            header:Rectangle{

                ToolBar {
                   RowLayout {
                       spacing: 20
                       anchors.fill: parent

                       ToolButton {
                           contentItem: Image {
                               source: "qrc:/resources/icons8-menu-48.png"
                           }
                           onClicked: drawer2.open()
                       }
                   }
               }

               Drawer {
                   id: drawer2
                   width: 0.66 * window.width
                   height: window.height

                   ListView {
                       id: listView2
                       currentIndex: -1
                       anchors.fill: parent

                       delegate: ItemDelegate {
                           width: parent.width
                           text: model.title
                           highlighted: ListView.isCurrentItem
                           onClicked: {
                               if (listView2.currentIndex != index) {
                                   listView2.currentIndex = index
                               }
                               drawer2.close()
                           }
                       }

                   model: ListModel {
                       ListElement { title: "Лабораторные 1 - 3"; source: "qrc:/main.qml" }
                   }

                   ScrollIndicator.vertical: ScrollIndicator { }
                   }
               }
                color: "#003580"
                height: 60

                Label{
                    x: parent.height
                    text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.2 - Видео</span>'
                    font.weight: Font.Bold
                    font.family: "Consolas"
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ColumnLayout{

                anchors.fill: parent

                RowLayout{
                    Layout.alignment: Qt.AlignCenter

                    RadioButton{
                        id: rad1
                        //Layout.alignment: Qt.AlignLeft
                        text: "Видео"
                        checked: true
                        onCheckedChanged:
                            if(rad1.checked === true){
                                videoOutput.visible = true
                                sldr.visible = true
                                btn.visible = true
                                cam.visible = false
                                gallery.visible = false
                                photoPreview.visible = false
                                btn2.visible = false
                                image11.visible = false
                            }

                    }
                    RadioButton{
                        id: rad2
                        //Layout.alignment: Qt.AlignRight
                        text: "Камера"
                        onCheckedChanged:
                            if(rad2.checked === true){
                                videoOutput.visible = false
                                sldr.visible = false
                                btn.visible = false
                                mediaplayer.pause()
                                cam.visible = true
                                gallery.visible = true
                                photoPreview.visible = true
                                btn2.visible = true
                                image11.visible = true
                            }
                    }
                }
                Camera{
                    id: camera
                    imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

                    exposure {
                        exposureCompensation: -1.0
                        exposureMode: Camera.ExposurePortrait
                    }

                    flash.mode: Camera.FlashRedEyeReduction

                    imageCapture {
                        onImageCaptured: {
                            photoPreview.source = preview  // Show the preview in an Image
                        }
                    }
                }
                Button{
                    id:btn2
                    flat: true
                    visible: false
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        pushanimation2.start()
                        camera.imageCapture.capture()
                    }
                    background: Image{
                        id: image11
                        visible: false
                        //anchors.fill: parent
                        source: "qrc:/resources/video-play-button.png"
                        sourceSize.width: 100
                        sourceSize.height: 100
                        property bool pressed: false
                    }

                    ScaleAnimator{
                        id: pushanimation2
                        target: btn2
                        from: 1.0
                        to: 0.9
                        duration: 200
                    }
                }
                Label{
                    id: gallery
                    text: "Галерея"
                    Layout.alignment: Qt.AlignTop
                    font.family: "Consolas"
                    visible: false
                }

                Image {
                    id: photoPreview
                    sourceSize.width: 100
                    sourceSize.height: 100
                    visible: false
                }

                VideoOutput {
                    id: cam
                    source: camera
                    Layout.preferredHeight: 350
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    //anchors.fill: parent
                    visible: false
                    focus : visible // to receive focus and capture key events when visible
                    MouseArea {
                        anchors.fill: parent;
                        onClicked: camera.imageCapture.capture();
                    }
                }

                MediaPlayer{
                    id: mediaplayer
                    source: "qrc:/resources/sample.avi"
                }

                VideoOutput {
                    id: videoOutput
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 350
                    Layout.fillWidth: true
                    source: mediaplayer
                    visible: true
                }

                Slider{
                    id: sldr
                    Layout.fillWidth: true
                    from: 0.0
                    to: mediaplayer.duration
                    property bool sync: false

                    onValueChanged: {
                        if (!sync)
                        mediaplayer.seek(value)
                    }
                    Connections {
                        target: mediaplayer
                        onPositionChanged: {
                            sldr.sync = true
                            sldr.value = mediaplayer.position
                            sldr.sync = false
                            if(sldr.value === mediaplayer.duration){
                                sldr.value = 0.0
                                image1.visible = true
                                image2.visible = false
                            }
                        }
                    }
                }
                Button{
                    id:btn
                    flat: true
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        pushanimation.start()
                    }
                    onPressed: {
                        if(image1.pressed == false){
                            image1.pressed = true
                            mediaplayer.play()
                            image1.visible = false
                            image2.visible = true
                        }
                        else{
                            image1.pressed = false
                            mediaplayer.pause()
                            image2.visible = false
                            image1.visible = true
                        }
                    }
                    background: Image{
                        id: image1
                        //anchors.fill: parent
                        source: "qrc:/resources/video-play-button.png"
                        sourceSize.width: 100
                        sourceSize.height: 100
                        property bool pressed: false

                    }
                    Image{
                        id: image2
                        anchors.fill: parent
                        source: "qrc:/resources/pause.png"
                        sourceSize.width: 100
                        sourceSize.height: 100
                        property bool pressed: false
                        visible: false
                    }

                    ScaleAnimator{
                        id: pushanimation
                        target: btn
                        from: 1.0
                        to: 0.9
                        duration: 200
                    }
                }
            }
        }

        Page{ //ЛР 3. Взаимодействие кода C++ и QML
            // эффекты, используемые в лабораторной работе:
            // ['FastBlur', 'MaskedBlur', 'OpacityMask']

            header:Rectangle{

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

                Drawer {
                    id: drawer
                    width: 0.66 * window.width
                    height: window.height

                    ListView {
                        id: listView
                        currentIndex: -1
                        anchors.fill: parent

                        delegate: ItemDelegate {
                            width: parent.width
                            text: model.title
                            highlighted: ListView.isCurrentItem
                            onClicked: {
                                if (listView.currentIndex != index) {
                                    listView.currentIndex = index
                                }
                                drawer.close()
                            }
                        }

                    model: ListModel {
                        ListElement { title: "Лабораторные 1 - 3"; source: "qrc:/main.qml" }
                    }

                    ScrollIndicator.vertical: ScrollIndicator { }
                    }
                }
                color: "#003580"
                height: 60

                Label{
                    x: parent.height
                    text: '<span style="color:#ffffff">ЛР</span><span style="color:#009fe3">.3 - Фото</span>'
                    font.weight: Font.Bold
                    font.family: "Consolas"
                    font.pixelSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                }

            }
            GridLayout {

                //anchors.fill: parent

                Layout.alignment: Qt.AlignCenter
                //Layout.fillWidth: true
                rows: 6
                columns: 3

                Label{}

                Image{
                    id: im3
                    sourceSize.width: 200
                    sourceSize.height: 200
                    source:"qrc:/resources/bear.jpg"
                    visible: false
                }
                Slider{
                    id: sldr3
                    from: 0.0
                    to: 1.0
                }

                Rectangle {
                    id: rectangleMask
                    anchors.fill: parent
                    radius: sldr3.position*height
                    visible: false
                }

                OpacityMask {
                    id: op
                    anchors.fill: im3
                    source: im3
                    maskSource: rectangleMask
                }
                Label{
                    text: "OpacityMask. Try to invert it!"
                    font.family: "Castellar"
                }

                Switch{
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
                Label{}


                Image{
                    id: im1
                    sourceSize.width: 200
                    sourceSize.height: 200
                    source:"qrc:/resources/bear.jpg"

                }
                Slider{
                    id: sldr1
                    from: 1
                    to: 64
                }
                FastBlur { // размытие картинки
                    radius: sldr1.position*10 // степени размытия зависит от положения слайдера
                    anchors.fill: im1
                    source: im1
                }
                Label{
                    text: "FastBlur"
                    font.family: "Castellar"
                }
                Label{}
                Label{}

                Image{
                    id: im2
                    sourceSize.width: 200
                    sourceSize.height: 200
                    source: "qrc:/resources/bear.jpg"
                }
                Slider{
                    id: sldr2
                    from: 1.0
                    to: 4.0
                }
                LinearGradient {
                       id: mask
                       anchors.fill: im2
                       gradient: Gradient {
                           GradientStop { position: 0.2; color: "#ffffffff" }
                           GradientStop { position: 0.5; color: "#00ffffff" }
                       }
                       start: Qt.point(0, 0)
                       end: Qt.point(250, 0)
                       visible: false
                   }
                Image{
                    id: immask
                    visible: false
                    source: "qrc:/resources/tiger.jpg"
                }

                   MaskedBlur {
                       anchors.fill: im2
                       source: im2
                       maskSource: mask
                       radius: sldr2.position*10
                       samples: 25
                   }
                   Label{
                       text: "MaskedBlur"
                       font.family: "Castellar"
                   }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("ЛР 1")
        }
        TabButton {
            text: qsTr("ЛР 2")
        }
        TabButton {
            text: qsTr("ЛР 3")
        }
    }
}

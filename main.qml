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
    width: 650 // ширина окна
    height: 800 // высота окна
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

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
                           onClicked: drawer1.open() // при нажатии открывается drawer
                       }
                   }
               }

               Drawer { // описание drawer
                   id: drawer1
                   width: 0.66 * window.width // ширина (на сколько выдвигается)
                   height: window.height // высота - полностью окно

                   ListView {
                       id: listView1 // список старичек в drawer
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

                   model: ListModel { // ссылки в drawer
                       ListElement { title: "Лабораторные 1 - 3"; source: "qrc:/main.qml" }
                   }

                   ScrollIndicator.vertical: ScrollIndicator { } //скролл
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

                Label{ // заголовок странички
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

                    RadioButton{ // выбор, что отображается на страничке
                        id: rad1 // id
                        //Layout.alignment: Qt.AlignLeft
                        text: "Видео" // подпись
                        checked: true // выбран по умолчанию
                        onCheckedChanged: // если сменен выбор
                            if(rad1.checked === true){ // если выбран rad1
                                videoOutput.visible = true // вывод видео виден
                                sldr.visible = true // слайдер для видео виден
                                btn.visible = true // кнопка видна
                                cam.visible = false // камера не видна
                                gallery.visible = false // галерея (название) не видна
                                photoPreview.visible = false // последнее фото не видно
                                btn2.visible = false // кнопка не видна
                                btn3.visible = false // кнопка не видна
                                rl.visible = true // громкость звука (для видео) не видна
                            }
                    }
                    RadioButton{ // выбор, что отображается на страничке
                        id: rad2 // id
                        //Layout.alignment: Qt.AlignRight
                        text: "Камера" // подпись
                        onCheckedChanged: // если вменен выбор
                            if(rad2.checked === true){ // если выбран rad2
                                videoOutput.visible = false // видео не отображается
                                sldr.visible = false // слайдер не отображается
                                btn.visible = false // кнопка не видна
                                mediaplayer.pause() // видео на паузу становится
                                cam.visible = true // видна камера
                                gallery.visible = true // видна подпись
                                photoPreview.visible = true // видно последнее сделанное фото
                                btn2.visible = true // видна кнопка
                                btn3.visible = true // видна кнопка
                                rl.visible = false // не виден переключатель громкости звука
                            }
                    }
                }
                RowLayout{
                    id: rl
                    Layout.alignment: Qt.AlignCenter
                    Label{ // название
                        id: zvuk
                        text: "Громкость звука: "
                        font.pixelSize: 25 // размер
                    }

                    Slider{ // слайдер для изменения громкости звука
                        id: vol
                        from: 0.0
                        to: 1.0
                        value: 0.5
                    }
                }

                Camera{ // камера
                    id: camera

                    captureMode: Camera.CaptureVideo

                    videoRecorder.audioBitRate: 128000 // скорость передачи звука
                    videoRecorder.mediaContainer: "mp4" // формат
                    videoRecorder.outputLocation: "/video" // папка сохранения

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
                RowLayout{

                    Layout.alignment: Qt.AlignCenter

                    Button{ // кнопка для фото
                        id:btn2
                        flat: true
                        visible: false // по умолчанию не видна
                        text: "Сделать фото!"
                        font.pixelSize: 25
                        font.family: "Consolas"
                        onClicked: { // если нажата
                            pushanimation2.start() // анимация запускается
                            camera.imageCapture.capture() // захват фото
                        }

                        ScaleAnimator{ // анимация
                            id: pushanimation2
                            target: btn2
                            from: 1.0 // вдавливание
                            to: 0.9
                            duration: 200
                        }
                    }
                    Button{ // кнопка для записи видео
                        id:btn3
                        flat: true
                        visible: false
                        text: "Снять видео!"
                        font.pixelSize: 25
                        font.family: "Consolas"
                        onClicked: { // если нажата
                            pushanimation3.start() // отображение анимации
                            camera.videoRecorder.record() // запись
                        }

                        ScaleAnimator{ // аниамция
                            id: pushanimation3
                            target: btn3
                            from: 1.0 // вдавливание
                            to: 0.9
                            duration: 200
                        }
                    }
                }
                Label{ // название (для вывода сделанных фото)
                    id: gallery
                    text: "Галерея"
                    font.pixelSize: 20
                    Layout.alignment: Qt.AlignTop
                    font.family: "Consolas"
                    visible: false
                }

                Image { // последнее сделанное фото
                    id: photoPreview
                    sourceSize.width: 100
                    sourceSize.height: 100
                    visible: false
                }

                VideoOutput { // сама камера
                    id: cam
                    source: camera
                    Layout.preferredHeight: 350
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    visible: false
                    focus: visible // to receive focus and capture key events when visible
                }

                MediaPlayer{ // источник видео
                    id: mediaplayer
                    source: "qrc:/resources/sample.avi"
                    volume: vol.position
                }

                VideoOutput { // вывод видео
                    id: videoOutput
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: 350
                    Layout.fillWidth: true
                    source: mediaplayer
                    visible: true
                }

                Slider{ // связь слайдера с положением видео
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
                            if(sldr.value === mediaplayer.duration){ // возвращение видео в начало по окончании
                                sldr.value = 0.0
                                image1.visible = true
                                image2.visible = false
                            }
                        }
                    }
                }
                Button{ // кнопка для старта/остановки воспроизведения видео
                    id:btn
                    flat: true
                    Layout.alignment: Qt.AlignCenter
                    onClicked: { // когда нажимается, отображается анимция
                        pushanimation.start()
                    }
                    onPressed: {
                        if(image1.pressed == false){
                            image1.pressed = true
                            mediaplayer.play() // видео играет
                            image1.visible = false // кнопка (картинка) play не видна
                            image2.visible = true // кнопка (картинка) паузы видна
                        }
                        else{
                            image1.pressed = false
                            mediaplayer.pause() // видео останавливается
                            image2.visible = false // кнопка (картинка) паузы не видна
                            image1.visible = true // кнопка (картинка) play видна
                        }
                    }
                    background: Image{ // картинка play
                        id: image1
                        //anchors.fill: parent
                        source: "qrc:/resources/video-play-button.png"
                        sourceSize.width: 100
                        sourceSize.height: 100
                        property bool pressed: false

                    }
                    Image{ // картинка паузы
                        id: image2
                        anchors.fill: parent
                        source: "qrc:/resources/pause.png"
                        sourceSize.width: 100
                        sourceSize.height: 100
                        property bool pressed: false
                        visible: false
                    }

                    ScaleAnimator{ // анимация вдавливания для кнопки
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

                Drawer { // боковое меню
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
    }
}

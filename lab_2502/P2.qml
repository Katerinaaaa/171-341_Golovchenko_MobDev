//import QtQuick 2.9
import QtQuick 2.12
//import QtQuick.Controls 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtMultimedia 5.9
import QtGraphicalEffects 1.12
import QtQuick.Window 2.0
import Qt.labs.platform 1.1

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
                        model_video.visible = true
                        gal.visible = true
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
                        btn3.visible =true// видна кнопка
                        rl.visible = false // не виден переключатель громкости звука
                        model_video.visible = false
                        gal.visible = false
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
        VideoOutput { // вывод видео
            id: videoOutput
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 400
            Layout.preferredWidth: 400
            source: mediaplayer
            visible: true
            MouseArea {
                   id: playArea
                   anchors.fill: parent
                   onPressed:{
                       if(image1.pressed == false){
                           pushanimation.start()
                           image1.pressed = true
                           mediaplayer.play() // видео играет
                           image1.visible = false // кнопка (картинка) play не видна
                           before_view.visible = false
                           image2.visible = true // кнопка (картинка) паузы видна
                           timer.restart();
                       }
                       else{
                           pushanimation.start()
                           image1.pressed = false
                           mediaplayer.pause() // видео останавливается
                           image2.visible = false // кнопка (картинка) паузы не видна
                           image1.visible = true // кнопка (картинка) play видна
                           timer.stop();
                           sldr.visible = true
                       }
                   }
            }
            BorderImage {
                id: before_view
                source: "qrc:/resources/dog.jpg"
                width: 400; height: 400
                border.left: 5; border.top: 5
                border.right: 5; border.bottom: 5
            }
                   Button{ // кнопка для старта/остановки воспроизведения видео
                       id:btn
                       flat: true
                       //Layout.alignment: Qt.AlignHCenter
                       x: 150; y: 150;
                       width: 100; height: 100
//                               onClicked: { // когда нажимается, отображается анимция
//                                   pushanimation.start()
//                               }
                       onPressed: {
                           if(image1.pressed == false){
                               pushanimation.start()
                               image1.pressed = true
                               mediaplayer.play() // видео играет
                               before_view.visible = false
                               image1.visible = false // кнопка (картинка) play не видна
                               image2.visible = true // кнопка (картинка) паузы видна
                               timer.restart();
                           }
                           else{
                               pushanimation.start()
                               image1.pressed = false
                               mediaplayer.pause() // видео останавливается
                               image2.visible = false // кнопка (картинка) паузы не видна
                               image1.visible = true // кнопка (картинка) play видна
                               timer.stop();
                               sldr.visible = true
                           }
                       }
                       background: Image{ // картинка play
                           id: image1
                           //anchors.fill: parent
                           source: "qrc:/resources/play.png"
                           sourceSize.width: 90
                           sourceSize.height: 90
                           property bool pressed: false

                       }
                       Image{ // картинка паузы
                           id: image2
                           anchors.fill: parent
                           source: "qrc:/resources/pause.png"
                           sourceSize.width: 90
                           sourceSize.height: 90
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
        Slider{ // связь слайдера с положением видео
            id: sldr
            //Layout.fillWidth: true
            anchors.bottom: videoOutput.bottom
            anchors.left: videoOutput.left
            anchors.right: videoOutput.right
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
                        before_view.visible = true
                        sldr.visible = true
                        timer.stop();
                    }
                }
            }
        }
        Label{
            id: gal
            anchors.top: videoOutput.bottom
            anchors.margins: 10
            text: "Галерея видео:"
            font.pixelSize: 20
            //Layout.alignment: Qt.AlignTop
            font.family: "Consolas"
        }

            ListView {
                id: model_video
                //anchors.fill: parent
                anchors.top: gal.bottom
                anchors.margins: 10
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                visible: true
                enabled: true
                model: mdl
                orientation: ListView.Horizontal
                delegate: Rectangle{
                    color: "white"
                    width: 100
                    height: 100
                    border.color: "pink"
                    Layout.margins: 10
                    GridLayout{
                        anchors.fill: parent
                        columns: 3
                        rows: 3
                        Layout.margins: 20
                        Image {
                            source: photo
                            Layout.row: 0
                            Layout.column: 0
                            Layout.rowSpan: 3
                            Layout.preferredHeight: 95
                            Layout.preferredWidth: 95

                        }
                        Label{
                            text: name_video
                            Layout.row: 2
                            color: "#E667AF"
                            font.weight: Font.Bold
                            Layout.column: 0
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                model_video.currentIndex = index
                            }
                        }
                   }
                }

                focus: true
                onCurrentItemChanged:{
                   console.log(mdl.get(model_video.currentIndex).name_video + ' выбрано');
                   mediaplayer.stop();
                   timer.stop();
                   sldr.visible = true;
                   before_view.visible = true
                   image1.visible = true
                   image2.visible = false
                   before_view.source = mdl.get(model_video.currentIndex).photo;
                   mediaplayer.source = mdl.get(model_video.currentIndex).video;
           }
        }
            ListModel{
                id: mdl
                ListElement{
                    photo: "qrc:/resources/dog.jpg"
                    name_video: "dog.avi"
                    video: "qrc:/resources/dog.avi"
                }
                ListElement{
                    photo: "qrc:/resources/food.jpg"
                    name_video: "feed.avi"
                    video: "qrc:/resources/food.avi"
                }
                ListElement{
                    photo: "qrc:/resources/cute.jpg"
                    name_video: "cute.avi"
                    video: "qrc:/resources/cute.avi"
                }
                ListElement{
                    photo: "qrc:/resources/swim.jpg"
                    name_video: "swim.avi"
                    video: "qrc:/resources/swim.avi"
                }
                ListElement{
                    photo: "qrc:/resources/puppy.jpg"
                    name_video: "puppy.avi"
                    video: "qrc:/resources/puppy.avi"
                }
                ListElement{
                    photo: "qrc:/resources/sleep.jpg"
                    name_video: "sleep.avi"
                    video: "qrc:/resources/sleep.avi"
                }
            }
            Timer {
                id: timer
                interval: 3000;
                running: false;
                repeat: true
                onTriggered: {
                    sldr.visible = false;
                    image1.visible = false
                    image2.visible = false;
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

                    //CameraCapture.captureToLocation("qrc:/resources/photo");
                    //CameraCapture.capturedImagePath
                    photoPreview.source = preview  // Show the preview in an Image
                }
            }
        }
        RowLayout{
            id: btns

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
            Layout.preferredWidth: 350
            Layout.alignment: Qt.AlignCenter
            visible: false
            focus: visible // to receive focus and capture key events when visible
        }

        MediaPlayer{ // источник видео
            id: mediaplayer
            source: "qrc:/resources/dog.avi"
            volume: vol.position
        }
    }
}

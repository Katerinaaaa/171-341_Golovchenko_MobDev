#include "webappcontroller.h"
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QFile>
#include <QEvent>
#include <QEventLoop>

WebAppController::WebAppController(QObject *QMLObject) : viewer(QMLObject)
{
    manager = new QNetworkAccessManager(this); // создаем менеджер, который будет отправлять запросы
    connect(manager, &QNetworkAccessManager::finished, this, &WebAppController::onRezult);
}

void WebAppController::Auth(QString login, QString password){ // функция для авторизации в приложении и получения access token

    QEventLoop loop; // как "пауза"

    QString clientId = "6935008"; // идентификатор нашего приложения, в котором мы авторизуемся
    manager = new QNetworkAccessManager(); // менеджер для доступа к сайту
    QObject::connect(manager,
                     SIGNAL(finished(QNetworkReply*)),
                     &loop,
                     SLOT(quit()));
    QNetworkReply * reply = manager->get(QNetworkRequest(QUrl("https://oauth.vk.com/authorize?"
                                                                 "client_id=" + clientId // id нашего приложения
                                                                 + "&redirect_uri=http://oauth.vk.com/blank.html&"
                                                                 "display=mobile&" // отображение диалога для мобильных устройств
                                                                 "scope=friends&" // доступ к списку друзей
                                                                 "response_type=token&" // что возвращает приложение
                                                                 "v=5.92&" // актуальная версия приложения
                                                                 /*"state=kotik"*/))); // произвольная строка


    qDebug() << "**** GET before loop ****";

    loop.exec();

    qDebug() << "**** GET after loop ****";

    // Просмотр кода формы с помощью следующей команды:
    qDebug() << "**** reply header = " << reply->header(QNetworkRequest::LocationHeader).toString();
    QString str(reply->readAll()); // в переменной хранится весь текст html

    qDebug() << str; // выводим текст

    // делим форму авторизации (код)


//    reply = manager
//            ->get(QNetworkRequest(
//                      QUrl("https://login.vk.com/"
//                           "?act=login"
//                           "&soft=1"
//                           "&utf8=1"
//                           "&lg_h=" + lg_h
//                           + "&ip_h=" + ip_h
//                           + "&to=" + to
//                           + "&_origin=" + _origin
//                           + "&email=" + login
//                           + "&pass=" + password)));

 // после 2 запроса должно прийти что-то вроде https://oauth.vk.com/authorize?client_id=6455770&redirect_uri=https%3A%2F%2Foauth.vk.com%2Fblank.html&response_type=token&scope=2&v=5.37&state=123456&display=mobile&__q_hash=28f5e4f93012a7b3ae36130f6880e60c

    loop.exec();
    qDebug() <<  "*** РЕЗУЛЬТАТ 2 ЗАПРОСА HEADER " <<  reply->header(QNetworkRequest::LocationHeader).toString();
       qDebug() <<  "*** РЕЗУЛЬТАТ 2 ЗАПРОСА BODY " <<  reply->readAll(); // выводим полный html документ

       // Получаем редирект с успешной авторизацией
       reply = manager->get(
                   QNetworkRequest(QUrl(
                                       reply->header(QNetworkRequest::LocationHeader).toString())));
    loop.exec();
    qDebug() <<  "*** РЕЗУЛЬТАТ 3 ЗАПРОСА HEADER " <<  reply->header(QNetworkRequest::LocationHeader).toString();
    // здесь должно быть выведено что-то вроде https://login.vk.com/?act=grant_access&client_id=6455770&settings=2&redirect_uri=https%3A%2F%2Foauth.vk.com%2Fblank.html&response_type=token&group_ids=&token_type=0&v=5.37&state=123456&display=mobile&ip_h=ef8b1396e37a94a790&hash=1555330570_4d65b2c53f975e8ae9&https=1
    qDebug() <<  "*** РЕЗУЛЬТАТ 3 ЗАПРОСА BODY " <<  reply->readAll();
    // Получаем редирект на токен, наш милый и любимый
    reply = manager->get(
                   QNetworkRequest(
                       QUrl(
                           reply->header(QNetworkRequest::LocationHeader).toString())));
    loop.exec();

    //QString str = reply->readAll();

    str = reply->header(QNetworkRequest::LocationHeader).toString();
    qDebug() <<  "*** РЕЗУЛЬТАТ 4 ЗАПРОСА HEADER " << str;
    // вот здесь только получен access_token в URI вида https://oauth.vk.com/blank.html#access_token=6bb58aed5a329922889fad15201e71046493539c5bebfbc6cafa43080a14822518bdd3c5bacde32432f9c&expires_in=86400&user_id=27520159&state=123456
    qDebug() <<  "*** РЕЗУЛЬТАТ 4 ЗАПРОСА BODY " << reply->readAll();

       if (str.indexOf("access_token") != -1)
       {
           m_accessToken = str.split("access_token=")[1].split("&")[0];
           emit authorized();
           emit authSuccess();
           qDebug() <<  "*** m_accessToken" << m_accessToken.mid(2,20);
       }
       else
           qDebug() << "Failed!";

}

void WebAppController::onRezult(QNetworkReply *reply){ // то, что мы видим в debug
    qDebug()<<reply->url(); // выводим url, к которому обращемся
    qDebug()<<reply->rawHeaderList(); // выводим заголовки
    //qDebug()<<reply->readAll();

    // Если запрос не отправляется, то выводим ошибку в Debug
    if(reply->error()){
        qDebug() << "ERROR";
        qDebug() << reply->errorString();
    }
    else { // если без ошибок

        QFile *file = new QFile("C:/Users/tiger/OneDrive/Рабочий стол/text.txt"); // Создаём объект для работы с файлом

        if(file->open(QFile::WriteOnly)){ // Открываем файл для записи
            file->isOpen(); // открываем файл
            file->write(reply->readAll()); // записываем в файл весь html-код со страницы
            file->close(); // закрывайем файл
        }
    }
}

void WebAppController::onPageInfo(){ // вывод данных в приложение
    //QString rep = reply->readAll();

    QFile file("C:/Users/tiger/OneDrive/Рабочий стол/text.txt"); // файл на рабочем столе, в котором содержится html-код
    if (!file.open(QIODevice::ReadOnly)) // Открваем файл, если это возможно
            return; // если открытие файла невозможно, выходим из слота
    // в противном случае считываем данные и устанавилваем их в textEdit
    QObject* text_edit = viewer->findChild<QObject*>("text_edit"); // находим элемент text_edit из qml-кода

    QString str = file.readAll(); // в переменную записывается текст из файла

    int j = 0;
    if((j = str.indexOf("meteodata grey", j)) != -1) {
     //по индексу тэга найдём нужное значение, т.е. температуру по ощущениям
        qDebug() << "\n" << "Ощущение температуры на этой позиции" << j;
        text_edit->setProperty("text", str.mid( j + 64,3)); // находим 64 символ, считываем 3 символа после него
                                                            // (наша температура по ощущениям)
                                                            // и записываем его значение в text_edit из qml-кода
    }
}

void WebAppController::readFile() // скачиваем текст html в файл, а затем выводим его на экран
{
    QFile file("C:/Users/tiger/OneDrive/Рабочий стол/text.txt");
    if (!file.open(QIODevice::ReadOnly)) // Открываем файл, если это возможно
            return;
    QObject* text_area = viewer->findChild<QObject*>("text_area"); // находим объект, в который будет записан текст
    QString str = file.readAll(); // считываем полностью текст в файле

    int j = 0;
    if((j = str.indexOf("meteodata grey", j)) != -1) { // находим нужное значение по тэгу
        text_area->setProperty("text", str); // задаем параметр "текст" для text_area из qml-кода
    }
}


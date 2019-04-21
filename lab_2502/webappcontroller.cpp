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
    manager = new QNetworkAccessManager(this);
    //vk_manager = new QNetworkAccessManager(this);
    connect(manager, &QNetworkAccessManager::finished, this, &WebAppController::Rez);
}

void WebAppController::Auth(QString login, QString password){
    QEventLoop loop;

    QString clientId = "6935008";
    manager = new QNetworkAccessManager();
    QObject::connect(manager,
                     SIGNAL(finished(QNetworkReply*)),
                     &loop,
                     SLOT(quit()));
    QNetworkReply * reply = manager->get(QNetworkRequest(QUrl("http://oauth.vk.com/authorize?"
                                                                 "client_id=6935008&"
                                                                 "redirect_uri=http://oauth.vk.com/blank.html&"
                                                                 "display=mobile&"
                                                                 "scope=friends&"
                                                                 "response_type=token&"
                                                                 "v=5.92&")));


    reply = manager
            ->get(QNetworkRequest(
                      QUrl("http://login.vk.com/"
                           "?act=login"
                           "&soft=1"
                           "&utf8=1"
                           "&lg_h=" + parameter_lg_h
                           + "&ip_h=" + parameter_ip_h
                           + "&to=" + parameter_to
                           + "&_origin=" + parameter_origin
                           + "&email=" + login
                           + "&pass=" + QUrl::toPercentEncoding(password))));

    loop.exec();
    qDebug() <<  "*** РЕЗУЛЬТАТ 2 ЗАПРОСА HEADER " <<  reply->header(QNetworkRequest::LocationHeader).toString();
       qDebug() <<  "*** РЕЗУЛЬТАТ 2 ЗАПРОСА BODY " <<  reply->readAll();

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

    QString str = reply->readAll();

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

void WebAppController::onRezult(QNetworkReply *reply){
    qDebug()<<reply->url();
    qDebug()<<reply->rawHeaderList();
    //qDebug()<<reply->readAll();

    // Если запрос не отправляется, то выводим ошибку в Debug
    if(reply->error()){
        qDebug() << "ERROR";
        qDebug() << reply->errorString();
    }
    else {

        QFile *file = new QFile("C:/Users/tiger/OneDrive/Рабочий стол/text.txt"); // Создаём объект для работы с файлом

        if(file->open(QFile::WriteOnly)){ // Открываем файл для записи
            file->isOpen();
            file->write(reply->readAll());
            file->close();
        }
    }
}

void WebAppController::onPageInfo(){
    //QString rep = reply->readAll();

    QFile file("C:/Users/tiger/OneDrive/Рабочий стол/text.txt");
    if (!file.open(QIODevice::ReadOnly)) // Открваем файл, если это возможно
            return; // если открытие файла невозможно, выходим из слота
    // в противном случае считываем данные и устанавилваем их в textEdit
    QObject* text_edit = viewer->findChild<QObject*>("text_edit");

    QString str = file.readAll();

    int j = 0;
    if((j = str.indexOf("meteodata grey", j)) != -1) {
     //по индексу тэга найдём нужное значение, т.е. курс валют
        qDebug() << "\n" << "Ощущение температуры на этой позиции" << j;
        text_edit->setProperty("text", str.mid( j + 64,3));
    }
}

void WebAppController::readFile()
{
    QFile file("C:/Users/tiger/OneDrive/Рабочий стол/text.txt");
    if (!file.open(QIODevice::ReadOnly)) // Открваем файл, если это возможно
            return;
    QObject* text_area = viewer->findChild<QObject*>("text_area");
    QString str = file.readAll();

    int j = 0;

    if((j = str.indexOf("meteodata grey", j)) != -1) {
        text_area->setProperty("text", str);
    }
}

//void WebAppController::Rez(QNetworkReply *reply){
//    qDebug()<<reply->url();
//    qDebug()<<reply->rawHeaderList();
//    //qDebug()<<reply->readAll();

//    // Если запрос не отправляется, то выводим ошибку в Debug
//    if(reply->error()){
//        qDebug() << "ERROR";
//        qDebug() << reply->errorString();
//    }
//    else {

//        QFile *file = new QFile("C:/Users/tiger/OneDrive/Рабочий стол/text.txt"); // Создаём объект для работы с файлом

//        if(file->open(QFile::ReadOnly)){ // Открываем файл для записи
//            file->isOpen();
//            file->write(reply->readAll());
//            file->close();
//        }
//    }
//}


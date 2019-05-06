#include "webappcontroller.h"
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QFile>
#include <QEvent>
#include <QEventLoop>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <friendsmodel.h>

WebAppController::WebAppController(QObject *QMLObject) : viewer(QMLObject)
{
    manager = new QNetworkAccessManager(this); // создаем менеджер, который будет отправлять запросы
    connect(manager, &QNetworkAccessManager::finished, this, &WebAppController::onRezult);
}

void WebAppController::onAuth(QString login, QString password){ // функция для авторизации в приложении и получения access token

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

    //QString str1(reply->readAll());

    qDebug() << "**** GET before loop ****";

    qDebug() << reply->readAll();

    loop.exec();

    qDebug() << "**** GET after loop ****";

    // Просмотр кода формы с помощью следующей команды:
    qDebug() << "**** reply header = " << reply->header(QNetworkRequest::LocationHeader).toString();
    QString str(reply->readAll()); // в переменной хранится весь текст html

    qDebug() << str; // выводим текст

    // делим форму авторизации (код)

         int ip_h_position = str.indexOf("ip_h");
         int _origin_position = str.indexOf("_origin");
         int lg_h_position = str.indexOf("lg_h");
         int to_position = str.indexOf("\"to");
                QString ip_h = str.mid(ip_h_position + 13, 18);
                qDebug() << "ip_h = " << ip_h;
                QString _origin = str.mid(_origin_position + 16, 20);
                qDebug() << "_origin = " << _origin;
                QString lg_h = str.mid(lg_h_position + 13, 18);
                qDebug() << "lg_h = " << lg_h;
                QString to = str.mid(to_position + 12, 212);
                qDebug() << "to = " << to;


    reply = manager
            ->get(QNetworkRequest(
                      QUrl("https://login.vk.com/"
                           "?act=login"
                           "&soft=1"
                           "&utf8=1"
                           "&lg_h=" + lg_h
                           + "&ip_h=" + ip_h
                           + "&to=" + to
                           + "&_origin=" + _origin
                           + "&email=" + login
                           + "&pass=" + password)));

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

       if (str.indexOf("access_token") != -1) // если все успешно
       {
           m_accessToken = str.split("access_token=")[1].split("&")[0]; // записываем наш access_token в переменную
           emit authorized();
           emit authSuccess();
           qDebug() <<  "*** m_accessToken" << m_accessToken.mid(0,85); // выводим часть полученного токена

           QObject* text_edit1 = viewer->findChild<QObject*>("text_edit1"); // находим элемент text_edit из qml-кода
           QObject* skrit = viewer->findChild<QObject*>("skrit");
           QObject* lbl_2 = viewer->findChild<QObject*>("lbl_2");
           skrit->setProperty("visible", false);
           lbl_2->setProperty("visible", true);
           lbl_2->setProperty("text", "Полученный токен (часть):");
           text_edit1->setProperty("visible", true);
           text_edit1->setProperty("text", m_accessToken.mid(0,20));
       }
       else{
           qDebug() << "Failed!"; // иначе выводим сообщение об ошибке
           QObject* lbl_3 = viewer->findChild<QObject*>("lbl_3");
           lbl_3->setProperty("visible", true);
           lbl_3->setProperty("text", "Введен невеный логин или пароль. попробуйте снова.");
           QObject* text_edit1 = viewer->findChild<QObject*>("text_edit1");
           text_edit1->setProperty("visible", false);
       }
}

void WebAppController::restRequest(){
    //manager = new QNetworkAccessManager(); // менеджер для доступа к сайту
    QEventLoop loop;

    QObject::connect(manager, // связываем loop  с нашим менеджером
                     SIGNAL(finished(QNetworkReply*)),
                     &loop,
                     SLOT(quit()));

    QNetworkReply * reply = manager->get(QNetworkRequest(QUrl("https://api.vk.com/method/friends.get?"// обращаемся к списку друзей
                                                              "out=0&"
                                                              "v=5.92&" // версия приложения
                                                              "order=random&" // в любом порядке
                                                              "count=10&" // выводим 10 человек
                                                              "fields=photo_100&" // критерий выборки
                                                              "access_token=" // добавляем наш access_token
                                                              + m_accessToken)));

    loop.exec();
    //QString friends(reply->readAll());
    //qDebug() << "*** Список друзей в формате json ***" << friends;

    // вся строка JSON с сервера грузится в QJsonDocument
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
    //QJsonDocument itemDoc = QJsonDocument::fromJson(friends.toUtf8());
    qDebug() << document;
    QJsonObject root = document.object();

    QJsonValue smth = root.value("response");
           // Если значение является массивом, ...
           if(smth.isArray()){
               // ... то забираем массив из данного свойства
               QJsonArray itog = smth.toArray();
               // Перебирая все элементы массива ...
               for(int i = 0; i < itog.count(); i++){
                   QJsonObject znach = itog.at(i).toObject();
                   // Забираем значения свойств имени и фамилии
                   QString first_name = znach.value("items").toString();
                   qDebug() << first_name;
               }
           }

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

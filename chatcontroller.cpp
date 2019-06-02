#include "chatcontroller.h"
#include <QObject>
#include <QtWebSockets>
#include <QEventLoop>
#include <QDateTime>

ChatController::ChatController(QObject *parent) : QObject(parent)
{

    chat_model = new ChatModel();
    // 1. создание websocket-сервера
    chatserver = new QWebSocketServer("Kate",
                                      QWebSocketServer::NonSecureMode,
                                      this);
    // соединение сервера слотами
    connect(chatserver, &QWebSocketServer::newConnection,
                      this, &ChatController::onNewConnection);
    chatserver->listen(QHostAddress::Any,55555);


}

void ChatController::onNewConnection(){

    pSocketIn = chatserver-> nextPendingConnection();

    pSocketIn->setParent(this);

    connect(pSocketIn, &QWebSocket::textMessageReceived,
            this, &ChatController::processMessage);
    connect(pSocketIn, &QWebSocket::disconnected,
            this, &ChatController::socketDisconnected);
    qDebug()<< "*** in connection";
    //m_clients << pSocketIn;
}

void ChatController::socketDisconnected(){
//    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
//    if (pClient)
//    {
//        m_clients.removeAll(pClient);
//        pClient->deleteLater();
//    }

    delete pSocketIn;
    pSocketIn = nullptr;
}


void ChatController::processMessage(const QString &message){

    qDebug()<< "Получено сообщение: " + message;

    QTime currTime = QTime::currentTime();
    QString time = currTime.toString("hh:mm:ss");
    qDebug() << "В такое время: " + time;


    QWebSocket *pSender = qobject_cast<QWebSocket *>(sender());

    QString sender = pSender->peerName();

    //QString sender = "PikVik";

    qDebug() << "Отправитель: " + sender;

    // TODO добавление в модель
    // 1) message
    // 2) даты/времени QDateTime::currentDateTime
    // 3) IP отправителя pSender->peerName();

    chat_model->addItem(ChatObject (sender, message, time));

    qDebug() << chat_model->ChatSender;
    qDebug() << chat_model->ChatMessage;
    qDebug() << chat_model->ChatTime;

     //qDebug() << sender;
}

void ChatController::sendMess(QString message){

    qDebug() << "Отправлено сообщение: " + message;

    QTime currTime = QTime::currentTime();
    QString time = currTime.toString("hh:mm:ss");
    qDebug() << time;

    QEventLoop loop;

    // открыть сокет
    QWebSocket * pClientOut = new QWebSocket("Kate");

    //QWebSocket *pSender = qobject_cast<QWebSocket *>(sender());
    //pSender->peerName();

    QString sender = "Kate";
    qDebug() << sender;

    chat_model->addItem(ChatObject (sender, message, time));

    qDebug() << chat_model->ChatSender;
    qDebug() << chat_model->ChatMessage;
    qDebug() << chat_model->ChatTime;

    QObject::connect(pClientOut,
                     SIGNAL(connected()),
                     &loop,
                     SLOT(quit()));

    pClientOut->open(QUrl("wss://192.168.11.2"));
    qDebug() << "***open()";
    loop.exec();
    qDebug() << "***ooooopened";
    pClientOut->sendTextMessage(message);
    qDebug() << "***sendTextMessage()";
    //pClientOut->disconnect();
    pClientOut->close();
}

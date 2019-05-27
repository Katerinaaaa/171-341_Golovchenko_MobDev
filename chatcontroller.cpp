#include "chatcontroller.h"
#include <QObject>
#include <QtWebSockets>
#include <QEventLoop>
#include <QDateTime>

ChatController::ChatController(QObject *parent) : QObject(parent)
{

    // 1. создание websocket-сервера
    chatserver = new QWebSocketServer("Kotik Labs",
                                      QWebSocketServer::NonSecureMode,
                                      this);
    // соединение сервера слотами
    chatserver->listen(QHostAddress::Any,7777);
    connect(chatserver, &QWebSocketServer::newConnection,
                      this, &ChatController::onNewConnection);


    // запуск сервера
    chatserver->listen(QHostAddress:: Any, 7777);


}

void ChatController::onNewConnection(){

    pSocketIn = chatserver-> nextPendingConnection();

    pSocketIn->setParent(this);

    connect(pSocketIn, &QWebSocket::textMessageReceived,
            this, &ChatController::processMessage);
    connect(pSocketIn, &QWebSocket::disconnected,
            this, &ChatController::socketDisconnected);

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


    QWebSocket *pSender = qobject_cast<QWebSocket *>(sender());
    pSender->peerName();

    // TODO добавление в модель
    // 1) message
    // 2) даты/времени QDateTime::currentDateTime
    // 3) IP отправителя pSender->peerName();

//    for (QWebSocket *pClient : qAsConst(m_clients)) {
//        if (pClient != pSender) //don't echo message back to sender
//            pClient->sendTextMessage(message);
//    }

     qDebug() << message;
      qDebug() << QDateTime::currentDateTime;
       qDebug() << pSender->peerName();
}

void ChatController::sendMess(QString message){

    qDebug() << "Отправлено сообщение: " + message;

    QEventLoop loop;

    // открыть сокет
    QWebSocket * pClientOut = new QWebSocket("Kotik Labs");

    connect(pClientOut, SIGNAL(connected()),
            &loop,  SLOT(quit));

    pClientOut->open(QUrl("wss://192.168.11.1/2"));
    loop.exec();

    pClientOut->sendTextMessage(message);
    //pClientOut->disconnect();
    pClientOut->close();
}

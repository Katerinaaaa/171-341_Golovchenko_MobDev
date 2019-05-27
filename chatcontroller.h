#ifndef CHATCONTROLLER_H
#define CHATCONTROLLER_H

#include <QObject>
#include <QtWebSockets>


class ChatController : public QObject{
    Q_OBJECT
public:
    explicit ChatController(QObject *parent = nullptr);
    QWebSocketServer *chatserver;
    QWebSocket *pSocketIn;
    QWebSocket *pSocketOut;



public slots:
    void onNewConnection();
    void socketDisconnected();
    void processMessage(const QString &message);
    void sendMess(QString message);
private:

};

#endif // CHATCONTROLLER_H

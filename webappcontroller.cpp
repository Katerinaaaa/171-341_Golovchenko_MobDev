 #include "webappcontroller.h"
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>

WebAppController::WebAppController(QObject *parent) : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
    connect(manager, &QNetworkAccessManager::finished, this, &WebAppController::replyFinish);
}

void WebAppController::replyFinish(QNetworkReply *reply){

        qDebug()<<reply->url();
        qDebug()<<reply->rawHeaderList();
        //qDebug()<<reply->readAll();

}

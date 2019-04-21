#ifndef WEBAPPCONTROLLER_H
#define WEBAPPCONTROLLER_H
#include <QObject>
#include <QNetworkAccessManager>



class WebAppController : public QObject
{
    Q_OBJECT
public:
    explicit WebAppController(QObject *parent = nullptr);
    QNetworkAccessManager *manager;
    void getPageInfo(){
         manager->get(QNetworkRequest(QUrl("https://www.gismeteo.ru/")));
    }
signals:

public slots:
    void replyFinish(QNetworkReply *reply);
    void onPageInfo(){}
};

#endif // WEBAPPCONTROLLER_H

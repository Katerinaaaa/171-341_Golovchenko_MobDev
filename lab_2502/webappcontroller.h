#ifndef WEBAPPCONTROLLER_H
#define WEBAPPCONTROLLER_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QFile>
#include <friendsmodel.h>
#include <QSqlDatabase>

class WebAppController : public QObject

{
    Q_OBJECT
public:
    explicit WebAppController(QObject *parent = nullptr);

    QNetworkAccessManager *manager;

    QString m_accessToken; // полученный access_token из вк

    void authorize(){ // приложение ВК
        const QString appID ="6935008";
        const QString protKey = "LfTDV7hmIZH7RASl3OwM";
        const QString servKey = "13d9cb7313d9cb7313d9cb73b413b01a93113d913d9cb734f728be64e1d7d1669e8e2b5";
    }
    FriendsModel *friends_model;

    //https://oauth.vk.com/authorize?client_id=6935008&redirect_uri=https://oauth.vk.com/blank.html&display=mobile&scope=friends&response_type=token&v=5.92&
    //access_token=52f4cc9179798359c0c22a79ddc83b1c69f30fee13922ec316d5828346189f6de78440a08693f50af8d8c
    //access_token=403a0fd69dde527029825bfd11664ebc795a6f4f7e8574f6f2d069ffe1acca7d5078f9dffef1f91919d28

signals:
    void authorized();
    void authSuccess();

public slots:
    void onPageInfo(QNetworkReply *reply);
    void onAuth(QString login, QString password); // авторизация в приложении
    //void onPageInfo(QNetworkReply *reply);
    void getPageInfo();
    //void readFile();
    void restRequest();
   // void getFriends();
    void db_write();
    void db_read();

protected:
QObject *viewer;

};

#endif // WEBAPPCONTROLLER_H

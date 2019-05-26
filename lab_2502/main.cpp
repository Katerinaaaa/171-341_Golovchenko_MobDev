#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "webappcontroller.h"
#include <QNetworkReply>
#include <QQmlContext>
#include "friendsmodel.h"
#include "cryptocontroller.h"
//#include <QtWebEngine>

int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

//    QtWebEngine::initialize();

    QQmlApplicationEngine engine; //движок


    QQmlContext *context = engine.rootContext(); // создаем объект класса QQmlContext

    WebAppController webApp;
       context->setContextProperty("friends_model", webApp.friends_model); //Перемещаемая модель, которой присваиваем имя
       context->setContextProperty("webApp", &webApp);

    CryptoController cryptoCont;
    //cryptoCont.encryptIt();
    //cryptoCont.decryptIt();

    //webApp.db_write();

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject::connect(engine.rootObjects().first(), SIGNAL(onAuth(QString, QString)),
    &webApp, SLOT(onAuth(QString, QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(restRequest()),
    &webApp, SLOT(restRequest()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(encryptIt(QString)),
    &cryptoCont, SLOT(encryptIt(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(decryptIt(QString)),
    &cryptoCont, SLOT(decryptIt(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(db_write()),
    &webApp, SLOT(db_write()));

    //связь C++ и Qml:
    QObject* root = engine.rootObjects()[0];
    WebAppController myV(root);
    engine.rootContext()->setContextProperty("_myV", &myV);

    //WebAppController wa;
    //wa.getPageInfo(); // вызов функцииы
    //wa.restRequest();

    return app.exec();
}

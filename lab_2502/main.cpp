#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "webappcontroller.h"
#include <QNetworkReply>
#include <QQmlContext>
#include "friendsmodel.h"

int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    //QtWebView::initialize();

    WebAppController webAppController;

    QQmlApplicationEngine engine; //движок

    QQmlContext *context = engine.rootContext(); // создаем объект класса QQmlContext
       //context->setContextProperty("m_items", &(webAppController.friends_model)); //Перемещаемая модель, которой присваиваем имя


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    //связь C++ и Qml:
    QObject* root = engine.rootObjects()[0];
    WebAppController myV(root);
    engine.rootContext()->setContextProperty("_myV", &myV);

    WebAppController wa;
    //wa.getPageInfo(); // вызов функцииы
    //wa.restRequest();

    return app.exec();
}

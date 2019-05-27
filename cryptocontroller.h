#ifndef CRYPTOCONTROLLER_H
#define CRYPTOCONTROLLER_H
#include <QObject>


class CryptoController : public QObject{
    Q_OBJECT
public:
    explicit CryptoController(QObject *parent = nullptr);

    public slots:
        void encryptIt(QString key);
        void decryptIt(QString key);
};

#endif // CRYPTOCONTROLLER_H

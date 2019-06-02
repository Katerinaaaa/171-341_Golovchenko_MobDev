#ifndef CRYPTOCONTROLLER_H
#define CRYPTOCONTROLLER_H
#include <QObject>


class CryptoController : public QObject{
    Q_OBJECT
public:
    explicit CryptoController(QObject *parent = nullptr);

    QString file_name;

    public slots:
        void encryptIt(QString key, QString name);
        void decryptIt(QString key);
        //void getFileName(QString name);

protected:
QObject *cry_viewer;
};

#endif // CRYPTOCONTROLLER_H

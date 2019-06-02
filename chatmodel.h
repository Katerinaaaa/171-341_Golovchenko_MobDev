#ifndef CHATMODEL_H
#define CHATMODEL_H

#include <QVariant>
#include <QObject>
#include <QList>
#include <QModelIndex>
#include <QAbstractListModel>


class ChatObject
{
public:
  ChatObject(const QString &p_sender,
               const QString &p_message,
               const QString &p_time);
   //
   QString getSender() const;
   QString getMessage() const;
   QString getTime() const;
private:
   QString m_sender;
   QString m_message;
   QString m_time;
};


class ChatModel : public QAbstractListModel{
    Q_OBJECT
public:
    enum enmRoles {
        ChatSender = Qt::UserRole + 1,
        ChatMessage,
        ChatTime
    };
    ChatModel(QObject *parent = nullptr);

    void addItem(const ChatObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const; // возвращает по индексу переменную (импользуется в ЛР 8)

    QVariantMap get(int idx) const;

    void clear();

 protected:
    QHash<int, QByteArray> roleNames() const;
    // ключ - значение
    // нужен, чтобы строковые имена приводить в соответствие к полям френда

 private:
   QList<ChatObject> m_item;

};

#endif // CHATMODEL_H

#include "chatmodel.h"
#include <QMap>

// TODO реализация конструктора и get-методов FriendObject простейшая, проработать самостоятельно

ChatObject::ChatObject(const QString &getSender, const QString &getMessage, const QString &getTime)
    :   m_sender(getSender),
        m_message(getMessage),
        m_time(getTime)
{
 //
}


ChatModel::ChatModel(QObject *parent) : QAbstractListModel(parent)
{
    //пусто
}

QString ChatObject::getSender() const{ // функция для получения имени друга
    return m_sender;
}

QString ChatObject::getMessage() const{ // функция для получения фамилии друга
    return m_message;
}

QString ChatObject::getTime() const{ // функция для получения фото друга
    return m_time;
}


void ChatModel::addItem(const ChatObject & newItem){
    // не изменяется
  // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_item << newItem;
    endInsertRows();
}

int ChatModel::rowCount(const QModelIndex &parent) const
{
    // не изменяется
   // метод используется ListView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_item.count();
}

QVariant ChatModel::data(const QModelIndex & index,
                                int role) const
{
     // метод используется в QML для получения значения одного поля под обозначением role одного элемента модели index
    if (index.row() < 0 || (index.row() >= m_item.count()))
        return QVariant();

    // TODO дописать выгрузку своих полей под своими обозначениями

    const ChatObject&itemToReturn = m_item[index.row()];
    if (role == ChatSender)
    return itemToReturn.getSender();
    else if (role == ChatMessage)
    return itemToReturn.getMessage();
    else if (role == ChatTime)
    return itemToReturn.getTime();

    return QVariant();
}

QHash<int, QByteArray> ChatModel::roleNames() const
{
    // метод используется в QML для сопоставления полей данных со строковыми названиями
     // TODO сопоставить полям данных строковые имена
    QHash<int, QByteArray> roles;

    roles[ChatSender] = "sender";
    roles[ChatMessage] = "message";
    roles[ChatTime] = "time";
    return roles;
}

QVariantMap ChatModel::get(int idx) const
{
    // не изменяется
   // метод используется ListView в QML для получения значений полей idx-го элемента модели
    QVariantMap map;
    foreach(int k, roleNames().keys())
    {
        map[roleNames().value(k)] = data(index(idx, 0), k);
    }
    return map;
}

void ChatModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    m_item.clear();
    endRemoveRows();
}


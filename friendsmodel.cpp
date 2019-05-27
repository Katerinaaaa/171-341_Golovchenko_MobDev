#include "friendsmodel.h"
#include <QMap>

// TODO реализация конструктора и get-методов FriendObject простейшая, проработать самостоятельно

FriendsObject::FriendsObject(const QString &getName, const QString &getSurname, const QUrl &getPhoto, const int &getId)
    :   m_name(getName),
        m_surname(getSurname),
        m_photo(getPhoto),
        m_friend_id(getId)
{
 //
}


FriendsModel::FriendsModel(QObject *parent) : QAbstractListModel(parent)
{
    //пусто
}

QString FriendsObject::getName() const{ // функция для получения имени друга
    return m_name;
}

QString FriendsObject::getSurname() const{ // функция для получения фамилии друга
    return m_surname;
}

QUrl FriendsObject::getPhoto() const{ // функция для получения фото друга
    return m_photo;
}

int FriendsObject::getId() const{ // функция для получения id друга
    return m_friend_id;
}

void FriendsModel::addItem(const FriendsObject & newItem){
    // не изменяется
  // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << newItem;
    endInsertRows();
}

int FriendsModel::rowCount(const QModelIndex &parent) const
{
    // не изменяется
   // метод используется ListView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant FriendsModel::data(const QModelIndex & index,
                                int role) const
{
     // метод используется в QML для получения значения одного поля под обозначением role одного элемента модели index
    if (index.row() < 0 || (index.row() >= m_items.count()))
        return QVariant();

    // TODO дописать выгрузку своих полей под своими обозначениями

    const FriendsObject&itemToReturn = m_items[index.row()];
    if (role == FriendName)
    return itemToReturn.getName();
    else if (role == FriendSurname)
    return itemToReturn.getSurname();
    else if (role == FriendPhoto)
    return itemToReturn.getPhoto();
    else if (role == Friend_id)
    return itemToReturn.getId();

    return QVariant();
}

QHash<int, QByteArray> FriendsModel::roleNames() const
{
    // метод используется в QML для сопоставления полей данных со строковыми названиями
     // TODO сопоставить полям данных строковые имена
    QHash<int, QByteArray> roles;

    roles[FriendName] = "name";
    roles[FriendSurname] = "surname";
    roles[FriendPhoto] = "photo";// TODO
    roles[Friend_id] = "friend_id";// TODO
    return roles;
}

QVariantMap FriendsModel::get(int idx) const
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

void FriendsModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    m_items.clear();
    endRemoveRows();
}


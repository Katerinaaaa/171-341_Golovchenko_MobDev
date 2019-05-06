#include "friendsmodel.h"
#include <QMap>

FriendsModel::FriendsModel(QObject *parent) : QAbstractListModel(parent)
{
    //пусто
}

void FriendsModel::addItem(const FriendObject & newItem){

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    friends_list << newItem;
    endInsertRows();
}

int FriendsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return friends_list.count();
}

//QVariant FriendsModel::data(const QModelIndex & index,
//                                int role) const
//{
//    if (index.row() < 0 || (index.row() >= friends_list.count()))
//        return QVariant();

//    const FriendObject&itemToReturn = friends_list[index.row()];
//    if (role == name)
//    return itemToReturn.getName();
//    else if (role == photo)
//    return itemToReturn.getPhoto();
//    else if (role == friend_id)
//    return itemToReturn.getFriend_id();

//    return QVariant();
//}

//QHash<int, QByteArray> FriendsModel::roleNames() const
//{
//    QHash<int, QByteArray> roles;
//    <<listRolesAndNames>>
//    return roles;
//}

QVariantMap FriendsModel::get(int idx) const
{
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
    friends_list.clear();
    endRemoveRows();
}


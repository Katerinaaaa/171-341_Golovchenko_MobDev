#ifndef FRIENDSMODEL_H
#define FRIENDSMODEL_H
#include <QVariant>
#include <QList>
#include <QModelIndex>
#include <QAbstractListModel>

class FriendObject
{
public:
   FriendObject(const QString &p_name,
               const QUrl &p_photo,
               const int &p_friend_id);
   //
   QString getName() const;
   QString getPhoto() const;
   QString getId() const;
   // прочие get-методы для выдачи ID, URL фотографии и др.
private:
   QString m_name;
   QUrl m_photo;
   int m_friend_id;
   // прочие свойства для хранения ID, URL фотографии и др.
};


class FriendsModel : public QAbstractListModel{
    Q_OBJECT
public:    
    enum enmRoles {
        name = Qt::UserRole + 1,
        photo,
        friend_id
    };
    FriendsModel(QObject *parent = nullptr);

    void addItem(const FriendObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    //QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    QVariantMap get(int idx) const;

    void clear();

 protected:
    //QHash<int, QByteArray> roleNames() const;
    // ключ - значение
    // нужен, чтобы строковые имена приводить в соответствие к полям френда

 private:

   QList<FriendObject> friends_list;

};

#endif // FRIENDSMODEL_H

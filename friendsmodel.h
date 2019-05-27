#ifndef FRIENDSMODEL_H
#define FRIENDSMODEL_H
#include <QVariant>
#include <QObject>
#include <QList>
#include <QModelIndex>
#include <QAbstractListModel>

class FriendsObject
{
public:
   FriendsObject(const QString &p_name,
               const QString &p_surname,
               const QUrl &p_photo,
               const int &p_friend_id);
   //
   QString getName() const;
   QString getSurname() const;
   QUrl getPhoto() const;
   int getId() const;
   // прочие get-методы для выдачи ID, URL фотографии и др.
private:
   QString m_name;
   QString m_surname;
   QUrl m_photo;
   int m_friend_id;
   // прочие свойства для хранения ID, URL фотографии и др.
};


class FriendsModel : public QAbstractListModel{
    Q_OBJECT
public:    
    enum enmRoles {
        FriendName = Qt::UserRole + 1,
        FriendSurname,
        FriendPhoto,
        Friend_id
    };
    FriendsModel(QObject *parent = nullptr);

    void addItem(const FriendsObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const; // возвращает по индексу переменную (импользуется в ЛР 8)

    QVariantMap get(int idx) const;

    void clear();

 protected:
    QHash<int, QByteArray> roleNames() const;
    // ключ - значение
    // нужен, чтобы строковые имена приводить в соответствие к полям френда

 private:

   QList<FriendsObject> m_items;

};

#endif // FRIENDSMODEL_H

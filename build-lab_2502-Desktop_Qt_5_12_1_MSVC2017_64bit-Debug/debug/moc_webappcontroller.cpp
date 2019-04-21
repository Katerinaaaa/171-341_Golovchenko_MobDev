/****************************************************************************
** Meta object code from reading C++ file 'webappcontroller.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../lab_2502/webappcontroller.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'webappcontroller.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_WebAppController_t {
    QByteArrayData data[13];
    char stringdata0[115];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_WebAppController_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_WebAppController_t qt_meta_stringdata_WebAppController = {
    {
QT_MOC_LITERAL(0, 0, 16), // "WebAppController"
QT_MOC_LITERAL(1, 17, 10), // "authorized"
QT_MOC_LITERAL(2, 28, 0), // ""
QT_MOC_LITERAL(3, 29, 11), // "authSuccess"
QT_MOC_LITERAL(4, 41, 8), // "onRezult"
QT_MOC_LITERAL(5, 50, 14), // "QNetworkReply*"
QT_MOC_LITERAL(6, 65, 5), // "reply"
QT_MOC_LITERAL(7, 71, 3), // "Rez"
QT_MOC_LITERAL(8, 75, 4), // "Auth"
QT_MOC_LITERAL(9, 80, 5), // "login"
QT_MOC_LITERAL(10, 86, 8), // "password"
QT_MOC_LITERAL(11, 95, 10), // "onPageInfo"
QT_MOC_LITERAL(12, 106, 8) // "readFile"

    },
    "WebAppController\0authorized\0\0authSuccess\0"
    "onRezult\0QNetworkReply*\0reply\0Rez\0"
    "Auth\0login\0password\0onPageInfo\0readFile"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_WebAppController[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   49,    2, 0x06 /* Public */,
       3,    0,   50,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    1,   51,    2, 0x0a /* Public */,
       7,    1,   54,    2, 0x0a /* Public */,
       8,    2,   57,    2, 0x0a /* Public */,
      11,    0,   62,    2, 0x0a /* Public */,
      12,    0,   63,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 5,    6,
    QMetaType::Void, 0x80000000 | 5,    6,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    9,   10,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void WebAppController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<WebAppController *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->authorized(); break;
        case 1: _t->authSuccess(); break;
        case 2: _t->onRezult((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 3: _t->Rez((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 4: _t->Auth((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 5: _t->onPageInfo(); break;
        case 6: _t->readFile(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (WebAppController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&WebAppController::authorized)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (WebAppController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&WebAppController::authSuccess)) {
                *result = 1;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject WebAppController::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_WebAppController.data,
    qt_meta_data_WebAppController,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *WebAppController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *WebAppController::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_WebAppController.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int WebAppController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
    return _id;
}

// SIGNAL 0
void WebAppController::authorized()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void WebAppController::authSuccess()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE

#include "cryptocontroller.h"
#include <QFile>
#include <QIODevice>
#include <QObject>
#include <QDebug>
#include <QFile>

#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <openssl/aes.h>


CryptoController::CryptoController(QObject *QMLObject) : cry_viewer(QMLObject)
{
    // пусто
}

//void CryptoController::getFileName(QString name){

//    qDebug() << " Этот файл "+ name;

//    int j = 0;
//    if((j = name.indexOf("file:///", j)) != -1) {
//        file_name = name.mid( j + 8);
//        qDebug() << "Теперь такое имя: " + file_name;

//        QFile file_1(file_name); // исходный файл с текстом, который мы будем шифровать
//        file_1.open(QIODevice::ReadOnly); // этот файл открыт только для чтения, изменять его нельзя
//        QString str = file_1.readAll();
//        QObject* our_text = cry_viewer->findChild<QObject*>("our_text"); // находим объект, в который будет записан текст
//        our_text->setProperty("text", str); // задаем параметр "текст" для text_area из qml-кода

//    }
//    else{
//        qDebug() << "Failed!"; // иначе выводим сообщение об ошибке
//        return;
//    }
//}

void CryptoController::encryptIt(QString key, QString name){
    qDebug() << " Этот файл "+ name;

    int j = 0;
    if((j = name.indexOf("file:///", j)) != -1) {
        file_name = name.mid( j + 8);
        qDebug() << "Теперь такое имя: " + file_name;
    }
    else{
        qDebug() << "Failed!"; // иначе выводим сообщение об ошибке
        return;
    }

    unsigned char encryptedtext[256] = {0}; // зашифрованный результат out
    unsigned char decryptedtext[256] = {0}; // расшифрованный текст in

    qDebug() << file_name;

    QFile file_1(file_name); // исходный файл с текстом, который мы будем шифровать
    file_1.open(QIODevice::ReadOnly); // этот файл открыт только для чтения, изменять его нельзя


    QFile file_2("C:/Users/tiger/OneDrive/Рабочий стол/encrypt.txt"); // файл, в котором будет наш зашифрованный текст из иходного файла 1
    file_2.open(QIODevice::ReadWrite); // этот файл открыт только для записи


    //unsigned char key[] = "B374A26A71490437AA024E4FADD5B497"; // пароль (ключ), в последствии будет запрашиваться у пользователя
    unsigned char iv[] = "7E892875A52C59A3"; // инициализирующий вектор


    // 1. Создаётся указатель на несуществующую структуру
    EVP_CIPHER_CTX *ctx; // structure

    // 2. Для указателя создаётся пустая структура настроек (метод, ключ, вектор инициализации и т.д.)
    ctx = EVP_CIPHER_CTX_new(); // создание структуры с настройками метода

    // 3. Структура EVP_CIPHER_CTX наполняется настройками
    EVP_EncryptInit_ex(ctx, // инициализация методом AES, ключом и вектором
                       EVP_aes_256_cbc(), // алгоритм шифрования AES
                       NULL,
                       (unsigned char*)key.toLatin1().data(), // ключ шифрования
                       iv); // вектор

    // 4. САМ ПРОЦЕСС ШИФРОВАНИЯ - ФУНКЦИЯ EVP_EncryptUpdate

    // считывание первого блока
    int len1 = file_1.read((char *)decryptedtext, 256); // длина текста, который будем шифровать
    int len2 = 256;
    int smth = 0;
    // СОБСТВЕННО, ШИФРОВАНИЕ

    while (len1>0) // цикл, пока из файла что-то считывается (пока размер считанной порции > 0)
    {
        EVP_EncryptUpdate(ctx, // если произошла ошибка при шифровании
                              encryptedtext, //выходной параметр : ссылка, куда
                              &len2,
                              decryptedtext, // входной параметр: что шифровать
                              len1);

        // если ошибки не произошло, то записываем в цикле зашифрованный текст в наш второй файл

        file_2.write((char*)encryptedtext, len2);
        len1 = file_1.read((char*)decryptedtext, 256);

    }
    // 5. Финализация процесса шифрования
    //int cryptedtext_len = len2;
    EVP_EncryptFinal_ex(ctx, encryptedtext, &smth);
    //cryptedtext_len += len2;
    file_2.write((char*)encryptedtext, smth);

    // 6. Удаление структуры
    EVP_CIPHER_CTX_free(ctx);

    file_2.close(); // после оконончания работы алгоритма шифрования мы закрываем файлы, с которыми работали
    file_1.close();

    // открытие зашифрованного файла и вывод зашифрованного текста на экран
    file_2.open(QIODevice::ReadOnly);
    QString encr = file_2.readAll();
    qDebug() << encr;
    QObject* our_text = cry_viewer->findChild<QObject*>("our_text"); // находим объект, в который будет записан текст
    our_text->setProperty("text", encr); // задаем параметр "текст" для text_area из qml-кода
    file_2.close();

    return;
}

void CryptoController::decryptIt(QString key){


//    unsigned char *plaintext = (unsigned char *)"Some text Some text Some text Some text"; // исходный текст
//	int plaintext_len = strlen((char *)plaintext); // длина текста
//	unsigned char *key = (unsigned char *)"0123456789"; // пароль (ключ)
//	unsigned char *iv = (unsigned char *)"0123456789012345"; // инициализирующий вектор
//	unsigned char cryptedtext[256]; // зашифрованный результат
//	unsigned char decryptedtext[256]; // расшифрованный результат

//	// 1. Создаётся указатель на несуществующую структуру
//	EVP_CIPHER_CTX *ctx; // structure

//	// 3. Структура EVP_CIPHER_CTX наполняется настройками
//	EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv); // инициализация методом AES, ключом и вектором

//	// 4. САМ ПРОЦЕСС ШИФРОВАНИЯ - ФУНКЦИЯ EVP_EncryptUpdate
//	int len;
//	EVP_EncryptUpdate(ctx, cryptedtext, &len, plaintext, plaintext_len); // СОБСТВЕННО, ШИФРОВАНИЕ
//	int cryptedtext_len = len;

//	// 5. Финализация процесса шифрования
//	EVP_EncryptFinal_ex(ctx, cryptedtext + len, &len);
//	cryptedtext_len += len;

//	// 6. Удаление структуры
//	EVP_CIPHER_CTX_free(ctx);
//	for (int i = 0; i < cryptedtext_len; i++)
//	{
//			cout << hex << cryptedtext[i];
//			if ((i + 1) % 32 == 0) cout << endl;
//	}

    //unsigned char key[] = "B374A26A71490437AA024E4FADD5B497"; // пароль (ключ), в последствии будет запрашиваться у пользователя
    unsigned char iv[] = "7E892875A52C59A3"; // инициализирующий вектор
    unsigned char encryptedtext[256] = {0}; // зашифрованный результат out
    unsigned char decryptedtext[256] = {0}; // расшифрованный текст in




    QFile file_1("C:/Users/tiger/OneDrive/Рабочий стол/encrypt.txt"); // исходный файл с текстом, который мы будем шифровать
    file_1.open(QIODevice::ReadOnly); // этот файл открыт только для чтения, изменять его нельзя

    QString encr = file_1.readAll();
    qDebug() << encr; // вывод зашифрованного текста в debug


    // 1. Создаётся указатель на несуществующую структуру
    EVP_CIPHER_CTX *ctx; // structure

    ctx = EVP_CIPHER_CTX_new(); // создание структуры с настройками метода

    // 3. Структура EVP_CIPHER_CTX наполняется настройками
    EVP_DecryptInit_ex(ctx, // инициализация методом AES, ключом и вектором
                       EVP_aes_256_cbc(), // алгоритм шифрования AES
                       NULL,
                       (unsigned char*)key.toLatin1().data(), // ключ шифрования
                       iv); // вектор


    int len;
    //int cryptedtext_len = len;
    int cryptedtext_len = file_1.read((char *)encryptedtext, 256);
    EVP_DecryptUpdate(ctx, decryptedtext, &len, encryptedtext, cryptedtext_len); // СОБСТВЕННО, ШИФРОВАНИЕ

    // 4.
    int dectypted_len = len;
    EVP_DecryptFinal_ex(ctx, decryptedtext + len, &len);

    // 5.
    dectypted_len += len;
    EVP_CIPHER_CTX_free(ctx);
    decryptedtext[dectypted_len] = '\0';
    qDebug() << decryptedtext;



//    QFile file_2("C:/Users/tiger/OneDrive/Рабочий стол/decrypt.txt"); // файл, в котором будет наш зашифрованный текст из иходного файла 1
//    file_2.open(QIODevice::WriteOnly); // этот файл открыт только для записи



//    // 4. САМ ПРОЦЕСС ШИФРОВАНИЯ - ФУНКЦИЯ EVP_EncryptUpdate

//    // считывание первого блока
//    int len1 = file_1.read((char *)decryptedtext, 256); // длина текста, который будем шифровать
//    int len2 = 256;
//    int smth = 0;
//    // СОБСТВЕННО, ШИФРОВАНИЕ


//    while (len1>0) // цикл, пока из файла что-то считывается (пока размер считанной порции > 0)
//    {
//        EVP_DecryptUpdate(ctx, // если произошла ошибка при шифровании
//                              encryptedtext, //выходной параметр : ссылка, куда
//                              &len2,
//                              decryptedtext, // входной параметр: что шифровать
//                              len1);

//        // записываем в цикле зашифрованный текст в наш второй файл

//        file_2.write((char*)encryptedtext, len2);
//        len1 = file_1.read((char*)decryptedtext, 256);

//    }
//    // 5. Финализация процесса шифрования
//    EVP_DecryptFinal_ex(ctx, encryptedtext, &smth);
//    file_2.write((char*)encryptedtext, smth);
//    // 6. Удаление структуры
//    EVP_CIPHER_CTX_free(ctx);
//    file_2.close(); // после оконончания работы алгоритма шифрования мы закрываем файлы, с которыми работали
//    file_1.close();
//    return;
}

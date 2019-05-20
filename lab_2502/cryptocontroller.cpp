#include "cryptocontroller.h"
#include <QFile>
#include <QIODevice>
#include <QObject>

#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <openssl/aes.h>


CryptoController::CryptoController(QObject *parent) : QObject(parent)
{
    // пусто
}

void CryptoController::encryptIt(QString key){

    unsigned char encryptedtext[256] = {0}; // зашифрованный результат out
    unsigned char decryptedtext[256] = {0}; // расшифрованный текст in

    QFile file_1("C:/Users/tiger/OneDrive/Рабочий стол/file.txt"); // исходный файл с текстом, который мы будем шифровать
    file_1.open(QIODevice::ReadOnly); // этот файл открыт только для чтения, изменять его нельзя

    QFile file_2("C:/Users/tiger/OneDrive/Рабочий стол/encrypt.txt"); // файл, в котором будет наш зашифрованный текст из иходного файла 1
    file_2.open(QIODevice::WriteOnly); // этот файл открыт только для записи


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
    return;

}

void CryptoController::decryptIt(QString key){

    unsigned char encryptedtext[256] = {0}; // зашифрованный результат out
    unsigned char decryptedtext[256] = {0}; // расшифрованный текст in

    QFile file_1("C:/Users/tiger/OneDrive/Рабочий стол/encrypt.txt"); // исходный файл с текстом, который мы будем шифровать
    file_1.open(QIODevice::ReadOnly); // этот файл открыт только для чтения, изменять его нельзя

    QFile file_2("C:/Users/tiger/OneDrive/Рабочий стол/decrypt.txt"); // файл, в котором будет наш зашифрованный текст из иходного файла 1
    file_2.open(QIODevice::WriteOnly); // этот файл открыт только для записи


    //unsigned char key[] = "B374A26A71490437AA024E4FADD5B497"; // пароль (ключ), в последствии будет запрашиваться у пользователя
    unsigned char iv[] = "7E892875A52C59A3"; // инициализирующий вектор


    // 1. Создаётся указатель на несуществующую структуру
    EVP_CIPHER_CTX *ctx; // structure

    // 2. Для указателя создаётся пустая структура настроек (метод, ключ, вектор инициализации и т.д.)
    ctx = EVP_CIPHER_CTX_new(); // создание структуры с настройками метода

    // 3. Структура EVP_CIPHER_CTX наполняется настройками
    EVP_DecryptInit_ex(ctx, // инициализация методом AES, ключом и вектором
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
        EVP_DecryptUpdate(ctx, // если произошла ошибка при шифровании
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
    EVP_DecryptFinal_ex(ctx, encryptedtext, &smth);
    //cryptedtext_len += len2;
    file_2.write((char*)encryptedtext, smth);
    // 6. Удаление структуры
    EVP_CIPHER_CTX_free(ctx);
    file_2.close(); // после оконончания работы алгоритма шифрования мы закрываем файлы, с которыми работали
    file_1.close();
    return;
}

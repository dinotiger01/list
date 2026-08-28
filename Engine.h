//
// Created by FFlyingFish on 8/18/26.
//

#ifndef QTQMLCPPAPP_ENGINE_H
#define QTQMLCPPAPP_ENGINE_H


#include <QObject>
#include <QtQml>
#include <QString>

namespace  Engine {
    class EngineMod: public QObject {
        Q_OBJECT
        QML_ELEMENT
    public:
        explicit EngineMod(QObject *parent = nullptr) : QObject(parent){}
        Q_INVOKABLE void setPar(QObject* par, QObject* crate);
        Q_INVOKABLE void testing();
        Q_INVOKABLE void setBulkCreate(QObject* obj, QString type);
        Q_INVOKABLE void refrechAll();
        Q_INVOKABLE void creatTask(QString name, int pry, int rep, int delay, QString due, QString notes, QString people, QString type, bool edit);
        Q_INVOKABLE QString getPersonName(int i, QObject* obj);
        Q_INVOKABLE int getPersonSize();
        Q_INVOKABLE QString getTypeName(int i, QObject* obj);
        Q_INVOKABLE int getTypeSize();
        Q_INVOKABLE QString getPryName(int i, QObject* obj);
        Q_INVOKABLE int getPrySize();
        Q_INVOKABLE QString getCurrentDate();
        Q_INVOKABLE void deleter(QObject* taskToDelete, int dex);
        Q_INVOKABLE void editOpen(int dex);
        Q_INVOKABLE void editClose();
        Q_INVOKABLE void permDel();
        void setEng(QQmlEngine* engin);
        int sqlPullTask();
        void sqlPullPeople();
        void sqlPullPry();
        void loadTasks();
        void addTask(int addTask);
        void addPry(int addedPry);
        void sqlComd();
    };
}


#endif //QTQMLCPPAPP_ENGINE_H

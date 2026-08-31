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
        Q_INVOKABLE void setPar(QObject* par, QObject* crate, QObject* tot);
        Q_INVOKABLE void testing();
        Q_INVOKABLE void setBulkCreate(QObject* obj, QString type);
        Q_INVOKABLE void refrechAll();
        Q_INVOKABLE void creatTask(QString name, int pry, int rep, int delay, QString due, QString notes, QString people, QString type, bool edit);
        Q_INVOKABLE void createType(QString name, int dex, QString old);
        Q_INVOKABLE void createPerson(int dex, QString name, QString php, QString reqHr);
        Q_INVOKABLE void updateFilter(QString name, QString peps, QString types, QString dates);

        Q_INVOKABLE QString getPersonName(int i, QObject* obj);
        Q_INVOKABLE int getPersonSize();
        Q_INVOKABLE int getPersonDex(int i);
        Q_INVOKABLE QString getPersonPhp(int i);

        Q_INVOKABLE QString getTypeName(int i, QObject* obj);
        Q_INVOKABLE int getTypeSize();
        Q_INVOKABLE int getTypeDex(int i);

        Q_INVOKABLE QString getPryName(int i, QObject* obj);
        Q_INVOKABLE int getPrySize();

        Q_INVOKABLE QString getCurrentDate();

        Q_INVOKABLE void deletePerson(int dex);
        Q_INVOKABLE void deleteType(int dex);
        Q_INVOKABLE void deleter(QObject* taskToDelete, int dex);
        Q_INVOKABLE void editOpen(int dex);
        Q_INVOKABLE void editClose();
        Q_INVOKABLE void permDel();
        Q_INVOKABLE void setFilter(QString name, QVariantList pep, QStringList type, QStringList dates);
        Q_INVOKABLE void initFilter(QObject* typ, QObject* pe);

        void setEng(QQmlEngine* engin);
        int sqlPullTask();
        void sqlPullPeople();
        void sqlPullPry();
        void sqlPullType();
        Q_INVOKABLE void sqlPullFilt();
        void loadTasks();
        void addTask(int addTask);
        void addPry(int addedPry);
        void sqlComd();
    };
}


#endif //QTQMLCPPAPP_ENGINE_H

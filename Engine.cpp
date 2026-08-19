//
// Created by FFlyingFish on 8/18/26.
//

#include "Engine.h"
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQuickItem>
#include <QVariantMap>
#include <ctime>
#include <QString>
#include <string>
#include <iostream>
#include <QObject>
using namespace std;

namespace  Engine {
    struct task{
        string name;
        int pry;
        bool isReturn;
        int delay;
        time_t date;
        string notes;
        string type;
        vector<string> people;
    };
    vector<task> all_tasks;
    QQmlEngine* eng;

    // quick test
    int ind = 0;

    void EngineMod::setEng(QQmlEngine* engin) {
        eng = engin;
        task testTask;
        testTask.name = "test";
        testTask.pry = 0;
        testTask.isReturn = false;
        testTask.delay = 1;
        testTask.notes = "asd\nasd";
        testTask.type = "main";
        testTask.people = {"red","pink","green"};
        all_tasks.push_back(testTask);

        task testTask1;
        testTask1.name = "test1";
        testTask1.pry = 0;
        testTask1.isReturn = false;
        testTask1.delay = 1;
        testTask1.notes = "yeah\na;aldskf;lksad";
        testTask1.type = "second";
        testTask1.people = {"red","blue","green"};
        all_tasks.push_back(testTask1);

        task testTask2;
        testTask2.name = "test2";
        testTask2.pry = 0;
        testTask2.isReturn = false;
        testTask2.delay = 1;
        testTask2.notes = "asdasd\nasd";
        testTask2.type = "main";
        testTask2.people = {"purple","pink","green"};
        all_tasks.push_back(testTask2);
    }
    void EngineMod::setPar(QObject *par) {
        asd(par);
    }

    void EngineMod::asd(QObject* par) {

        QQmlComponent component(eng, QUrl(QStringLiteral("../QML/taskQml.qml")));

        QVariantMap taskProp;
        taskProp["taskName"] = QString::fromStdString(all_tasks[ind].name);
        taskProp["peopleInt"] = static_cast<int>(all_tasks[ind].people.size());
        QStringList qPeople;
        for (const auto& person : all_tasks[ind].people) {
            qPeople.append(QString::fromStdString(person));
        }
        taskProp["peopleImgs"] = qPeople;
        taskProp["taskType"] = QString::fromStdString(all_tasks[ind].type);
        taskProp["taskDate"] = QString::fromStdString(all_tasks[ind].type);
        taskProp["taskNotes"] = QString::fromStdString(all_tasks[ind].notes);


        QObject* newTaskQml = component.createWithInitialProperties(taskProp, eng->rootContext());

        if (!newTaskQml) {
            qWarning() << "Failed to create:" << component.errors();
            return;
        }
        newTaskQml->setParent(par);
        QQmlEngine::setObjectOwnership(newTaskQml, QQmlEngine::CppOwnership);

        QQuickItem* parentItem = qobject_cast<QQuickItem*>(par);
        QQuickItem* childItem = qobject_cast<QQuickItem*>(newTaskQml);

        if (parentItem && childItem) {
            childItem->setParentItem(parentItem);
        }
        ind++;
    }

};



//
// Created by FFlyingFish on 8/18/26.
//

#include "Engine.h"
#include <sstream>
#include <fstream>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQuickItem>
#include <QVariantMap>
#include <ctime>
#include <QString>
#include <string>
#include <iostream>
#include <QObject>
#include <sqlite3.h>
using namespace std;

namespace  Engine {
    struct people {
        string name;
        string php;
        vector<float> reqHr;
    };

    struct task{
        string name;
        int pry;
        bool isReturn;
        int delay;
        time_t date;
        string notes;
        string type;
        vector<people> peoples;
    };

    vector<task> all_tasks;
    vector<people> all_people;



    QObject* listPar;
    QQmlEngine* eng;

    // quick test
    int ind = 0;

    void EngineMod::setEng(QQmlEngine* engin) {
        eng = engin;
        sqlAllTask();
    }
    void EngineMod::setPar(QObject *par) {
        listPar = par;
    }

    static int callback(void* data, int argc, char** argv, char** azColName)
    {
        int i;
        fprintf(stderr, "%s: ", (const char*)data);

        for (i = 0; i < argc; i++) {
            printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
        }

        printf("\n");
        return 0;
    }


    void EngineMod::sqlAllTask() {
        sqlite3* DB;
        int exit = 0;
        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);
        // make table

        // string sql =  "CREATE TABLE TASKS("
        //               "ID INT PRIMARY KEY NOT NULL, "
        //               "NAME TEXT NOT NULL, "
        //               "PRY INT NOT NULL, "
        //               "REPEATE INT NOT NULL, "
        //               "HOWLONG INT, "
        //               "WHE TEXT,"
        //               "NOTE TEXT);";

        // string sql = "DROP TABLE TASKS";

        string query = "select * from TASKS";

        sqlite3_exec(DB, query.c_str(), callback, NULL ,NULL);

        // string sql= "INSERT INTO TASKS VALUES(7, 'one', 1, 0, 2, '1/1/1', 'note');"
        //        "INSERT INTO TASKS VALUES(8, 'two', 2, 0, 1, '1/1/1', 'notes');"
        //        "INSERT INTO TASKS VALUES(9, 'three', 3, 1, 4, '1/1/1', 'npter');";


        char* messageError;
        // exit = sqlite3_exec(DB, sql.c_str(),NULL, 0, &messageError);

        if (exit != SQLITE_OK) {
            cerr << sqlite3_errmsg(DB) << endl;

        }else {
            cout << "it is open" << endl;
            sqlite3_exec(DB, query.c_str(), callback, NULL, NULL);
        }
        sqlite3_close(DB);
    }

    void addTask(QObject* par, task addTask) {

        string date = ctime(&all_tasks[ind].date);

        QQmlComponent component(eng, QUrl(QStringLiteral("../QML/taskQml.qml")));

        QVariantMap taskProp;
        taskProp["taskName"] = QString::fromStdString(all_tasks[ind].name);
        // taskProp["peopleInt"] = static_cast<int>(all_tasks[ind].people.size());
        QStringList qPeople;
        taskProp["peopleImgs"] = qPeople;
        taskProp["taskType"] = QString::fromStdString(all_tasks[ind].type);
        taskProp["taskDate"] = QString::fromStdString(date);
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



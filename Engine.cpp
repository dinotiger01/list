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
// #include <chrono>
// #include <thread>
#include <sqlite3.h>
#include <QtConcurrent>
#include <QEventLoop>

using namespace std;

namespace  Engine {
    struct people {
        int dex;
        string name;
        string php;
        vector<float> reqHr;
    };

    struct task{
        int dex;
        string name;
        int pry;
        bool isReturn;
        int delay;
        time_t date;
        string notes;
        string type;
        vector<int> peoples;
    };

    struct pryority {
        int dex;
        string name;
        int r;
        int g;
        int b;
        QObject* dir;
    };

    vector<task> all_tasks;
    vector<people> all_people;
    vector<string> all_type = {"main", "work", "passoin"};
    vector<pryority> all_pry;
    vector<QObject*> all_loaded;



    QObject* listPar;
    QObject* crate;
    QQmlEngine* eng;
    // sql
    sqlite3* DB;

    // quick test
    int ind = 2;


    //returns
    QString EngineMod::getPersonName(int i) {
        return QString::fromStdString(all_people[i].php);
    }
    int EngineMod::getPersonSize() {
        return all_people.size();
    }
    QString EngineMod::getTypeName(int i) {
        return QString::fromStdString(all_type[i]);
    }
    int EngineMod::getTypeSize() {
        return all_type.size();
    }
    QString EngineMod::getPryName(int i) {
        return QString::fromStdString(all_pry[i].name);
    }
    int EngineMod::getPrySize() {
        return all_pry.size();
    }
    // declars
    void EngineMod::setEng(QQmlEngine* engin) {
        eng = engin;
    }
    // start
    void EngineMod::setPar(QObject *par, QObject* crat) {
        listPar = par;
        crate = crat;

    }

    //sql
    // like how do i add a vector

    //TASK
    // int ID
    // text NAME
    // int PRY
    // int REAPEATE if is 2 it is able to have multi
    // int HOWLONG
    // vector pep
    // text WHE
    // text NOTE

    static int callback(void* data, int argc, char** argv, char** azColName)
    {
        //this code was coped from https://www.geeksforgeeks.org/cpp/sql-using-c-c-and-sqlite/
        //it was edited to conver to c++ variables
        //data - idk
        // argc - how many data per thing
        // argv - vector of the data
        // azColName - vector name of the data
        task newTask;

        for (int i = 0; i < argc; i++) {
            // cout << azColName[i] << " : " << argv[i] << endl;
            const string idkman = azColName[i];
            if (idkman == "ID"){
                newTask.dex = stoi(argv[i]);
            }else if (idkman == "NAME") {
                newTask.name = argv[i];
            }else if (idkman == "PRY") {
                newTask.pry = stoi(argv[i]);
            }else if (idkman == "REPEATE") {
                newTask.isReturn = stoi(argv[i]);
            }else if (idkman == "HOWLONG") {
                newTask.delay = stoi(argv[i]);
            }else if (idkman == "WHE") {
                struct tm datetime;
                // yyyy/mm/dd/
                time_t temp;
                string stringer = argv[i];
                string tstring;
                int k = 0;
                for (int j = 0; j < stringer.size(); j++) {
                    if (stringer[j] == '/') {
                        try {
                            int tint = stoi(tstring);
                            cout << tint << " : " << k << endl;
                            if (k == 0) {
                                datetime.tm_year = 2026 - 1900;
                            }else if (k == 1) {
                                datetime.tm_mon = 7;
                            }else if (k == 2) {
                                datetime.tm_mday = 22;
                            }else {
                                cerr << "you messed up ngl";
                            }
                            k++;
                        }catch(exception &e) {
                            cerr << e.what();
                        }
                        tstring = "";
                    }else {
                        tstring += stringer[j];
                    }
                }
                datetime.tm_hour = 0;
                datetime.tm_min = 0;
                datetime.tm_sec = 0;
                datetime.tm_isdst = -1;
                cout << datetime.tm_year << " : " << datetime.tm_mon << " : " << datetime.tm_mday << endl;
                temp = mktime(&datetime);
                cout << ctime(&temp) << endl;
                newTask.date = temp;

            }else if (idkman == "NOTE") {
                newTask.notes = argv[i];
            }else if (idkman == "PEOPLE") {
                vector<int> tempt;
                string stringer = argv[i];
                string tstring;
                for (int j = 0; j < stringer.size(); j++) {
                    if (stringer[j] == ',') {
                        try {
                            int tint = stoi(tstring);
                            tempt.push_back(tint);

                        }catch(exception &e) {
                            cerr << e.what();
                        }
                        tstring = "";
                    }else {
                        tstring += stringer[j];
                    }
                }
                newTask.peoples = tempt;
            }else if (idkman == "TYPE") {
                newTask.type = argv[i];
            }else {
                cerr << "idk man good luck : " <<azColName[i] << endl;
            }
        }
        all_tasks.push_back(newTask);

        return 0;
    }

    static int callbackP(void* data, int argc, char** argv, char** azColName) {
        people newperson;
        for (int i = 0; i < argc;i++) {
            // cout << azColName[i] << " : " << argv[i] << endl;
            string tempName = azColName[i];
            if (tempName == "ID") {
                newperson.dex = stoi(argv[i]);
            }else if (tempName == "NAME") {
                newperson.name = argv[i];
            }else if (tempName == "PFP") {
                newperson.php = argv[i];
            }else if (tempName == "REQHR") {
                // later
            }else {
                cerr << "no this is wrong : " << tempName;
            }
        }
        all_people.push_back(newperson);

        return 0;
    }

    static int callbackPRY(void* data, int argc, char** argv, char** azColName) {
        pryority newPry;
        for (int i = 0; i < argc;i++) {
            // cout << azColName[i] << " : " << argv[i] << endl;
            string tempName = azColName[i];
            if (tempName == "DEX") {
                newPry.dex = stoi(argv[i]);
            }else if (tempName == "NAME") {
                newPry.name = argv[i];
            }else if (tempName == "R") {
                newPry.r = stoi(argv[i]);
            }else if (tempName == "G") {
                newPry.g = stoi(argv[i]);
            }else if (tempName == "B") {
                newPry.b = stoi(argv[i]);
            }else {
                cerr << "no this is wrong : " << tempName;
            }
        }
        all_pry.push_back(newPry);

        return 0;
    }

    void EngineMod::sqlPullPeople() {
        // define stuff
        int exit = 0;
        // open
        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);
        // sql sertch
        string query = "select * from PEOPLE";
        sqlite3_exec(DB, query.c_str(), callbackP, NULL , NULL);

        // debog stuff
        if (exit != SQLITE_OK) {
            cerr << "sqlPullPeople: " << sqlite3_errmsg(DB) << endl;

        }else {
            cout << "it is open" << endl;
        }
        // close
        sqlite3_close(DB);
    }

    int EngineMod::sqlPullTask() {
        // define stuff
        int exit = 0;
        // open
        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);
        // sql sertch
        string query = "select * from TASKS";
        sqlite3_exec(DB, query.c_str(), callback, NULL , NULL);

        // debog stuff
        if (exit != SQLITE_OK) {
            cerr << "sqlPullTask: " << sqlite3_errmsg(DB) << endl;

        }else {
            cout << "it is open" << endl;
        }
        // close
        sqlite3_close(DB);
        return 0;
    }

    void EngineMod::sqlPullPry() {
        int exit = 0;
        // open
        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);
        // sql sertch
        string query = "select * from PRY "
                       "ORDER BY DEX";
        sqlite3_exec(DB, query.c_str(), callbackPRY, NULL , NULL);

        // debog stuff
        if (exit != SQLITE_OK) {
            cerr << "sqlPullPry: " << sqlite3_errmsg(DB) << endl;

        }else {
            cout << "it is open" << endl;
        }
        // close
        sqlite3_close(DB);
    }

    void EngineMod::refrechAll() {

        //clear
        all_tasks.clear();
        all_people.clear();
        all_pry.clear();
        for (auto &i: all_loaded) {
            i->deleteLater();
        }
        all_loaded.clear();
        //pull new data
        sqlPullPeople();
        sqlPullTask();
        sqlPullPry();


        // display new data
        for (int i = 0; i < all_pry.size();i++) {
            addPry(i);
        }

        if (listPar == 0) {
            // this_thread::sleep_for(chrono::seconds(1));
            refrechAll();
        }else {
            for (int i = 0; i < all_tasks.size(); i++) {
                addTask(i);

            }
        }
    }

    void EngineMod::sqlComd() {
        int exit = 0;
        char* errorM;
        // open
        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);

        string sql = "";
        // sql = "INSERT INTO TASKS (NAME, PRY, REPEATE, HOWLONG, WHE, NOTE, PEOPLE, TYPE)VALUES ('seconed task', 0 , 1 , 1, '01/01/2000', 'this note', '2,3,', 'seconed');";
        // sql = "alter table TASKS ADD column IDS int AUTO_INCREMENT primary key";
        // sql = "alter table TASKS DROP CONSTRAINT ID";
        // sql = "drop table TASKS";
        // sql = "delete from TASKS where ID = " + to_string(ind);
        // ind++;
        // sql = "UPDATE TASKS SET people = '1,3,' where ID = 1";

        // sql = "create table TASKS("
        //       "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
        //       "NAME text,"
        //       "PRY int,"
        //       "REPEATE int,"
        //       "HOWLONG int,"
        //       "WHE text,"
        //       "NOTE text,"
        //       "PEOPLE text,"
        //       "TYPE text"
        //       ");";


        // sql = "DROP TABLE PRY";
        // sql = "create table PRY("
        //       "DEX int PRIMARY KEY,"
        //       "NAME text,"
        //       "R int,"
        //       "G int,"
        //       "B int"
        //       ");";

        // sql = "INSERT INTO PRY VALUES(2,'low',0,0,255)";

        // sql = "create table PEOPLE (ID int PRIMARY KEY,NAME text, PFP TEXT, REQHR text)";
        // sql = "INSERT INTO PEOPLE VALUES(3, 'bat man','purple','1,1,1,1,1,1,1')";

        sqlite3_exec(DB, sql.c_str(), NULL, 0, &errorM);
        cerr << "sqlcmd: " << sqlite3_errmsg(DB) << endl;
    }

    void EngineMod::creatTask(QString name, int pry, int rep, int delay, QString due, QString notes, QString people, QString type) {
        cout << name.toStdString() << " " << pry << " " << rep << " " << delay << " " << due.toStdString() << " " << notes.toStdString() << " " << people.toStdString() << " " << type.toStdString() << "\n";
        int exit = 0;
        char* errorM;

        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);
        string start = "INSERT INTO TASKS (NAME, PRY, REPEATE, HOWLONG, WHE, NOTE, PEOPLE, TYPE)VALUES (";
        string end = ");";
        char com = ',';
        string startquo = " '";
        string endquo = "' ";
        string sql = start + startquo +name.toStdString() + endquo + com + to_string(pry) + com + to_string(rep) + com + to_string(delay) + com + startquo + due.toStdString() + endquo + com + startquo + people.toStdString() + endquo + com + startquo + notes.toStdString() + endquo + com + startquo + type.toStdString() + endquo+ end;

            // seconed task', 0 , 1 , 1, '01/01/2000', 'this note', '2,3,', seconed;

        sqlite3_exec(DB, sql.c_str(), NULL, 0, &errorM);
        cerr << "create task : " << sqlite3_errmsg(DB) << endl;
        sqlite3_close(DB);
        refrechAll();
    }

    void EngineMod::addTask(int addtask) {
        // cout << "qml: " << all_tasks[addtask].name << endl;
        task& temp = all_tasks[addtask];


        QQmlComponent component(eng, QUrl(QStringLiteral("../QML/taskQml.qml")));

        // all_loaded.push_back(&component);

        QVariantMap taskProp;
        taskProp["dex"] = temp.dex;
        taskProp["taskName"] =  QString::fromStdString(temp.name);
        taskProp["peopleInt"] = static_cast<int>(temp.peoples.size());
        QStringList qPeople;
        for (int i = 0; i < temp.peoples.size(); i++) {
            // cout << i << " : " << all_people[temp.peoples[i] -1].php << " : "<< all_people[temp.peoples[i] -1].dex<<"\n";
            qPeople.push_back(QString::fromStdString(all_people[temp.peoples[i]-1].php));
        }
        taskProp["peopleImgs"] = qPeople;
        taskProp["taskType"] = QString::fromStdString(temp.type);
        time_t rn;
        time(&rn);
        struct tm dateTime;

        double diff = difftime(rn, temp.date);
        diff /= 60* 60 * 24;
        diff = floor(diff);
        int days = diff;
        // cout << diff << " : " << ctime(&rn)  << " : "  << ctime(&temp.date)<< endl;
        // if ()

        taskProp["taskDate"] = QString::fromStdString(to_string(days));
        taskProp["taskNotes"] = QString::fromStdString(temp.notes);

        QObject* newTaskQml = component.createWithInitialProperties(taskProp, eng->rootContext());

        all_loaded.push_back(newTaskQml);

        if (!newTaskQml) {
            qWarning() << "Failed to create:" << component.errors();
            return;
        }

        QObject* pryDir = all_pry[temp.pry].dir;
        newTaskQml->setParent(pryDir);
        QQmlEngine::setObjectOwnership(newTaskQml, QQmlEngine::CppOwnership);

        QQuickItem* parentItem = qobject_cast<QQuickItem*>(pryDir);
        QQuickItem* childItem = qobject_cast<QQuickItem*>(newTaskQml);

        if (parentItem && childItem) {
            childItem->setParentItem(parentItem);
        }
        // cout << childItem->parent() << endl;
        // ind++;
    }

    void EngineMod::addPry(int addedPry) {
        pryority& temp = all_pry[addedPry];

        QQmlComponent component(eng, QUrl(QStringLiteral("../QML/pryQml.qml")));

        // define var in pry
        QVariantMap prop;
        prop["dex"] = static_cast<int>(temp.dex);
        prop["pryName"] = QString::fromStdString(temp.name);
        prop["prr"] = static_cast<int>(temp.r);
        prop["prg"] = static_cast<int>(temp.g);
        prop["prb"] = static_cast<int>(temp.b);

        QObject* newPry = component.createWithInitialProperties(prop, eng->rootContext());

        // add in to qml
        if (!newPry) {
            qWarning() << "Failed to create:" << component.errors();
            return;
        }
        newPry->setParent(listPar);
        QQmlEngine::setObjectOwnership(newPry, QQmlEngine::CppOwnership);

        all_loaded.push_back(newPry);

        QQuickItem* parentItem = qobject_cast<QQuickItem*>(listPar);
        QQuickItem* childItem = qobject_cast<QQuickItem*>(newPry);

        if (parentItem && childItem) {
            childItem->setParentItem(parentItem);
        }

        // find dir
        temp.dir = childItem;

    }

    void EngineMod::edit(int dex) {
        crate->setProperty("createIsClosed", false);
    }

    void EngineMod::testing() {
        // this_thread::sleep_for(chrono::seconds(3));

        crate->setProperty("createIsClosed", false);
        sqlComd();
        // for (auto i: all_tasks) {
        //     cout << i.dex << endl;
        // }
    }

    void EngineMod::deleter(QObject *taskToDelete, int delDex) {
        taskToDelete->deleteLater();

        // sql stuff
        int exit = 0;
        char* errorM;
        string sql = "delete from TASKS where ID =";
        sql += to_string(delDex);
        sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);


        sqlite3_exec(DB, sql.c_str(), NULL, 0,  &errorM);

        cerr << "del: " << sqlite3_errmsg(DB) << endl;

        sqlite3_close(DB);

        refrechAll();
    }
};



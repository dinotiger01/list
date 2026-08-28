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
#include  <bitset>

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
        int isReturn;
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
    unordered_map<string, QObject*> bulkCreate;
    vector<QObject*> pryKidHold;
    vector<QObject*> typeKidHold;
    vector<QObject*> peopleKidHold;


    int curLook;
    time_t curentTime = time(&curentTime);
    struct tm currentDate = *localtime(&curentTime);

    QObject* listPar;
    QObject* crate;
    QQmlEngine* eng;
    // sql
    sqlite3* DB;

    // quick test
    int ind = 2;


    //returns
    QString EngineMod::getCurrentDate() {
        char cDate[50];;
        strftime(cDate, 50, "%m/%d/%Y", &currentDate);
        return QString::fromStdString(cDate);
    }
    QString EngineMod::getPersonName(int i, QObject* obj) {
        peopleKidHold.at(i) = obj;
        return QString::fromStdString(all_people[i].php);
    }
    int EngineMod::getPersonSize() {
        if (peopleKidHold.empty()) {
            for (int i=0; i < all_people.size(); i++) {
                peopleKidHold.push_back(NULL);
            }
        }
        return all_people.size();
    }
    QString EngineMod::getTypeName(int i, QObject* obj) {
        typeKidHold.at(i) = obj;
        return QString::fromStdString(all_type[i]);
    }
    int EngineMod::getTypeSize() {
        if (typeKidHold.empty()) {
            for (int i=0; i < all_type.size(); i++) {
                typeKidHold.push_back(NULL);
            }
        }
        return all_type.size();
    }
    QString EngineMod::getPryName(int i, QObject* obj) {
        pryKidHold.at(i) = obj;
        return QString::fromStdString(all_pry[i].name);
    }
    int EngineMod::getPrySize() {
        if (pryKidHold.empty()) {
            for (int i=0; i < all_pry.size(); i++) {
                pryKidHold.push_back(NULL);
            }
        }
        return all_pry.size();
    }
    bool isPrev(time_t test) {
        time_t rn = curentTime;
        if((difftime(rn, test )/ 60*60*24) > -1){
            return true;
        }else {
            return false;
        }
    }
    bool isPrev(tm testDate) {
        time_t test = mktime(&testDate);
        time_t rn = curentTime;
        if((difftime(rn, test )/ 60*60*24) > -1){
            return true;
        }else {
            return false;
        }
    }


    // declars
    void EngineMod::setEng(QQmlEngine* engin) {
        eng = engin;
    }

    void EngineMod::setBulkCreate(QObject* obj, QString type) {
        bulkCreate[type.toStdString()] = obj;
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
            cout << azColName[i] << " : " << argv[i] << endl;
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
                //substr
                time_t temp;
                string stringer = argv[i];
                datetime.tm_year = stoi(stringer.substr(0,4)) - 1900;
                datetime.tm_mon = stoi(stringer.substr(5,2)) - 1;
                datetime.tm_mday = stoi(stringer.substr(8,2));
                datetime.tm_hour = 0;
                datetime.tm_min = 0;
                datetime.tm_sec = 0;
                datetime.tm_isdst = -1;
                // cout << datetime.tm_year << " : " << datetime.tm_mon << " : " << datetime.tm_mday << endl;
                temp = mktime(&datetime);
                // cout << ctime(&temp) << endl;
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
        string query = "select * from TASKS ORDER BY WHE DESC";
        sqlite3_exec(DB, query.c_str(), callback, NULL , NULL);

        // debog stuff
        cerr << "sqlPullTask: " << sqlite3_errmsg(DB) << endl;
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

    void back_dup(task dup, struct tm newtime, bool oveRide) {
        int exit = 0;
        char* errorM;

        string start = "INSERT INTO TASKS (NAME, PRY, REPEATE, HOWLONG, WHE, NOTE, PEOPLE, TYPE)VALUES (";
        string end = ");";
        char com = ',';
        string startquo = " '";
        string endquo = "' ";
        char rn[50];

        strftime(rn, 50, "%Y/%m/%d", &newtime);

        string pep;
        for (auto& i : dup.peoples) {
            pep += to_string(i) + ",";
        }
        string sql;
        sql = start + startquo + dup.name + endquo + com + to_string(dup.pry) + com + to_string(dup.isReturn) + com + to_string(dup.delay) + com + startquo + rn + endquo + com + startquo + dup.notes + endquo + com + startquo + pep + endquo + com + startquo + dup.type + endquo+ end;
        sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);
        sqlite3_exec(DB, sql.c_str(), NULL, 0,  &errorM);

        cerr << "fromC: " << sqlite3_errmsg(DB) << endl;

        if (dup.isReturn == 1 || dup.isReturn == 4 || dup.isReturn == 6 || dup.isReturn == 3 || oveRide) {
            sql = "delete from TASKS where ID = ";
            sql += to_string(dup.dex);
        }else if (dup.isReturn == 2|| dup.isReturn == 5 || dup.isReturn == 7) {
            sql = "UPDATE TASKS SET REPEATE = 0 where ID = ";
            sql += to_string(dup.dex);
        }

        sqlite3_exec(DB, sql.c_str(), NULL, 0,  &errorM);

        cerr << "fromC: " << sqlite3_errmsg(DB) << endl;

        sqlite3_close(DB);

    }

    bool dup_fromC(task id) {
        task& dupTask = id;
        bool needed = false;
        // time rn


        struct tm testDate = *localtime(&dupTask.date);
        // alllll need to be on compleate
        if (dupTask.isReturn == 1 || dupTask.isReturn == 2) {
            // get due delay
            testDate.tm_mday += dupTask.delay;
            time_t testTime = mktime(&testDate);

            if (isPrev(testTime)) {
                needed = true;
            }
        }else if (dupTask.isReturn == 3) {
            // make sure date of mark off even if it is in the futre
            // needed = true;
            needed = false;

        }else if (dupTask.isReturn == 4 || dupTask.isReturn == 5 ) {
            // convert to binary

            bitset<7> binary(dupTask.delay);
            // find next date due

            testDate.tm_mday++;
            while (true) {
                mktime(&testDate);
                if (binary[testDate.tm_wday] == 1) {
                    break;
                }
                testDate.tm_mday++;
                // cout << date.tm_wday << " : ";
            }
            cout << "\n";

            // check if due is here

            if (isPrev(testDate)) {
                needed = true;
            }
        }else if (dupTask.isReturn == 6 || dupTask.isReturn == 7 ) {

            // find next date due


            testDate.tm_mday++;
            while (true) {
                mktime(&testDate);
                if (testDate.tm_mday == dupTask.delay) {
                    break;
                }
                testDate.tm_mday++;
            }
            cout << "\n";

            // check if due is here see above

            if (isPrev(testDate)) {
                needed = true;
            }


        }else {
            cout << "you broke everyting" << "\n";
        }
        if (needed) {
            back_dup(dupTask, testDate, false);
        }
        return needed;
    };

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

        // load if rec
        bool found = false;
        for (auto& i: all_tasks) {
            if (i.isReturn > 0 && !found) {
                found = dup_fromC(i);
            }
        }
        if (found) {
            refrechAll();
        }else {
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
    }

    void EngineMod::sqlComd() {
        int exit = 0;
        char* errorM;
        // open
        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);

        string sql = "";
        // sql = "INSERT INTO TASKS (NAME, PRY, REPEATE, HOWLONG, WHE, NOTE, PEOPLE, TYPE)VALUES ('seconed task', 0 , 1 , 1, '2026/08/15/', 'this note', '2,3,', 'seconed');";
        // sql = "alter table TASKS ADD column IDS int AUTO_INCREMENT primary key";
        // sql = "alter table TASKS DROP CONSTRAINT ID";
        // sql = "drop table TASKS";
        sql = "delete from TASKS where ID > 0;";
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

    void EngineMod::creatTask(QString name, int pry, int rep, int delay, QString due, QString notes, QString people, QString type, bool edit) {
        cout << name.toStdString() << " " << pry << " " << rep << " " << delay << " " << due.toStdString() << " " << notes.toStdString() << " " << people.toStdString() << " " << type.toStdString() << edit << "\n";
        int exit = 0;
        char* errorM;

        exit = sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);
        string newdue = due.toStdString();
        string fixeddue = newdue.substr(6, 4) + "/" + newdue.substr(0, 2) + "/" + newdue.substr(3, 2);
        string start = "INSERT INTO TASKS (NAME, PRY, REPEATE, HOWLONG, WHE, NOTE, PEOPLE, TYPE)VALUES (";
        string end = ");";
        char com = ',';
        string startquo = " '";
        string endquo = "' ";
        string sql;
        if (edit == 0) {
            cout << "wtf" << "\n";
            sql = start + startquo +name.toStdString() + endquo + com + to_string(pry) + com + to_string(rep) + com + to_string(delay) + com + startquo + fixeddue + endquo + com + startquo + notes.toStdString() + endquo + com + startquo + people.toStdString() + endquo + com + startquo + type.toStdString() + endquo+ end;
        }else {
            // UPDATE TASKS SET NAME = 'name' , PRY = pry , REPEATE = rep, HOWLONG = delay, WHE = fixeddue, NOTES = notes, PEOPLE = people, TYPE = type
            start = "UPDATE TASKS SET ";
            string NAME = "NAME = ";
            string PRY = "PRY = ";
            string REPEATE = "REPEATE = ";
            string HOWLONG = "HOWLONG = ";
            string WHE = "WHE = ";
            string NOTE = "NOTE = ";
            string PEOPLE = "PEOPLE = ";
            string TYPE = "TYPE = ";
            string where = "WHERE ID = " + to_string(curLook);
            sql = start + NAME + startquo + name.toStdString() + endquo + com + PRY + to_string(pry) + com + REPEATE + to_string(rep) + com + HOWLONG + to_string(delay) + com + WHE + startquo + fixeddue + endquo + com + NOTE + startquo + notes.toStdString() + endquo + com + PEOPLE + startquo + people.toStdString() + endquo + com +TYPE + startquo + type.toStdString() + endquo + where+ ";";
        }
            // seconed task', 0 , 1 , 1, '01/01/2000', 'this note', '2,3,', seconed;

        sqlite3_exec(DB, sql.c_str(), NULL, 0, &errorM);
        cerr << "create task : " << sqlite3_errmsg(DB) << endl;
        sqlite3_close(DB);
        crate->setProperty("createIsClosed", true);
        refrechAll();
    }

    void EngineMod::addTask(int addtask) {
        // cout << "qml: " << all_tasks[addtask].name << endl;
        task& temp = all_tasks[addtask];

        // if filter here
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


        double diff = difftime(temp.date, curentTime);
        diff /= 60* 60 * 24;
        diff = floor(diff);
        int days = diff + 1; // off set
        // cout << diff << " : " << ctime(&rn)  << " : "  << ctime(&temp.date)<< endl;
        string preface;
        if (days > 1) {
            preface = to_string(abs(days)) + " days until";
        }else if (days < -1) {
            preface = to_string(abs(days)) + " days ago";
        }else if (days == 0) {
            preface = "today";
        }else if (days == -1) {
            preface = "yesterday";
        }else if (days == 1) {
            preface = "tomarow";
        }

        taskProp["taskDate"] = QString::fromStdString(preface);
        struct tm dueDate = *localtime(&temp.date);
        char due[12];
        strftime(due, 12,"%m/%d/%Y", &dueDate);
        taskProp["taskNoteDate"] = QString::fromStdString(due);
        // task date in description
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

    // engin.setBulkCreate(newName, "name")
    // engin.setBulkCreate(newNotes, "note")
    // engin.setBulkCreate(prySelect, "pryParent")
    // engin.setBulkCreate(typeSelect, "typeParent")
    // engin.setBulkCreate(assSelect, "assParent")
    // engin.setBulkCreate(delButton, "delButton")
    // engin.setBulkCreate(creater, "creator")
    //
    // engin.setBulkCreate(isRepBox, "isRep")
    // engin.setBulkCreate(holderForAll, "repSet")
    // engin.setBulkCreate(repTypeDrop, "repDrop")
    // "repSel"
    // engin.setBulkCreate(multiCheck, "multiBox")
    // engin.setBulkCreate(repNum, "repNum")
    // engin.setBulkCreate(repWeek, "repWeek")
    // engin.setBulkCreate(creatDate, "date")
    void EngineMod::editOpen(int dex) {
        curLook = dex;
        task temp;
        for (auto& i : all_tasks) {
            if (i.dex == dex) {
                temp = i;
                break;
            }
        }

        bulkCreate["name"]->setProperty("text", QString::fromStdString(temp.name));
        bulkCreate["note"]->setProperty("text", QString::fromStdString(temp.notes));
        bulkCreate["pryParent"]->setProperty("model", getPrySize());
        // check kid
        pryKidHold[temp.pry]->setProperty("checked", true);

        bulkCreate["typeParent"]->setProperty("model", getTypeSize());
        // check kid
        for (int i = 0; i < all_type.size(); i++) {
            if (all_type[i] == temp.type){
                typeKidHold[i]->setProperty("checked", true);
                break;
            }
        }
        bulkCreate["assParent"]->setProperty("model", getPersonSize());
        // check kid
        for (int i = 0; i < peopleKidHold.size(); i++) {
            bool found = false;
            for (auto& k: temp.peoples) {
                if (i+1 == k) {
                    peopleKidHold[i]->setProperty("checked", true);
                    found = true;
                    break;
                }
            }
            if (!found) {
                peopleKidHold[i]->setProperty("checked", false);
            }
        }

        bulkCreate["delButton"]->setProperty("width", 30);
        bulkCreate["repSel"]->setProperty("recType", temp.isReturn);
        // convert to string
        char out[50];
        tm date = *localtime(&temp.date);
        strftime(out, 12,"%m/%d/%Y", &date);

        bulkCreate["date"]->setProperty("text", QString::fromStdString(out));

        if (temp.isReturn > 0) {
            bulkCreate["isRep"]->setProperty("checked", true);
            bulkCreate["repSet"]->setProperty("state", "yeah");

            if (temp.isReturn == 1 || temp.isReturn == 2) {
                bulkCreate["repDrop"]->setProperty("text", "rec on due");
            }
            if (temp.isReturn == 3) {
                bulkCreate["repDrop"]->setProperty("text", "rec on comp");
            }
            if (temp.isReturn == 4 || temp.isReturn == 5) {
                bulkCreate["repDrop"]->setProperty("text", "rec on week");
            }
            if (temp.isReturn == 6 || temp.isReturn == 7) {
                bulkCreate["repDrop"]->setProperty("text", "rec on month");
            }



            // check
            if (temp.isReturn == 2 || temp.isReturn == 5 || temp.isReturn == 7) {
                bulkCreate["multiBox"]->setProperty("checked", true);
                bulkCreate["creator"]->setProperty("multi", true);
            }else {
                bulkCreate["multiBox"]->setProperty("checked", false);
                bulkCreate["creator"]->setProperty("multi", false);
            }
            //number
            if (temp.isReturn == 2 || temp.isReturn == 3 || temp.isReturn == 7 || temp.isReturn == 1 || temp.isReturn == 6) {
                bulkCreate["repNum"]->setProperty("num", temp.delay);
                bulkCreate["repNumText"]->setProperty("text", QString::fromStdString(to_string(temp.delay)));
            }else {
                bulkCreate["repNum"]->setProperty("num", 0);
                bulkCreate["repNumText"]->setProperty("text", QString::fromStdString(to_string(0)));
            }

            if (temp.isReturn == 4 || temp.isReturn == 5) {
                // um idk
                // i know now
                //i know this is the worst way i could do this i dont care
                bitset<7> binary(temp.delay);
                for (int i = 0; i < binary.size(); i++) {
                    if (binary[i] == 1 ) {
                        bulkCreate["repWeek" + to_string(i)]->setProperty("checked", true);
                    }else {
                        bulkCreate["repWeek" + to_string(i)]->setProperty("checked", false);
                    }
                }
            }else {
                for (int i = 0; i < 7; i++) {
                    bulkCreate["repWeek" + to_string(i)]->setProperty("checked", false);
                }
            }
        }else {
            bulkCreate["isRep"]->setProperty("checked", false);
            bulkCreate["repSet"]->setProperty("state", "eh");
        }
        // creator
        bulkCreate["creator"]->setProperty("pry", temp.pry);
        bulkCreate["creator"]->setProperty("edit", true);
        bulkCreate["creator"]->setProperty("type", QString::fromStdString(temp.type));

        vector<bool> peps = {true, false, true};
        QVariantList qmlPep;
        qmlPep.reserve(peps.size());
        for (bool i : peps) {
            qmlPep.append(i);
            cout << "fromC: " << i << "\n";
        }


        bulkCreate["creator"]->setProperty("peps", qmlPep);


        crate->setProperty("createIsClosed", false);
    }

    void EngineMod::editClose() {
        crate->setProperty("createIsClosed", true);
    }

    void EngineMod::testing() {
        // this_thread::sleep_for(chrono::seconds(3));

        // crate->setProperty("createIsClosed", false);
        // sqlComd();
        refrechAll();
        // cout << "fromQml: " << test << "\n";
        // for (auto i: all_tasks) {
        //     cout << i.dex << endl;
        // }
    }

    void EngineMod::deleter(QObject *taskToDelete, int delDex) {
        taskToDelete->deleteLater();

        task tempTask;
        for (auto& i: all_tasks) {
            if (i.dex == delDex) {
                tempTask = i;
                break;
            }
        }

        if (tempTask.isReturn > 0) {
            struct tm newDate = *localtime(&tempTask.date);
            if (tempTask.isReturn == 1 || tempTask.isReturn == 2) {
                newDate.tm_mday += tempTask.delay;

            }else if (tempTask.isReturn == 3) {
                // get date rn
                newDate.tm_mday = currentDate.tm_mday + tempTask.delay;
            }else if (tempTask.isReturn == 4 || tempTask.isReturn == 5) {
                bitset<7> binary(tempTask.delay);
                newDate.tm_mday++;
                while (true) {
                    mktime(&newDate);
                    if (binary[newDate.tm_wday] == 1) {
                        break;
                    }
                    newDate.tm_mday++;
                }

            }else if (tempTask.isReturn == 6 || tempTask.isReturn == 7) {
                newDate.tm_mday++;
                while (true) {
                    mktime(&newDate);
                    if (newDate.tm_mday == tempTask.delay) {
                        break;
                    }
                    newDate.tm_mday++;
                }
            }else {
                cout << "no" << "\n";
            }
            mktime(&newDate);
            back_dup(tempTask, newDate, true);
        }else {
            // sql stuff
            int exit = 0;
            char* errorM;
            string sql = "delete from TASKS where ID =";
            sql += to_string(delDex);
            sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);

            sqlite3_exec(DB, sql.c_str(), NULL, 0,  &errorM);

            cerr << "del: " << sqlite3_errmsg(DB) << endl;

            sqlite3_close(DB);

        }
        refrechAll();
    }

    void EngineMod::permDel() {
        int exit = 0;
        char* errorM;
        sqlite3_open("/home/FFlyingFish/Downloads/untitled1/data.db", &DB);

        string sql = "delete from TASKS where ID =";
        sql += to_string(curLook);
        sqlite3_exec(DB, sql.c_str(), NULL, 0,  &errorM);

        cerr << "perm: " << sqlite3_errmsg(DB) << endl;

        sqlite3_close(DB);
        refrechAll();
    }
};



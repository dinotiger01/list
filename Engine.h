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
        Q_INVOKABLE void asd(QObject* par);
        Q_INVOKABLE void setPar(QObject* par);
        void setEng(QQmlEngine* engin);
    };
}


#endif //QTQMLCPPAPP_ENGINE_H

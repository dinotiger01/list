#include <QGuiApplication>
#include <iostream>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Engine.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Engine::EngineMod Engine;


    engine.rootContext()->setContextProperty("engin", &Engine);
    Engine.setEng(&engine);


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &engine, [&engine, &Engine](QObject *obj, const QUrl) {
        if (!obj) {
            qCritical() <<  "everything is broke ¯\\_(ツ)_/¯ ";
        }
        std::cout << "qml sould be loaded idk" << std::endl;

        Engine.refrechAll();

    }, Qt::QueuedConnection);


    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/EngineMod/QML/main.qml")));


    

    return app.exec();
}

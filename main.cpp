#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Engine.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Engine::EngineMod Engine;


    engine.rootContext()->setContextProperty("engin", &Engine);

    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/EngineMod/QML/main.qml")));

    Engine.setEng(&engine);


    return app.exec();
}
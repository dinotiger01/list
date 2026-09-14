#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Engine.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qt/qml/EngineMod/main.qml"_s);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    Engine::EngineMod Engine;
    engine.rootContext()->setContextProperty("engin", &Engine);
    Engine.setEng(&engine);

    engine.load(url);

    return app.exec();
}

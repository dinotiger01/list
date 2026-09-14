#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext> // <--- CRITICAL: Required for rootContext()
#include "controlls.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qt/qml/MainApplication/main.qml"_s);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    // 1. Instantiate your C++ controller class
    MTG_size_editer::controlls controll;

    // 2. REGISTER the property FIRST so QML knows it exists before parsing
    engine.rootContext()->setContextProperty("controlls", &controll);

    // 3. LOAD the UI last
    engine.load(url);

    return app.exec();
}

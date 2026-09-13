#include <QGuiApplication>
#include <iostream>
#include "Engine.h"
// #include <QQuickStyle>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[]) {
    // QQuickStyle::setStyle("Basic");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Engine::EngineMod Engine;

    engine.rootContext()->setContextProperty("engin", &Engine);
    Engine.setEng(&engine);

    // Track if loading fails completely
    const QUrl url(QStringLiteral("qrc:/qt/qml/EngineMod/QML/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url, &Engine](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            // qCritical() << "ERROR: QML Engine failed to load the root object!";
            QCoreApplication::exit(-1);
            return;
        }

        std::cout << "QML should load ykyk" << std::endl;

        // Engine.refrechAll();
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

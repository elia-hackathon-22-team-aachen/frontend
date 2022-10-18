#include <QGuiApplication>
#include <QLocale>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QCursor>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    //qmlRegisterType<ThreadController>("kullen.nfc", 1, 0, "ThreadController");
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    QGuiApplication app(argc, argv);
   /* if (argc != 3) {
        qFatal("Error: Pass server url and access token as parameters.");
    }*/
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QGuiApplication::setOverrideCursor(QCursor(Qt::BlankCursor));
    QObject::connect(
            &engine, &QQmlApplicationEngine::objectCreated, &app,
            [url](QObject *obj, const QUrl &objUrl) {
                if (!obj && url == objUrl)
                    QCoreApplication::exit(-1);
            },
            Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("serverURL", argv[1]);
    engine.rootContext()->setContextProperty("accessToken", argv[2]);
    engine.load(url);

    return app.exec();
}

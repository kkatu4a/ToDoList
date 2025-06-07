#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _qt_qml_ToDoList_Main_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_NewMenu_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_TodoListPage_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_TodoBoardPage_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_StatsPage_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_HelpPage_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_DialogData_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_DialogCreate_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_CurrentDate_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_TaskDelegate_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_ToDoList_DialogEdit_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/Main.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_Main_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/NewMenu.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_NewMenu_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/TodoListPage.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_TodoListPage_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/TodoBoardPage.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_TodoBoardPage_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/StatsPage.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_StatsPage_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/HelpPage.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_HelpPage_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/DialogData.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_DialogData_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/DialogCreate.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_DialogCreate_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/CurrentDate.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_CurrentDate_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/TaskDelegate.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_TaskDelegate_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/ToDoList/DialogEdit.qml"), &QmlCacheGeneratedCode::_qt_qml_ToDoList_DialogEdit_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appToDoList)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appToDoList))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_appToDoList)() {
    return 1;
}

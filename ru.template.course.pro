# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = ru.template.course

CONFIG += \
    auroraapp

# Отключаем подписывание пакетов для разработки
CONFIG += no_signing_warning
CONFIG += no_rpm_sign

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    rpm/ru.template.course.spec \
    qml/course.qml \
    qml/cover/DefaultCoverPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/AboutPage.qml \
    qml/dialogs/AddDebtDialog.qml \
    ru.template.course.desktop

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n



# Add resources file to the project
RESOURCES += resources.qrc

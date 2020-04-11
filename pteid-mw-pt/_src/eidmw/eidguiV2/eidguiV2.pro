include(../_Builds/eidcommon.mak)

TEMPLATE = app

macx: ICON = appicon.icns

QT += quick quickcontrols2 concurrent

#Needed for the FileSaveDialog class
QT += core-private
QT += gui-private
QT += widgets
QT += printsupport

CONFIG += c++11

QMAKE_CFLAGS += -fvisibility=hidden
QMAKE_CXXFLAGS += -fvisibility=hidden

SOURCES += main.cpp \
    appcontroller.cpp \
    gapi.cpp \
    SCAP-services-v3/SCAPAttributeClientServiceBindingProxy.cpp \
    SCAP-services-v3/SCAPAttributeSupplierBindingProxy.cpp \
    SCAP-services-v3/SCAPAuthorizationServiceSoapBindingProxy.cpp \
    SCAP-services-v3/SCAPC.cpp \
    SCAP-services-v3/SCAPSignatureServiceSoapBindingProxy.cpp \
    autoUpdates.cpp \
    pdfsignatureclient.cpp \
    ErrorConn.cpp \
    stdsoap2.cpp \
    scapsignature.cpp \
    scapcompanies.cpp \
    filesavedialog.cpp \
    certificates.cpp \
    totp_gen.cpp \
    singleapplication.cpp \
    cJSON_1_7_12.c \
    AttributeFactory.cpp \
    OAuthAttributes.cpp \
    concurrent.cpp

INCLUDEPATH += /usr/include/poppler/qt5/
INCLUDEPATH += ../CMD/services
INCLUDEPATH += ../applayer
INCLUDEPATH += ../common
INCLUDEPATH += ../cardlayer
INCLUDEPATH += ../eidlib
INCLUDEPATH += ../_Builds

#Don't mess up the source folder with generated files
OBJECTS_DIR = build
MOC_DIR = build

#Include paths for MacOS homebrew libraries
macx: INCLUDEPATH += /usr/local/opt/openssl/include/
macx: INCLUDEPATH += $$system(brew --prefix poppler)/include/poppler/qt5/
macx: LIBS += -L/usr/local/opt/openssl/lib/
macx: LIBS += -L$$system(brew --prefix poppler)/lib/
macx: LIBS += -Wl,-framework -Wl,Security

unix:!macx: LIBS += -Wl,-rpath-link,../lib
LIBS += -L../lib -lpteidcommon -lpteidapplayer -lpteidlib  \
        -lssl -lcrypto -lpoppler-qt5 -lCMDServices -lcurl

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =
RESOURCES += \
        resources.qrc \
        qtquickcontrols2.conf

TRANSLATIONS = eidmw_nl.ts \
               eidmw_en.ts \

lupdate_only{
SOURCES += main.qml \
            MainMenuModel.qml \
            MainMenuBottomModel.qml \
            contentPages/card/*.qml \
            contentPages/definitions/*.qml \
            contentPages/help/*.qml \
            contentPages/home/*.qml \
            contentPages/security/*.qml \
            contentPages/services/*.qml

}
# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

#Needed for the gsoap binding proxies
DEFINES += WITH_OPENSSL

###
### Installation setup
###
target.path = $${INSTALL_DIR_BIN}

## the following lines are needed in order to have
## the translation files included in the set
## of files to install
translations.path = $${INSTALL_DIR_BIN}
translations.files += eidmw_en.qm \
                eidmw_nl.qm

fonts.path = $${INSTALL_DIR_BIN}
fonts.files += fonts/lato/Lato-Regular.ttf

INSTALLS += target translations fonts

HEADERS += \
    appcontroller.h \
    gapi.h \
    filesavedialog.h \
    autoUpdates.h \
    scapsignature.h \
    Settings.h \
    certificates.h \
    singleapplication.h \
    singleapplication_p.h \
    cJSON_1_7_12.h \
    AttributeFactory.h \
    OAuthAttributes.h \
    concurrent.h

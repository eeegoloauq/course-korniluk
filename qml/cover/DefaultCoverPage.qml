import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    objectName: "defaultCover"

    Column {
        anchors.centerIn: parent
        width: parent.width - 2 * Theme.paddingLarge
        spacing: Theme.paddingMedium

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: Qt.resolvedUrl("../icons/course.svg")
            width: Theme.iconSizeLarge
            height: Theme.iconSizeLarge
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Курсовой трекер долгов"
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.primaryColor
        }

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: {
                var page = pageStack.currentPage
                if (page && page.objectName === "mainPage" && page.debtModel) {
                    return "Долгов: " + page.debtModel.count
                }
                return ""
            }
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
        }
    }

    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                app.activate()
                var page = pageStack.currentPage
                if (page && page.objectName === "mainPage") {
                    var dialog = pageStack.push(Qt.resolvedUrl("../dialogs/AddDebtDialog.qml"))
                    dialog.accepted.connect(function() {
                        page.debtModel.append({
                            name: dialog.debtName,
                            amount: dialog.debtAmount,
                            type: dialog.debtType,
                            isPaid: false
                        })
                    })
                }
            }
        }
    }
}


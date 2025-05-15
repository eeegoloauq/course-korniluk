import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: debtTrackerPage
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    ListModel {
        id: debtModel
        ListElement {
            name: "Иван"
            amount: 500
            type: "OwedToMe"
            isPaid: false
        }
        ListElement {
            name: "Кредит в банке"
            amount: 1000
            type: "IOwe"
            isPaid: true
        }
    }

    QtObject {
        id: constants
        property string typeIOwe: "IOwe"
        property string typeOwedToMe: "OwedToMe"
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {
            MenuItem {
                text: "Добавить долг"
                onClicked: {
                    var dialog = pageStack.push(Qt.resolvedUrl("../dialogs/AddDebtDialog.qml"))
                    dialog.accepted.connect(function() {
                        debtModel.append({
                            name: dialog.debtName,
                            amount: dialog.debtAmount,
                            type: dialog.debtType,
                            isPaid: false
                        })
                    })
                }
            }
        }

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader {
                title: "Курсовой трекер долгов"
            }

            SilicaListView {
                id: listView
                width: parent.width
                height: debtTrackerPage.height - y
                model: debtModel
                clip: true

                delegate: ListItem {
                    id: listItem
                    width: ListView.view.width
                    contentHeight: Theme.itemSizeMedium

                    Rectangle {
                        id: typeIndicator
                        width: Theme.paddingSmall
                        height: parent.height - Theme.paddingSmall * 2
                        anchors {
                            left: parent.left
                            leftMargin: Theme.paddingMedium
                            verticalCenter: parent.verticalCenter
                        }
                        color: model.type === constants.typeIOwe ? Theme.errorColor : Theme.successColor
                        radius: width / 2
                        
                        SequentialAnimation {
                            running: !model.isPaid
                            loops: Animation.Infinite
                            NumberAnimation { target: typeIndicator; property: "opacity"; to: 0.5; duration: 1000 }
                            NumberAnimation { target: typeIndicator; property: "opacity"; to: 1.0; duration: 1000 }
                        }
                    }

                    Column {
                        anchors {
                            left: typeIndicator.right
                            leftMargin: Theme.paddingMedium
                            right: parent.right
                            rightMargin: Theme.paddingLarge
                            verticalCenter: parent.verticalCenter
                        }

                        Label {
                            width: parent.width
                            text: model.name
                            font.pixelSize: Theme.fontSizeMedium
                            color: model.isPaid ? Theme.secondaryColor : Theme.primaryColor
                            font.strikeout: model.isPaid
                        }

                        Label {
                            width: parent.width
                            text: model.type === constants.typeIOwe ? 
                                "Я должен: " + model.amount : 
                                "Мне должны: " + model.amount
                            font.pixelSize: Theme.fontSizeSmall
                            color: model.isPaid ? Theme.secondaryColor : Theme.highlightColor
                            font.strikeout: model.isPaid
                        }
                    }

                    menu: ContextMenu {
                        MenuItem {
                            text: model.isPaid ? "Отметить как неоплаченное" : "Отметить как оплаченное"
                            onClicked: {
                                debtModel.setProperty(model.index, "isPaid", !model.isPaid)
                            }
                        }

                        MenuItem {
                            text: "Удалить"
                            onClicked: {
                                debtModel.remove(model.index)
                            }
                        }
                    }
                }

                ViewPlaceholder {
                    enabled: listView.count === 0
                    text: "Нет долгов"
                    hintText: "Потяните вниз, чтобы добавить долг"
                }
            }
        }

        VerticalScrollDecorator { flickable: listView }
    }
}

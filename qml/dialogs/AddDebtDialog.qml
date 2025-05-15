import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: addDebtDialog

    // Properties to store the new debt information
    property string debtName: ""
    property real debtAmount: 0
    property string debtType: "IOwe" // Default type

    // Constants for debt types
    readonly property string typeIOwe: "IOwe"
    readonly property string typeOwedToMe: "OwedToMe"

    // Set the dialog title and size
    allowedOrientations: Orientation.All
    canAccept: nameField.text.length > 0 && amountField.text.length > 0

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            DialogHeader {
                title: "Добавить новый долг"
                acceptText: "Добавить"
                cancelText: "Отмена"
            }

            TextField {
                id: nameField
                width: parent.width
                label: "Имя/Описание"
                placeholderText: "Введите имя или описание"
                focus: true
                
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: amountField.focus = true

                onTextChanged: {
                    debtName = text
                }
            }

            TextField {
                id: amountField
                width: parent.width
                label: "Сумма"
                placeholderText: "Введите сумму"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: DoubleValidator { bottom: 0.01; decimals: 2 }
                
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false

                onTextChanged: {
                    debtAmount = parseFloat(text) || 0
                }
            }

            SectionHeader {
                text: "Тип долга"
            }

            // Более интуитивные кнопки с лучшей визуальной обратной связью
            Item {
                width: parent.width
                height: typeButtons.height + Theme.paddingLarge * 2

                Row {
                    id: typeButtons
                    width: parent.width - Theme.paddingLarge * 2
                    height: Math.max(iOweButton.height, owedToMeButton.height)
                    anchors.centerIn: parent
                    spacing: Theme.paddingMedium

                    Rectangle {
                        id: iOweButton
                        width: (parent.width - Theme.paddingMedium) / 2
                        height: iOweText.height + Theme.paddingLarge * 1.5
                        color: debtType === typeIOwe ? Theme.highlightBackgroundColor : "transparent"
                        border.color: Theme.highlightColor
                        border.width: 2
                        radius: Theme.paddingSmall

                        Label {
                            id: iOweText
                            anchors.centerIn: parent
                            text: "Я должен"
                            color: debtType === typeIOwe ? Theme.highlightColor : Theme.primaryColor
                            font.pixelSize: Theme.fontSizeMedium
                            font.bold: debtType === typeIOwe
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: parent.opacity = 0.6
                            onReleased: parent.opacity = 1.0
                            onClicked: {
                                debtType = typeIOwe
                            }
                        }
                    }

                    Rectangle {
                        id: owedToMeButton
                        width: (parent.width - Theme.paddingMedium) / 2
                        height: owedToMeText.height + Theme.paddingLarge * 1.5
                        color: debtType === typeOwedToMe ? Theme.highlightBackgroundColor : "transparent"
                        border.color: Theme.highlightColor
                        border.width: 2
                        radius: Theme.paddingSmall

                        Label {
                            id: owedToMeText
                            anchors.centerIn: parent
                            text: "Мне должны"
                            color: debtType === typeOwedToMe ? Theme.highlightColor : Theme.primaryColor
                            font.pixelSize: Theme.fontSizeMedium
                            font.bold: debtType === typeOwedToMe
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: parent.opacity = 0.6
                            onReleased: parent.opacity = 1.0
                            onClicked: {
                                debtType = typeOwedToMe
                            }
                        }
                    }
                }
            }
        }
    }
} 
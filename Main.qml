import QtQuick
import SddmComponents

Rectangle {
    id: root

    width: 1366
    height: 768
    color: root.pageColor

    function hourSetting(value, fallback) {
        var parsed = parseInt(value)
        return isNaN(parsed) ? fallback : parsed
    }

    property int hour: new Date().getHours()
    readonly property string modeSetting: (config.mode || "dark").toLowerCase()
    readonly property int lightFrom: hourSetting(config.lightFrom, 7)
    readonly property int darkFrom: hourSetting(config.darkFrom, 19)
    readonly property bool daytime: lightFrom < darkFrom
        ? (hour >= lightFrom && hour < darkFrom)
        : (hour >= lightFrom || hour < darkFrom)
    readonly property bool isLight: modeSetting === "light" || (modeSetting === "auto" && daytime)

    readonly property color pageColor: isLight ? "#e3e8f1" : "#07090d"
    readonly property color ink: isLight ? "#141a26" : "#eef1f7"
    readonly property color muted: isLight ? "#566177" : "#7f8ba0"
    readonly property color panel: isLight ? "#f1f4f9" : "#151a24"
    readonly property color panelRaised: isLight ? "#fbfcfe" : "#1d2331"
    readonly property color edge: isLight ? "#cbd3e1" : "#2a3244"
    readonly property color accent: isLight ? "#2f5fc4" : "#8fb3ff"
    readonly property color accentInk: isLight ? "#ffffff" : "#0b0f18"
    readonly property color danger: isLight ? "#b3261e" : "#e67c7c"
    readonly property real tintTop: isLight ? 0.86 : 0.784
    readonly property real tintBottom: 0.96
    readonly property string fontName: config.font || "Adwaita Sans"
    readonly property string user: userModel.lastUser
    readonly property string wallpaper: isLight && config.backgroundLight ? config.backgroundLight : config.background

    function attemptLogin() {
        status.text = ""
        sddm.login(root.user, password.text, session.index)
    }

    Image {
        anchors.fill: parent
        source: root.wallpaper
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(root.pageColor.r, root.pageColor.g, root.pageColor.b, root.tintTop) }
            GradientStop { position: 1.0; color: Qt.rgba(root.pageColor.r, root.pageColor.g, root.pageColor.b, root.tintBottom) }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var now = new Date()
            root.hour = now.getHours()
            clock.text = Qt.formatTime(now, "HH:mm")
            dateLine.text = Qt.formatDate(now, "dddd d MMMM")
        }
    }

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 84
        anchors.topMargin: 76
        spacing: 2

        Text {
            id: clock
            color: root.ink
            font.family: root.fontName
            font.pixelSize: 136
            font.weight: Font.Light
        }

        Text {
            id: dateLine
            color: root.muted
            font.family: root.fontName
            font.pixelSize: 22
        }
    }

    Rectangle {
        id: card
        width: 380
        height: 470
        anchors.right: parent.right
        anchors.rightMargin: 96
        anchors.verticalCenter: parent.verticalCenter
        radius: 26
        color: root.panel
        border.color: root.edge
        border.width: 1

        Rectangle {
            id: avatar
            width: 96
            height: 96
            radius: 48
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 40
            color: root.panelRaised
            border.color: root.accent
            border.width: 2

            Text {
                anchors.centerIn: parent
                text: root.user.length > 0 ? root.user.charAt(0).toUpperCase() : "?"
                color: root.accent
                font.family: root.fontName
                font.pixelSize: 40
                font.weight: Font.DemiBold
            }
        }

        Text {
            id: userName
            anchors.top: avatar.bottom
            anchors.topMargin: 14
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.user
            color: root.ink
            font.family: root.fontName
            font.pixelSize: 20
            font.weight: Font.DemiBold
        }

        Rectangle {
            id: passwordField
            width: 300
            height: 44
            anchors.top: userName.bottom
            anchors.topMargin: 22
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 12
            color: root.panelRaised
            border.color: password.activeFocus ? root.accent : root.edge
            border.width: 1

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                text: "Password"
                visible: password.text.length === 0
                color: root.muted
                font.family: root.fontName
                font.pixelSize: 16
            }

            TextInput {
                id: password
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                verticalAlignment: TextInput.AlignVCenter
                echoMode: TextInput.Password
                focus: true
                color: root.ink
                selectionColor: root.accent
                font.family: root.fontName
                font.pixelSize: 16
                Keys.onReturnPressed: root.attemptLogin()
                Keys.onEnterPressed: root.attemptLogin()
            }
        }

        Text {
            id: sessionLabel
            anchors.top: passwordField.bottom
            anchors.topMargin: 16
            anchors.left: passwordField.left
            text: "Session"
            color: root.muted
            font.family: root.fontName
            font.pixelSize: 13
        }

        ComboBox {
            id: session
            z: 10
            width: 300
            height: 44
            anchors.top: sessionLabel.bottom
            anchors.topMargin: 6
            anchors.horizontalCenter: parent.horizontalCenter
            model: sessionModel
            index: sessionModel.lastIndex
            color: root.panelRaised
            menuColor: root.panelRaised
            textColor: root.ink
            borderColor: root.edge
            focusColor: root.accent
            hoverColor: root.accent
            arrowColor: root.panelRaised
            font.family: root.fontName
            font.pixelSize: 15
        }

        Rectangle {
            id: loginButton
            width: 300
            height: 48
            anchors.top: session.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 12
            color: loginArea.containsMouse ? root.accent : Qt.darker(root.accent, 1.15)

            Row {
                anchors.centerIn: parent
                spacing: 8

                Icon {
                    kind: "login"
                    strokeColor: root.accentInk
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Log in"
                    color: root.accentInk
                    font.family: root.fontName
                    font.pixelSize: 16
                    font.weight: Font.DemiBold
                }
            }

            MouseArea {
                id: loginArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.attemptLogin()
            }
        }

        Text {
            id: status
            anchors.top: loginButton.bottom
            anchors.topMargin: 12
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.danger
            font.family: root.fontName
            font.pixelSize: 14
        }
    }

    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 96
        anchors.bottomMargin: 56
        spacing: 28

        Item {
            width: restartRow.width
            height: restartRow.height

            Row {
                id: restartRow
                spacing: 8

                Icon {
                    kind: "restart"
                    strokeColor: restartArea.containsMouse ? root.ink : root.muted
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Restart"
                    color: restartArea.containsMouse ? root.ink : root.muted
                    font.family: root.fontName
                    font.pixelSize: 15
                }
            }

            MouseArea {
                id: restartArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.reboot()
            }
        }

        Item {
            width: powerRow.width
            height: powerRow.height

            Row {
                id: powerRow
                spacing: 8

                Icon {
                    kind: "power"
                    strokeColor: powerArea.containsMouse ? root.ink : root.muted
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Shut down"
                    color: powerArea.containsMouse ? root.ink : root.muted
                    font.family: root.fontName
                    font.pixelSize: 15
                }
            }

            MouseArea {
                id: powerArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.powerOff()
            }
        }
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            password.text = ""
            status.text = "Incorrect password, try again"
        }
    }

    Component.onCompleted: password.forceActiveFocus()
}

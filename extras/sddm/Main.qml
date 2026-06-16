import QtQuick 2.0
import SddmComponents 2.0

// Persona 3 Reload — custom Omarchy SDDM login.
// Full-bleed background image (no logo, no dark overlay) with the lock + password
// field placed on the right side, over the blue water, clear of the figure.
Rectangle {
  id: root
  width: 640
  height: 480
  color: "#0a0f1c"

  property string currentUser: userModel.lastUser
  property bool loginFailed: false
  property int sessionIndex: {
    for (var i = 0; i < sessionModel.rowCount(); i++) {
      var name = (sessionModel.data(sessionModel.index(i, 0), Qt.DisplayRole) || "").toString()
      if (name.indexOf("uwsm") !== -1)
        return i
    }
    return sessionModel.lastIndex
  }

  Connections {
    target: sddm
    function onLoginFailed() {
      root.loginFailed = true
      password.text = ""
      password.focus = true
    }
    function onLoginSucceeded() {
      root.loginFailed = false
    }
  }

  // Full-screen background image (the underwater Makoto)
  Image {
    anchors.fill: parent
    source: "background.png"
    fillMode: Image.PreserveAspectCrop
  }

  // Lock + password field, vertically centered and pushed to the right
  Row {
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.horizontalCenterOffset: 140
    spacing: 15

    Image {
      source: root.loginFailed ? "lock-failed.png" : "lock.png"
      width: 34
      height: 38
      fillMode: Image.PreserveAspectFit
      anchors.verticalCenter: parent.verticalCenter
    }

    Item {
      width: 500
      height: 60

      Image {
        id: entry
        source: root.loginFailed ? "entry-failed.png" : "entry.png"
        anchors.fill: parent
      }

      Row {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Repeater {
          model: Math.min(password.text.length, 36)

          Image {
            source: "bullet.png"
            width: 7
            height: 7
          }
        }
      }

      TextInput {
        id: password
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        verticalAlignment: TextInput.AlignVCenter
        echoMode: TextInput.Password
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 24
        font.letterSpacing: 5
        passwordCharacter: "•"
        color: "transparent"
        selectionColor: "transparent"
        selectedTextColor: "transparent"
        cursorDelegate: Item {}
        focus: true

        onTextChanged: root.loginFailed = false

        Keys.onPressed: {
          if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            sddm.login(root.currentUser, password.text, root.sessionIndex)
            event.accepted = true
          }
        }
      }
    }
  }

  Component.onCompleted: password.forceActiveFocus()
}

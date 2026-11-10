import QtQuick

Canvas {
    id: icon

    property string kind: "login"
    property color strokeColor: "#0b0f18"

    width: 18
    height: 18
    onKindChanged: requestPaint()
    onStrokeColorChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        ctx.save()
        ctx.scale(width / 18, height / 18)
        ctx.strokeStyle = strokeColor
        ctx.lineWidth = 1.8
        ctx.lineCap = "round"
        ctx.lineJoin = "round"

        if (kind === "login") {
            ctx.beginPath()
            ctx.moveTo(9, 3)
            ctx.lineTo(15, 3)
            ctx.lineTo(15, 15)
            ctx.lineTo(9, 15)
            ctx.moveTo(2, 9)
            ctx.lineTo(11, 9)
            ctx.moveTo(7.5, 5.5)
            ctx.lineTo(11, 9)
            ctx.lineTo(7.5, 12.5)
            ctx.stroke()
        } else if (kind === "restart") {
            ctx.beginPath()
            ctx.arc(9, 9, 6, Math.PI * 0.25, Math.PI * 1.85)
            ctx.moveTo(15.5, 3.8)
            ctx.lineTo(14.4, 6.3)
            ctx.lineTo(11.9, 5.6)
            ctx.stroke()
        } else if (kind === "power") {
            ctx.beginPath()
            ctx.arc(9, 9, 6, -1.17, 4.31)
            ctx.moveTo(9, 2.5)
            ctx.lineTo(9, 9)
            ctx.stroke()
        }

        ctx.restore()
    }
}

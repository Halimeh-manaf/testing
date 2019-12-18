import UIKit

struct DataPoint {
    var pos: CGPoint     // Must be in [-1.0...1.0] range
    var label: String
}

class ChartView: UIView {
    
    var dataPoints :[DataPoint]?     // To be loaded in ViewController
    
    override func draw(_ rect: CGRect) {
        // Just for showing some data: initialize some data here ; this must be done in the ViewController
        // y axis starts from top
        let dataOne = DataPoint(pos: CGPoint(x: 0.4, y: 0.5), label: "QAT")
        let dataTwo = DataPoint(pos: CGPoint(x: 0.9, y: -0.2), label: "SWE")
        let dataThree = DataPoint(pos: CGPoint(x: 0.05, y: 0), label: "BEU")
        // dataPoints = [dataOne, dataTwo, dataThree]
        
        // Drawing code
        
        // Set general values
        let margin : CGFloat = 20.0
        let drawingArea = self.bounds.insetBy(dx: margin, dy: margin) // Keep some marging around quadrants
        
        let fullDrawingWidth = drawingArea.width   // self.bounds.width - 2 * margin
        let fullDrawingHeight = drawingArea.height // self.bounds.height - 2 * margin
        let innerMidWidth = fullDrawingWidth / 2.0  // half width of drawing area
        let innerMidHeight = fullDrawingHeight / 2.0
        let midDrawX = margin + innerMidWidth   // x-middle of drawing area: self.bounds.width / 2
        let midDrawY = margin + innerMidHeight  // y-middle of drawing area: self.bounds.height / 2
        
        let drawLeftMost = margin
        let drawRightMost = fullDrawingWidth + margin
        let drawTopMost = margin
        let drawBottomMost = fullDrawingHeight + margin
        
        /* Getting the maximum X/Y-Axis value */
        var xMax : CGFloat
        var yMax : CGFloat
        let maxmimumXDataPoint = dataPoints!.max { $0.pos.x < $1.pos.x }
        let minimimumXDataPoint = dataPoints!.min { $0.pos.x < $1.pos.x }
        let maxmimumYDataPoint = dataPoints!.max { $0.pos.y < $1.pos.y }
        let minimimumYDataPoint = dataPoints!.min { $0.pos.y < $1.pos.y }
        if (maxmimumXDataPoint!.pos.x >= abs(minimimumXDataPoint!.pos.x)){  // in case -x in the nagative is bigger than +x
            xMax = maxmimumXDataPoint!.pos.x + 20
        } else {
            xMax = abs(minimimumXDataPoint!.pos.x) + 20
        }
        if (maxmimumYDataPoint!.pos.y >= abs(minimimumYDataPoint!.pos.y)){  // in case -x in the nagative is bigger than +x
            yMax = maxmimumYDataPoint!.pos.y + 20
        } else {
            yMax = abs(minimimumYDataPoint!.pos.y) + 20
        }
        
        /* Drawing Y-Axis Title */
        //let yTitle = CGPoint(x:6.0,y:margin+40.0)
        let yTitle = CGPoint(x:drawLeftMost - 10.0,y:midDrawY)
       // var title = "Y-title"
        //title.draw(at: yTitle)
        drawRotatedText("Y-Axis", at: yTitle, angle: 270, color: UIColor.black)
        drawRotatedText("Lower →", at: CGPoint(x:drawLeftMost - 10.0,y:drawTopMost + 30), angle: 270, color: UIColor(red: 0, green: 74, blue: 124))
        drawRotatedText("← Higher", at: CGPoint(x:drawLeftMost - 10.0,y:drawBottomMost - 30), angle: 270, color: UIColor(red: 0, green: 74, blue: 124))

        /* Drawing X-Axis Title */
        var xTitle = CGPoint(x:midDrawX - 40.0 ,y:drawBottomMost)
        var attributsBold = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)]
        let marketRisk = NSAttributedString(string: "X-Axis", attributes: attributsBold)
        marketRisk.draw(at: xTitle)
        
        var leftAndRight = NSMutableAttributedString(string: "Higher →", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: .bold)])
        leftAndRight.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.0/255.0, green: 74.0/255.0, blue: 124.0/255.0, alpha: 1.0), range: NSRange(location:0,length:8))
        xTitle = CGPoint(x:drawRightMost - 55  ,y:drawBottomMost )
        leftAndRight.draw(at: xTitle)
        
        leftAndRight = NSMutableAttributedString(string: "← Lower", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: .bold)])
        leftAndRight.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.0/255.0, green: 74.0/255.0, blue: 124.0/255.0, alpha: 1.0), range: NSRange(location:0,length:7))
        xTitle = CGPoint(x:drawLeftMost  ,y:drawBottomMost )
        leftAndRight.draw(at: xTitle)
        
        
        
        // Draw the quadrants background
        // Take care to the orientation of y axis
        let quadBottomLeft = CGRect(x: drawLeftMost, y: midDrawY, width: innerMidWidth, height: innerMidHeight)
        let quadTopLeft = CGRect(x: drawLeftMost, y: drawTopMost, width: innerMidWidth, height: innerMidHeight)
        let quadBottomRight = CGRect(x: midDrawX, y: midDrawY, width: innerMidWidth, height: innerMidHeight)
        let quadTopRight = CGRect(x: midDrawX, y: drawTopMost, width: innerMidWidth, height: innerMidHeight)
        //232,241,245
        var quadPath = UIBezierPath(rect: quadTopLeft)
        UIColor(red: 232, green: 241, blue: 245).setFill()
        quadPath.fill()
        quadPath = UIBezierPath(rect: quadBottomLeft)
        UIColor(red: 250, green: 250, blue: 250).setFill()
        quadPath.fill()
        quadPath = UIBezierPath(rect: quadTopRight)
        UIColor(red: 250, green: 250, blue: 250).setFill()
        quadPath.fill()
        quadPath = UIBezierPath(rect: quadBottomRight)
        UIColor(red: 250, green: 250, blue: 250).setFill()
        quadPath.fill()
        
        let attrib: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 12.0, weight: .bold),
            .foregroundColor: UIColor(hexString: "004A7C")
        ]
        
        /* Drawing Labels */
        attributsBold = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .bold)]
        let topLeft = CGPoint(x:drawLeftMost + 5 ,y:drawTopMost + 10)
        var uiText = NSAttributedString(string: "1 ", attributes: attrib)
        uiText.draw(at: topLeft)
        
        let topRight = CGPoint(x:drawRightMost - 90 ,y:drawTopMost + 10)
        uiText = NSAttributedString(string: "2", attributes: attributsBold)
        uiText.draw(at: topRight)
        
        let bottomLeft = CGPoint(x:drawLeftMost + 5 ,y:drawBottomMost - 20)
        uiText = NSAttributedString(string: "3", attributes: attributsBold)
        uiText.draw(at: bottomLeft)
        
        let bottomRight = CGPoint(x:drawRightMost - 130 ,y:drawBottomMost - 20)
        uiText = NSAttributedString(string: "4", attributes: attributsBold)
        uiText.draw(at: bottomRight)
        
        // Draw horizontal grid lines:
        for i in 1...4 {    // Border frame draws later
            let y = drawTopMost + CGFloat(i) * fullDrawingHeight / 5.0
            let startPoint = CGPoint(x: drawLeftMost, y: y)
            let destPoint = CGPoint(x: drawRightMost, y: y)
            
            let aPath = UIBezierPath()
            aPath.move(to: startPoint)
            aPath.addLine(to: destPoint)
            UIColor(red: 0, green: 74, blue: 124).setStroke()
            aPath.stroke()
        }
        // Draw vertical grid lines
        for j in 1...9 {    // Border frame draws later
            let x = drawLeftMost + CGFloat(j) * fullDrawingWidth / 10.0
            let startPoint = CGPoint(x: x, y: drawTopMost)
            let destPoint = CGPoint(x: x, y: drawBottomMost)
            
            let aPath = UIBezierPath()
            aPath.move(to: startPoint)
            aPath.lineWidth = 0.5
            aPath.addLine(to: destPoint)
            UIColor(red: 0, green: 74, blue: 124).setStroke()
            aPath.stroke()
        }
        
        // Draw frame and axis
        
        let framePath = UIBezierPath(rect: drawingArea)
        framePath.lineWidth = 2.0
        UIColor(red: 0, green: 74, blue: 124).setStroke()
        framePath.stroke()
        
        let axisPath = UIBezierPath()
        // x axis first, with the labels
        axisPath.move(to: CGPoint(x: drawLeftMost, y: midDrawY))
        axisPath.lineWidth = 2.0
        axisPath.addLine(to: CGPoint(x: drawRightMost, y: midDrawY))
        UIColor(red: 0, green: 74, blue: 124).setStroke()
        axisPath.stroke()
        
        // Attribute
        var attribute = [NSAttributedString.Key.font:  UIFont(name: "Helvetica", size: 10.0)!] as [NSAttributedString.Key : Any]?
        
        var step = Int(xMax) / 5
        var oldstep = -1 * Int(xMax)
        for j in 0...10 {
            var scalePoint = CGPoint.zero
            // print("j: ", j , "Value: ", (j - 5) * 20)
            if (j == 0) {
                scalePoint.x = drawLeftMost + 2 + CGFloat(j) * fullDrawingWidth / 10.0 // -10 to center on grid line
                scalePoint.y = midDrawY - 5 - fullDrawingHeight / 50.0 // -5 to draw above x axis
                //let value = (j - 5) * 20
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = value == 0 ? "" : "\(value)%"
                let uiText = NSAttributedString(string: textToDraw, attributes: attribute)
                uiText.draw(at: scalePoint)
            }else if (j == 10){
                scalePoint.x = drawLeftMost - 28 + CGFloat(j) * fullDrawingWidth / 10.0 // -10 to center on grid line
                scalePoint.y = midDrawY - 5 - fullDrawingHeight / 50.0 // -5 to draw above x axis
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = value == 0 ? "" : "\(value)%"
                let uiText = NSAttributedString(string: textToDraw, attributes: attribute)
                uiText.draw(at: scalePoint)
            } else if (j == 1 || j == 2 || j == 3 || j == 4 ){
                scalePoint.x = drawLeftMost + 1 + CGFloat(j) * fullDrawingWidth / 10.0 // -10 to center on grid line
                scalePoint.y = midDrawY - 5 - fullDrawingHeight / 50.0 // -5 to draw above x axis
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = value == 0 ? "" : "\(value)%"
                let uiText = NSAttributedString(string: textToDraw, attributes: attribute)
                uiText.draw(at: scalePoint)
            } else if (j == 6 || j == 7 || j == 8 || j == 9 ){
                scalePoint.x = drawLeftMost - 20 + CGFloat(j) * fullDrawingWidth / 10.0 // -10 to center on grid line
                scalePoint.y = midDrawY - 5 - fullDrawingHeight / 50.0 // -5 to draw above x axis
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = value == 0 ? "" : "\(value)%"
                let uiText = NSAttributedString(string: textToDraw, attributes: attribute)
                uiText.draw(at: scalePoint)
            } else if (j == 5 ){
                oldstep = oldstep + step
            }
            
        }
        
        // y axis now
        axisPath.move(to: CGPoint(x: midDrawX, y: drawTopMost))
        UIColor(red: 0, green: 74, blue: 124).setStroke()
        axisPath.addLine(to: CGPoint(x: midDrawX, y: drawBottomMost))
        axisPath.stroke()
        
        step = Int(yMax) / 3
        oldstep = -1 * Int(yMax)
        for i in 0...5 {
            var scalePoint = CGPoint.zero
            //print ("i: ", i , "value: ", (2*i - 5) * 20)
            if (i == 0) {
                scalePoint.x = midDrawX - 35
                scalePoint.y = drawTopMost  + CGFloat(i) * fullDrawingHeight / 5.0 // -4 to center on grid line
                //let value = (2*i - 5) * 20
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = "\(value)%"
                textToDraw.draw(at: scalePoint)
            } else if (i == 5){
                scalePoint.x = midDrawX - 34
                scalePoint.y = drawTopMost - 16 + CGFloat(i) * fullDrawingHeight / 5.0 // -4 to center on grid line
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = "\(value)%"
                textToDraw.draw(at: scalePoint)
            } else if (i == 3){
                scalePoint.x = midDrawX - 30
                scalePoint.y = drawTopMost - 8 + CGFloat(i) * fullDrawingHeight / 5.0 // -4 to center on grid line
                oldstep = oldstep + step
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = "\(value)%"
                textToDraw.draw(at: scalePoint)
            } else {
                scalePoint.x = midDrawX - 30
                scalePoint.y = drawTopMost - 8 + CGFloat(i) * fullDrawingHeight / 5.0 // -4 to center on grid line
                let value = oldstep
                oldstep = oldstep + step
                let textToDraw = "\(value)%"
                textToDraw.draw(at: scalePoint)
            }
        }
        
        // Draw data points
        
        var xMin = -1 * xMax
        var yMin = -1 * yMax
        
        //print("max X : ",xMax, " max Y: ",yMax, " X Min: ", xMin, "yMin: ", yMin)
        if let dataPoints = dataPoints {
            for dataPoint in dataPoints {
                var drawPoint = CGPoint.zero
                var varX = dataPoint.pos.x
                var varY = dataPoint.pos.y
                var scaledX = ((varX - xMin)/(xMax - xMin)) * (2) - 1
                var scaledY = ((varY - yMin)/(yMax - yMin)) * (2) - 1
                //print("scaledX: ", scaledX, "scaledY: ", scaledY)
                //drawPoint.x = midDrawX + innerMidWidth * dataPoint.pos.x // pos.x is in [-1...+1] range
                drawPoint.x = midDrawX + innerMidWidth * scaledX // pos.x is in [-1...+1] range
                drawPoint.y = midDrawY + innerMidHeight * scaledY // pos.y is in [-1...+1] range ; y axis: -1.0 is top, 1.0 bottom
                let dotRect = CGRect(x: drawPoint.x - 3, y: drawPoint.y - 3, width: 6.0, height: 6.0)
                let dotPath = UIBezierPath(ovalIn: dotRect)
                UIColor.red.setFill()
                dotPath.fill()
                let textToDraw = dataPoint.label
                textToDraw.draw(at: drawPoint)
            }
        }
        
    }
    
    func drawRotatedText(_ text: String, at p: CGPoint, angle: CGFloat, color: UIColor) {
        // Draw text centered on the point, rotated by an angle in degrees moving clockwise.
       // let attrs = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 10.0), NSAttributedString.Key.foregroundColor: color]
            let attributsBold = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .bold),NSAttributedString.Key.foregroundColor: color]
            let textSize = text.size(withAttributes: attributsBold as [NSAttributedString.Key : Any])
            let c = UIGraphicsGetCurrentContext()!
            c.saveGState()
            // Translate the origin to the drawing location and rotate the coordinate system.
            c.translateBy(x: p.x, y: p.y)
            c.rotate(by: angle * .pi / 180)
            // Draw the text centered at the point.
            text.draw(at: CGPoint(x: -textSize.width / 2, y: -textSize.height / 2), withAttributes: attributsBold as [NSAttributedString.Key : Any])
            // Restore the original coordinate system.
            c.restoreGState()
        
    }
    
}

extension UIColor {
convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
}
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

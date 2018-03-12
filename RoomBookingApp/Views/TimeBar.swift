//
//  TimeBar.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import UIKit

fileprivate extension Float {
    
    // Normalized value: (v - minV) / (maxV - minV) -> minV = 0, maxV = 60
    var normalized: Float {
        return self / 60
    }
    
    // Shifted value to 0: available format: 07:00 - 19:00 -> (v - 7)
    var shifted: Float {
        return self - 7
    }
    
}

fileprivate struct TimeFrame {
    
    var fromHour: CGFloat!
    var fromMinute: CGFloat!
    var toHour: CGFloat!
    var toMinute: CGFloat!
    
    var from: CGFloat {
        return fromHour + fromMinute
    }
    
    var to: CGFloat {
        return toHour + toMinute
    }
    
    init(fromHour: CGFloat = 0, fromMinute: CGFloat = 0, toHour: CGFloat = 0, toMinute: CGFloat = 0) {
        self.fromHour = fromHour
        self.fromMinute = fromMinute
        self.toHour = toHour
        self.toMinute = toMinute
    }
    
}

class TimeBar: UIView {
    
    // MARK: - Properties
    
    fileprivate var timeFrames: [TimeFrame] = []
    
    fileprivate let rawItemTitles: [String] = ["7:00", "8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"]
    fileprivate var itemTitles: [NSAttributedString] = []
    
    fileprivate var path = UIBezierPath()
    
    fileprivate var barWidthMultiple: CGFloat {
        return 12
    }
    
    fileprivate var itemRawWidth: CGFloat {
        return bounds.width / barWidthMultiple
    }
    
    fileprivate var barHorizontalPadding: CGFloat {
        return itemRawWidth / 2
    }
    
    fileprivate var barVerticalPadding: CGFloat {
        return bounds.height / 3
    }
    
    fileprivate var itemWidth: CGFloat {
        return itemRawWidth - (barHorizontalPadding * 2) / barWidthMultiple
    }
    
    fileprivate var barHeight: CGFloat {
        return bounds.height / 3
    }
    
    fileprivate var barMinX: CGFloat {
        return bounds.minX + barHorizontalPadding
    }
    
    fileprivate var barMaxX: CGFloat {
        return bounds.maxX - barHorizontalPadding
    }
    
    fileprivate var barMinY: CGFloat {
        return bounds.minY + barVerticalPadding
    }
    
    fileprivate var barMaxY: CGFloat {
        return bounds.maxY - barVerticalPadding
    }
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Configuration
    
    func configure(with timeFrames: [String]?) {
        configureTimeFrames(with: timeFrames)
        configureItemTitles()
    }
    
    func clear() {
        let context = UIGraphicsGetCurrentContext()
        context?.clear(bounds)
        setNeedsDisplay()
    }
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawBarBackground()
        
        for timeFrame in timeFrames {
            drawTimeFrame(start: timeFrame.from, end: timeFrame.to)
        }
        
        drawSeparators()
        
        drawItemTitles()
    }
    
    fileprivate func drawSeparators() {
        path = UIBezierPath()
        path.lineWidth = 1.0

        for index in 1...Int(barWidthMultiple) - 1 {
            path.move(to: CGPoint(x: barMinX + CGFloat(index) * itemWidth, y: barMinY))
            path.addLine(to: CGPoint(x: barMinX + CGFloat(index) * itemWidth, y: barMaxY))
        }

        path.close()

        Color.white.setStroke()
        path.stroke()
    }
    
    fileprivate func drawBarBackground() {
        path = UIBezierPath()
        
        // TL
        path.move(to: CGPoint(x: barMinX, y: barMinY))
        // TL->BL
        path.addLine(to: CGPoint(x: barMinX, y: barMaxY))
        // BL->BR
        path.addLine(to: CGPoint(x: barMaxX, y: barMaxY))
        // BR->TR
        path.addLine(to: CGPoint(x: barMaxX, y: barMinY))
        
        path.close()
        
        Color.red.setFill()
        path.fill()
    }
    
}

// MARK: - Time frames

extension TimeBar {
    
    fileprivate func configureTimeFrames(with timeFrames: [String]?) {
        if let availableTimeFrames = timeFrames {
            self.timeFrames = []
            for availableTimeFrame in availableTimeFrames {
                let components = availableTimeFrame.components(separatedBy: "-")
                // Proceed only if there are both FROM and TO components
                if components.count == 2 {
                    var timeFrame = TimeFrame()
                    
                    let fromComponent = components[0].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ":")
                    // Proceed only if there are both HOUR and MINUTE components
                    if fromComponent.count == 2 {
                        if let fromHour = Float(fromComponent[0]), let fromMinute = Float(fromComponent[1]) {
                            timeFrame.fromHour = CGFloat(fromHour.shifted)
                            timeFrame.fromMinute = CGFloat(fromMinute.normalized)
                        }
                    }
                    
                    let toComponent = components[1].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ":")
                    // Proceed only if there are both HOUR and MINUTE components
                    if toComponent.count == 2 {
                        if let toHour = Float(toComponent[0]), let toMinute = Float(toComponent[1]) {
                            timeFrame.toHour = CGFloat(toHour.shifted)
                            timeFrame.toMinute = CGFloat(toMinute.normalized)
                        }
                    }
                    
                    // Proceed only if FROM component if lesser than TO component
                    if timeFrame.from < timeFrame.to {
                        self.timeFrames.append(timeFrame)
                    }
                }
            }
        }
    }
    
    fileprivate func drawTimeFrame(start: CGFloat, end: CGFloat) {
        path = UIBezierPath()
        
        // TL
        path.move(to: CGPoint(x: barMinX + start * itemWidth, y: barMinY))
        // TL->BL
        path.addLine(to: CGPoint(x: barMinX + start * itemWidth, y: barMaxY))
        // BL->BR
        path.addLine(to: CGPoint(x: barMinX + end * itemWidth, y: barMaxY))
        // BR->TR
        path.addLine(to: CGPoint(x: barMinX + end * itemWidth, y: barMinY))

        path.close()

        Color.green.setFill()
        path.fill()
    }
    
}

// MARK: - Item titles

extension TimeBar {
    
    fileprivate func configureItemTitles() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let oddAttributes = [NSAttributedStringKey.paragraphStyle  : paragraphStyle,
                             NSAttributedStringKey.font            : UIFont.systemFont(ofSize: 8.0),
                             NSAttributedStringKey.foregroundColor : Color.black]
        let evenAttributes = [NSAttributedStringKey.paragraphStyle  : paragraphStyle,
                              NSAttributedStringKey.font            : UIFont.systemFont(ofSize: 8.0),
                              NSAttributedStringKey.foregroundColor : Color.gray]
        
        itemTitles = []
        for (index, title) in rawItemTitles.enumerated() {
            itemTitles.append(NSAttributedString(string: title, attributes: index % 2 == 0 ? oddAttributes : evenAttributes))
        }
    }
    
    fileprivate func drawItemTitles() {
        for (index, title) in itemTitles.enumerated() {
            title.draw(in: CGRect(x: CGFloat(index) * itemWidth, y: 0, width: itemWidth, height: barHeight))
        }
    }
    
}

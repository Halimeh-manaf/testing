//
//  ChartTestViewController.swift
//  app
//
//  Created by Manaf Najdat Halimah on 19.11.19.
//

import UIKit

class ViewConroller: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var charty: ChartView!
    @IBOutlet weak var ZoomLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var quadrantHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var quadrantWidthConstraint: NSLayoutConstraint!
    private var standardQuadrantWidthConstraint : CGFloat!
    private var standardQuadrantHeightConstraint : CGFloat!
    private var standardQuadrantChartSize : CGSize!   // xib values
    private var originalQuadrantChartSize : CGSize!   // xib values

    
        private var zoom = 0   { // +1 to +4 if zoom in, -1 to -2 zoom out
            didSet {
                if zoom >= 0 {
                    zoomFactor = 1.0 + 0.25 * CGFloat(zoom) // 125, 150…
                } else {
                    zoomFactor = 1.0 + 0.2 * CGFloat(zoom)  // 80, 60
                }
              //  zoomInButton.isEnabled = zoom < 4
             //   zoomOutButton.isEnabled = zoom > -2
                stepper.value = Double(zoom)
            }
        }
    
        private var zoomFactor : CGFloat = 1.0 {
            didSet {
                if (zoom == 0){
                    ZoomLabel.text = String(format: "%.0f", 100 * zoomFactor) + "%"
                    print(originalQuadrantChartSize.width, originalQuadrantChartSize.height)
                    quadrantWidthConstraint.constant = originalQuadrantChartSize.width
                    quadrantHeightConstraint.constant = originalQuadrantChartSize.height
                    print("quadrant height: ", originalQuadrantChartSize.height, "quadrant width: ",originalQuadrantChartSize.width)
                    ScrollView.contentSize = originalQuadrantChartSize
                    ScrollView.frame.size = originalQuadrantChartSize
                    charty.frame.size = originalQuadrantChartSize
                    charty.setNeedsDisplay()
                    ScrollView.setNeedsDisplay()
                    print("CALLED")
                    print("chart: ", charty.frame.size)
                    print("Scroll: ", ScrollView.frame.size)
                }else {
                    ZoomLabel.text = String(format: "%.0f", 100 * zoomFactor) + "%"
                    quadrantWidthConstraint.constant = standardQuadrantWidthConstraint * zoomFactor
                    quadrantHeightConstraint.constant = standardQuadrantHeightConstraint * zoomFactor
                    let newContentSize = CGSize(width: zoomFactor * standardQuadrantChartSize.width, height: zoomFactor * standardQuadrantChartSize.height)
                    ScrollView.contentSize = newContentSize
                    charty.setNeedsDisplay()
                }
                
            }
        }
    
    var oldValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldValue = Int(stepper.value);
        ZoomLabel.text = "100%"
        ScrollView.minimumZoomScale = 1.0
        ScrollView.maximumZoomScale = 6.0
        var myarray : [DataPoint] = []
        let p1 = DataPoint(pos: CGPoint(x:-500,y: -400),label: "DE1")
        let p7 = DataPoint(pos: CGPoint(x:-400,y: -400),label: "DE2")
        let p8 = DataPoint(pos: CGPoint(x:-240,y: -400),label: "DE3")
        let p9 = DataPoint(pos: CGPoint(x:-120,y: -200),label: "DE4")
        let p2 = DataPoint(pos: CGPoint(x:0,y: 0),label: "JO")
        let p3 = DataPoint(pos: CGPoint(x:-153,y: 432),label: "POL")
        let p4 = DataPoint(pos: CGPoint(x:120,y: 160),label: "FRA1")
        let p5 = DataPoint(pos: CGPoint(x:321,y: 321),label: "FRA2")
        let p6 = DataPoint(pos: CGPoint(x:350,y: 550),label: "FRA3")
        myarray.append(p1)
        myarray.append(p2)
        myarray.append(p3)
        myarray.append(p4)
        myarray.append(p5)
        myarray.append(p6)
        myarray.append(p7)
        myarray.append(p8)
        myarray.append(p9)

        charty.dataPoints = myarray
        
        standardQuadrantChartSize = charty.frame.size    // Initial size, from xib
        originalQuadrantChartSize = charty.frame.size
        ScrollView.contentSize = standardQuadrantChartSize    // Initial size, from xib
        //standardQuadrantWidthConstraint = quadrantWidthConstraint.constant  // Initial size, from xib
        //standardQuadrantHeightConstraint = quadrantHeightConstraint.constant    // Initial size, from xib
        standardQuadrantWidthConstraint = standardQuadrantChartSize.width // Initial size, from xib
        standardQuadrantHeightConstraint = standardQuadrantChartSize.height   // Initial size, from xib
        ScrollView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        print("Scroll Size: ",ScrollView.frame.size, "Charty Size: ", charty.frame.size)
        /*
        let zoomFactor = 1.0 + 0.25 * CGFloat(1)
        ZoomLabel.text = String(format: "%.0f", 100 * zoomFactor) + "%"
        quadrantWidthConstraint.constant *= 1.25
        quadrantHeightConstraint.constant *= 1.25
        let oldContentSize = charty.frame.size
        let newContentSize = CGSize(width: 1.25 * oldContentSize.width, height: 1.25 * oldContentSize.height)
        ScrollView.contentSize = newContentSize
        charty.setNeedsDisplay()
 */
    }
    
      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
        print("Width: ",standardQuadrantWidthConstraint,"height: ", standardQuadrantHeightConstraint)
          let extraWidth = ScrollView.frame.width - ScrollView.contentSize.width
                    if extraWidth > 8 {
                        //quadrantLeadingConstraint.constant = extraWidth / 2
                    } else {
                          //  quadrantLeadingConstraint.constant = 4
                        }
                           charty.setNeedsDisplay()
          
      }
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        zoom = Int(sender.value)
    }
    
   
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return charty
    }
    
}


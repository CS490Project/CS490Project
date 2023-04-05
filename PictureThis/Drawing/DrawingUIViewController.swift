//
//  DrawingUIViewController.swift
//  PictureThis
//
//  Created by Daven Gujral on 3/27/23.
//
 
import UIKit
import PencilKit
 
class DrawingUIViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
 
 
 
 
    @IBOutlet weak var canvasView: PKCanvasView!
 
    let CanvasWidth: CGFloat = 768
    let CanvasOverscrollHeight: CGFloat = 500
 
    var drawing = PKDrawing()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.delegate = self
        canvasView.drawing = drawing
 
        canvasView.alwaysBounceVertical = true
        canvasView.allowsFingerDrawing = true
 
        if let window = parent?.view.window,
        let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
 
            canvasView.becomeFirstResponder()
        }
 
        // Do any additional setup after loading the view.
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
        let canvasScale = canvasView.bounds.width / CanvasWidth
        canvasView.minimumZoomScale = canvasScale
        canvasView.maximumZoomScale = canvasScale
        canvasView.zoomScale = canvasScale
 
        updateContentSizeForDrawing()
 
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
    }
 
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
 
 
 
    @IBAction func saveImage(_ sender: Any) {
        
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateContentSizeForDrawing()
    }
 
 
    func updateContentSizeForDrawing(){
        let drawing = canvasView.drawing
        let contentHeight: CGFloat
 
        if !drawing.bounds.isNull{
            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + self.CanvasOverscrollHeight) * canvasView.zoomScale)
        }else {
            contentHeight = canvasView.bounds.height
        }
 
        //canvasView.contentSize = CGSize(width: canvasView * canvasView.zoomScale, height: contentHeight)
 
    }
 
 
    /*
    // MARK: - Navigation
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 
}

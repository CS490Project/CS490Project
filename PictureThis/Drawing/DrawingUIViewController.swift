//
//  DrawingUIViewController.swift
//  PictureThis
//
//  Created by Daven Gujral on 3/27/23.
//
 
import UIKit
import PencilKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class DrawingUIViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {
 
 
 
 
    @IBOutlet weak var canvasView: PKCanvasView!
    
    var toolPicker: PKToolPicker!
 
    let CanvasWidth: CGFloat = 0
    let CanvasOverscrollHeight: CGFloat = 100
 
    var drawing = PKDrawing()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.delegate = self
        canvasView.drawing = drawing
 
        canvasView.alwaysBounceVertical = true
//        canvasView.allowsFingerDrawing = true
        // Set up the tool picker
        if #available(iOS 14.0, *) {
            toolPicker = PKToolPicker()
            
        } else {
            // Set up the tool picker, using the window of our parent because our view has not
            // been added to a window yet.
            
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
            
        }
        
 
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        toolPicker.addObserver(self)
//        updateLayout(for: toolPicker)
        canvasView.becomeFirstResponder()
        
    
 
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
 
 
 // This function is the saving button
    @IBAction func saveImage(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil) {
            let storageRef = Storage.storage().reference()
            let imageData = image!.jpegData(compressionQuality: 0.3)
            
            guard imageData != nil else {
                print("error in saving image")
                return
            }
            
            let userID = Auth.auth().currentUser!.uid
            
            let fileRef = storageRef.child("images/\(userID)/\(UUID().uuidString).jpg")
            
            let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
                
                // Check for errors
                if error ==  nil && metadata != nil {
                    // @TODO: Save a reference to the file in Firestone DB.
                }
            }
            
        } else {
            print("Image is null")
        }
        
        self.performSegue(withIdentifier: "saveSegue", sender: nil)
    }
    /// Should be saved under image
    
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

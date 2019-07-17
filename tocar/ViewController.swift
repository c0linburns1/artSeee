//
//  ViewController.swift
//  tocar
//
//  Created by Colin Burns on 7/10/19.
//  Copyright © 2019 Colin Burns. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create an image tracking session, then tell the app what to track
        let configuration = ARImageTrackingConfiguration()
        if let tracked = ARReferenceImage.referenceImages(inGroupNamed: "art", bundle: Bundle.main){
            configuration.trackingImages = tracked
            configuration.maximumNumberOfTrackedImages = 2
            
        }
        
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView) else { return }
        print(location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imgAnchor =  anchor as? ARImageAnchor {
            let size = imgAnchor.referenceImage.physicalSize
            let box = SCNBox(width: size.width, height: size.height, length: (size.height*0.5), chamferRadius: 0.0)
            //let plane = SCNPlane(width: size.width, height: size.height)
            //plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "abe.jpg")
            box.materials = [material]
            let boxNode = SCNNode(geometry: box)
            boxNode.eulerAngles.x = -.pi/2
            node.addChildNode(boxNode)
            
        }
        
        
        return node
        
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
       
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

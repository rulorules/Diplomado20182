//
//  ViewController.swift
//  FirebaseML
//
//  Created by Germán Santos Jaimes on 5/20/18.
//  Copyright © 2018 Germán Santos Jaimes. All rights reserved.
//

import UIKit
import AVFoundation  // Para el manejo de Video
import Firebase

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    // Conexión de componentes
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var barCodeValue: UILabel!
    
    // Control de la sesión de Video
    let session = AVCaptureSession()

    // Instancias que nos ayudaran a interpretar el video y detectar el código de barras
    // Estas lineas son parte del API de Firebase
    // Dejamos al final a vision
    lazy var vision = Vision.vision()
    var barcodeDetector : VisionBarcodeDetector?

    override func viewDidLoad() {
        super.viewDidLoad()

        print("inicio")

        startVideo()
        self.barcodeDetector = vision.barcodeDetector()

    }

    // Se le notifica al delegado (ViewController) que hay un nuevo frame
    // Para usar esta funcion es necesario usar el protocolo AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if let barcodeDetector = self.barcodeDetector {
            // Asignamos el frame o buffer de frames que envia se envio al delegado
            // por lo que creamos un Objeto VisionImage con esa información
            // Este objeto sera usado para la detección del modelo a usar (codigo de barras)
            
            let visionImage = VisionImage(buffer: sampleBuffer)
            
            // Le pasamos la imagen o imágenes recibidas con las que se construye visionImage
            // y usando el modelo de barcode checamos si existe un codigo o codigos de barra.
            
            barcodeDetector.detect(in: visionImage) { (barcodes, error) in
                
                // Algo paso, existe un error y se sale.
                if let error = error{
                    print("Hubo un error", error.localizedDescription)
                    return
                }
                
                // No ha pasado nada y checamos si hay un codigo de barras o varios
                for barcode in  barcodes!{
                    print("Codigo de barras detectado", barcode.rawValue!)
                    // A nuestro componente UILabel le colocamos el valor o posibles valores.
                    self.barCodeValue.text = barcode.rawValue!
                }
            }

        }
    }


   // Inicializamos la captura de video
    private func startVideo(){

        // indicamos la calidad del bitrate, en este caso alta resolución
        session.sessionPreset = AVCaptureSession.Preset.photo

        // Indicamos que utilizaremos el dispositivo para capturar video
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)

        // Se indica la entrada
        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)

        // Se indica la captura, se graba el video y se proporciona el acceso para su procesamiento, se usaran 32Bits en BGRA
        let deviceOutput = AVCaptureVideoDataOutput()
        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        // Indicamos el delgado y la cola de procesamiento
        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))

        // Conectamos entrada y salida a la sesión
        session.addInput(deviceInput)
        session.addOutput(deviceOutput)

        // Ahora a mostrar lo que se captura
        let imageLayer = AVCaptureVideoPreviewLayer(session: session)

        imageLayer.frame = CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height)
        imageLayer.videoGravity = .resizeAspectFill
        imageView.layer.addSublayer(imageLayer)

        session.startRunning()
        print("iniciando sesion")

    }
    
    
}

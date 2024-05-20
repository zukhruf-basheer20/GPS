import UIKit
import GoogleMaps

class GoogleMaps: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyD8ulZb78To5d24E7WMiWb-WAX1npH-YKg")
        title = "Google Maps"
        let camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(), camera: camera)
        view = mapView
    }
}

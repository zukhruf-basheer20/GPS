import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class ExploreVC: UIViewController, SearchVCDelegate, CLLocationManagerDelegate {
    func panal(_ vc: SearchVC) {
        panel.move(to: .full, animated: true)
    }
    
    func searchViewController(_ vc: SearchVC, didSelectLoactionWith coordinate: CLLocationCoordinate2D?) {
        guard let coordinates = coordinate else {
            return
        }
        panel.move(to: .tip, animated: true)
        mapView.removeAnnotations(mapView.annotations)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(center: coordinates,
                                             span: MKCoordinateSpan(
                                                latitudeDelta: 0, longitudeDelta: 0
                                             )),
                          animated: true)
        
    }
    
    let locationManager = CLLocationManager()
    let panel = FloatingPanelController()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Location"
        let searchVC = SearchVC()
        searchVC.delegate = self
       
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        panel.move(to: .full, animated: true)
    }
}

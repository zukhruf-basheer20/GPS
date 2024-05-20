import Foundation
import UIKit
import CoreLocation

struct Location {
    let title: String
    let coordinate: CLLocationCoordinate2D?
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    public func findLoaction(with query: String, complition: @escaping (([Location]) -> Void)) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                complition([])
                return
            }
            let models: [Location] = places.compactMap({ place in
                var name = ""
                
                if let loactionName = place.name {
                    name += loactionName
                }
                if let adminRegion = place.administrativeArea {
                    name += ", \(adminRegion)"
                }
                if let loacality = place.locality {
                    name += ", \(loacality)"
                }
                if let country = place.country {
                    name += ", \(country)"
                }
                
                print("****\n\n\(place)\n\n****")
                
                let result = Location(title: name, coordinate: place.location?.coordinate
                )
                return result
            })
            complition(models)
        }
    }
}


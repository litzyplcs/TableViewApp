//
//  ViewController.swift
//  TableStory
//
//  Created by Palacios, Litzy N on 3/17/25.
//

import UIKit
import MapKit


//array objects of our data.
let data = [
    Item(name: "Lago de Ilopango", neighborhood: "Dolores Apulo", desc: "A breathtaking lake with deep blue waters, inviting visitors to swim, kayak, or embark on a scenic boat tour. You can also enjoy delicious bites from local snack and food stands, making it the perfect spot to relax and explore.", lat: 13.7000, long: -89.0833, imageName: "salv1", add:"Km. 16 Cantón Dolores, Carretera a Corinto, Ilopango, El Salvador"),
    Item(name: "National Palace", neighborhood: "San Salvador", desc: "A stunning architectural gem in the heart of the country's capital city. It was built in the early 20th century and is a historic landmark that showcases the country’s rich past.", lat: 13.6975, long: -89.1917, imageName: "salv2", add:"Avenida Cuscatlan, San Salvador, El Salvador"),
    Item(name: "Finca Rauda", neighborhood: "Alegria", desc: "A paradise full of adventures for nature lovers and thrill-seekers. They offer scenic trails, amazing viewpoints, RV riding, zip-lining, and camping. They also have a variety of delicious local cuisine.", lat: 13.50751, long: -88.48359, imageName: "salv3", add:"Cantón San Juan, Desvío a la Laguna de Alegría, Usulutan, El Salvador"),
    Item(name: "Cuevas de Moncagua", neighborhood: "Moncagua", desc: "This destination features crystal-clear thermal pools surrounded by ancient rock formations that create a cave. You can relax in the warm waters, rent chairs and tables, and enjoy snacks or fruits from the food stands.", lat: 13.5324, long: -88.2483, imageName: "salv4", add:"GQM2+2MQ, Moncagua, El Salvador"),
    Item(name: "Biblioteca Nacional (BINAES)", neighborhood: "San Salvador", desc: "A new modern library in the capital city. It has a vast collection of books, digital resources, and interactive spaces. BINAES offers a world of knowledge for all ages with engaging workshops and immersive exhibits.", lat: 13.6968, long: -89.1913, imageName: "salv5", add:"4 Calle Ote., San Salvador, El Salvador")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
    var add: String
}






class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      //Add image references
          let image = UIImage(named: item.imageName)
          cell?.imageView?.image = image
          cell?.imageView?.layer.cornerRadius = 10
          cell?.imageView?.layer.borderWidth = 5
          cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      
      return cell!
  }
      
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    

    
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
         
          
              
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        theTable.delegate = self
        theTable.dataSource = self
        
        //add this code in viewDidLoad function in the original ViewController, below the self statements

        //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 13.50751, longitude: -88.48359)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 1.3, longitudeDelta: 1.3))
        mapView.setRegion(region, animated: true)
               
        // loop through the items in the dataset and place them on the map
        for item in data {
        let annotation = MKPointAnnotation()
        let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
        annotation.coordinate = eachCoordinate
        annotation.title = item.name
        mapView.addAnnotation(annotation)
        }
    }


}


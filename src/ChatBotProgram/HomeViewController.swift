


import UIKit
import PromiseKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CompletionDelegate {
   
    @IBOutlet weak var events: UICollectionView!
    @IBOutlet weak var menuButton: UIButton!

//    @IBOutlet weak var cityNameLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var iconWeatherImageView: UIImageView!
//    @IBOutlet weak var temperatureLabel: UILabel!
//    @IBOutlet weak var unitLabel: UILabel!
//    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var iconButtonImageView: UIImageView!
    
    
    let cellIdentifier = "MyCollectionCell"

//    @IBOutlet weak var temperatureView: UIView!
    
    let transition = CircularTransition()
    

    func reloadIndexPaths() {

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func loadView() {
        super.loadView()
        

    
        
        
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpGesture))
//        swipeUp.direction = .up
//        self.view.addGestureRecognizer(swipeUp)
//        
        //Gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.purpleEnd.cgColor, UIColor.purpleStart.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        //load weather
        loadLocalWeather()

    }
    func update() {
        events.reloadData()
        print("dasadaadsdsadsa")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events.backgroundColor = .clear
        
        //button
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        menuButton.layer.borderColor = UIColor.buttonBorder.cgColor
        menuButton.layer.borderWidth = 1
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowOpacity = 0.2
        menuButton.layer.shadowOffset = CGSize.zero
        menuButton.layer.shadowRadius = 3
        wrapperView.layer.cornerRadius = wrapperView.frame.size.width / 2
        
//        self.events.register(UINib(nibName:"MyCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
//        //or if you use class:
//        self.events.register(GenericCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
      //  events.dataSource = self
      //  events.delegate = self

        //hide elements
//        cityNameLabel.alpha = 0
//        dateLabel.alpha = 0
//        iconWeatherImageView.alpha = 0
//        temperatureView.alpha = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! ChatViewController
        secondVC.delegate = self
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GenericCollectionViewCell
        
        //in this example I added a label named "title" into the MyCollectionCell class
        cell.label.text = (memories[indexPath.row]).text
        
        
        
        

        
        
        
        
        print(cell.label.text!)
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = wrapperView.center
        transition.circleColor = UIColor.chatBackgroundEnd
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = wrapperView.center
        transition.circleColor = menuButton.backgroundColor!
                
        return transition
        
    }
    
    func loadLocalWeather() {
        firstly {
            getLocation()
        }.then { (coordinates) -> Promise<Weather> in
            WeatherService(WeatherRequest(coordinates: coordinates)).getWeather()
        }.then { weather in
            self.updateWeatherData(weather)
        }.catch{ (error) in
            print("error! ")
        }
    }
    
    func updateWeatherData(_ weather: Weather) {
        DispatchQueue.main.async {
//            
//            self.cityNameLabel.text = weather.location?.city ?? "Unknow City"
//            let dateFormatterHeader = DateFormatter()
//            dateFormatterHeader.setLocalizedDateFormatFromTemplate("MMMM dd yyyy")
//            self.dateLabel.text = dateFormatterHeader.string(from: Date())
//            self.iconWeatherImageView.image = weather.condition.weatherIcon.image
//            self.temperatureLabel.text = Int(weather.condition.temp).description
//            self.unitLabel.text = weather.unit!.temperature
//            self.statusLabel.text = weather.condition.text.uppercased()
//            
//            UIView.animate(withDuration: 0.5) {
//                self.cityNameLabel.alpha = 1
//                self.dateLabel.alpha = 1
//                self.iconWeatherImageView.alpha = 1
//                self.temperatureView.alpha = 1
//            }
            
        }
    }
    
    func getLocation() -> Promise<CLLocationCoordinate2D> {
        return Promise { fulfill, reject in
            firstly {
                CLLocationManager.promise()
                }.then { location in
                    fulfill(location.coordinate)
                }.catch { (error) in
                    reject(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


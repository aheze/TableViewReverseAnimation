//
//  ProductViewController.swift
//  TableViewReverseAnimation
//
//  Created by Zheng on 10/10/20.
//

import UIKit

struct Product:Equatable {
    let imagename: UIImage
}
class ProductViewController: UIViewController, UITableViewDataSource,
                             UITableViewDelegate {
    
    var productMap = [
        0: [ Product(imagename: UIImage(named: "image1")!), Product( imagename: UIImage(named: "image2")!) ],
        1: [ Product(imagename: UIImage(named: "image3")!), Product(imagename: UIImage(named: "image4")!), Product(imagename: UIImage(named: "image1")!)],
        2: [ Product( imagename: UIImage(named: "image2")!),Product(imagename: UIImage(named: "image3")!)] ,
        3: [ Product( imagename: UIImage(named: "image4")!),Product( imagename: UIImage(named: "image1")!) ],
        4: [ Product(imagename: UIImage(named: "image2")!),Product(  imagename: UIImage(named: "image3")!) ] ]
    
    var selectedIndexPaths = [IndexPath]() /// store the selected product -aheze
    
    
    let notificationButton = SSBadgeButton()
    let rightbarbuttonimage = UIImage(named:"ic_cart")
    
    ///  **I commented this out because I don't have the code for `Cart`**
//    fileprivate var cart = Cart()
    
    let scrollView = UIScrollView()
    let sections = ["Section A", "Section B","Section C", "Section D","Section   E","Section F","Section G","Section H", "Section I","Section J","Section K","Section L"]
    let rowspersection = [2,3,1,2,2,3,3,1,4,2,1,2]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.gray
        
        //Add and setup scroll view
        self.tableView.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
        
        //Constrain scroll view
        self.scrollView.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor, constant: 20).isActive = true;
        self.scrollView.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 20).isActive = true;
        self.scrollView.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor, constant: -20).isActive = true;
        self.scrollView.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: -20).isActive = true;
        
        
        
        // customising rightBarButtonItems as notificationbutton
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(named: "ic_cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        
        
        
        //following register is needed because I have rightbarbuttonitem customised as   uibutton i.e.  notificationbutton
        notificationButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
    }
    @objc func registerTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showCart", sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        //Workaround to avoid the fadout the right bar button item
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        //Update cart if some items quantity is equal to 0 and reload the product table and right button bar item
        ///  **I commented this out because I don't have the code for `Cart`**
//        cart.updateCart()
        
        ///  **I commented this out because I don't have the code for `Cart`**
        //self.navigationItem.rightBarButtonItem?.title = "Checkout (\(cart.items.count))"
//        notificationButton.badge = String(cart.items.count)// making badge equal to no.ofitems in cart
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // this segue to transfer data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCart" {
            
            ///  **I commented this out because I don't have the code for `Cart` or `CartViewController`**
//            if let cartViewController = segue.destination as? CartViewController {
//                cartViewController.cart = self.cart
//            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productMap.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productMap[section]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productMap[indexPath.section]![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        cell.imagename.image = product.imagename
        cell.delegate = self as CartDelegate
        
        ///  **I commented this out because I don't have the code for `Cart`**
//        cell.setButton(state: self.cart.contains(product: product))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch(section) {
        case 0: return "Section A"
        case 1: return "Section B"
        case 2: return "Section C"
        case 3: return "Section D"
        case 4: return "Section E"
        case 5: return "Section F"
        case 6: return "Section G"
        case 7: return "Section H"
        case 8: return "Section I"
        case 9: return "Section J"
        case 10: return "Section K"
        case 11: return "Section L"
        default: return ""
        }
    }
}

extension ProductViewController: CartDelegate {
    
    // MARK: - CartDelegate
    func updateCart(cell: ProductTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let product = productMap[indexPath.section]![indexPath.row]
        
        if selectedIndexPaths.contains(indexPath) {
            if let index = selectedIndexPaths.firstIndex(of: indexPath) {
                selectedIndexPaths.remove(at: index)
                removeProductFromCart(indexPath: indexPath)
            }
        } else {
            selectedIndexPaths.append(indexPath)
            addProductToCart(indexPath: indexPath)
        }
//        addProductToCart(indexPath: indexPath)
        ///  **I commented this out because I don't have the code for `Cart`**
        //Update Cart with product
//        cart.updateCart(with: product)
        // self.navigationItem.rightBarButtonItem?.title = "Checkout (\(cart.items.count))"
//        notificationButton.badge = String(cart.items.count) // making badge equal to noofitems in cart
        
    }
}

// Most relevant code begins here -

extension ProductViewController {
    
    func addProductToCart(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell {
            if let imageView = cell.imagename {
                
                let initialImageViewFrame = imageView.convert(imageView.frame, to: self.view)
                let targetImageViewFrame = self.notificationButton.frame
                
                let imgViewTemp = UIImageView(frame: initialImageViewFrame)
                imgViewTemp.clipsToBounds = true
                imgViewTemp.contentMode = .scaleAspectFill
                imgViewTemp.image = imageView.image
                
                self.view.addSubview(imgViewTemp)
                
                UIView.animate(withDuration: 1.0, animations: {
                    imgViewTemp.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }) {  _ in
                    UIView.animate(withDuration: 0.5, animations: {
                        imgViewTemp.transform = CGAffineTransform(scaleX: 0.2, y: 0.2).rotated(by: CGFloat(Double.pi))
                        imgViewTemp.frame = targetImageViewFrame
                    }) { _ in
                        imgViewTemp.removeFromSuperview()

                        UIView.animate(withDuration: 1.0, animations: {
                            self.notificationButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                        }, completion: {_ in
                            self.notificationButton.transform = CGAffineTransform.identity
                        })
                    }
                }
            }
        }
    }
    
    func removeProductFromCart(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell {
            if let imageView = cell.imagename {
                
                let initialImageViewFrame = self.notificationButton.frame
                let targetImageViewFrame = imageView.convert(imageView.frame, to: self.view)
                
                let imgViewTemp = UIImageView(frame: initialImageViewFrame)
                imgViewTemp.clipsToBounds = true
                imgViewTemp.contentMode = .scaleAspectFill
                imgViewTemp.image = imageView.image
                
                self.view.addSubview(imgViewTemp)
                
                var initialTransform = CGAffineTransform.identity
                initialTransform = initialTransform.scaledBy(x: 0.2, y: 0.2)
                initialTransform = initialTransform.rotated(by: CGFloat(Double.pi))
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.notificationButton.animationZoom(scaleX: 1.4, y: 1.4)
                    imgViewTemp.transform = initialTransform
                }) {  _ in
                    UIView.animate(withDuration: 1, animations: {
                        self.notificationButton.animationZoom(scaleX: 1, y: 1)
                        imgViewTemp.transform = CGAffineTransform.identity
                        imgViewTemp.frame = targetImageViewFrame
                    }) { _ in
                        imgViewTemp.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    @IBAction func buttonHandlerAddToCart(_ sender: UIButton) {
        
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)!
        
        let cell = tableView.cellForRow(at: indexPath) as! ProductTableViewCell
        
        let imageViewPosition : CGPoint = cell.imageView!.convert(cell.imageView!.bounds.origin, to: self.view)
        
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imageView!.frame.size.width, height: cell.imageView!.frame.size.height))
        
        imgViewTemp.image = cell.imageView!.image
        
        animation(tempView: imgViewTemp)
    }
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
                       }, completion: { _ in
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            
                            
                            tempView.animationZoom(scaleX: 0.2, y: 0.2)
                            tempView.animationRoted(angle: CGFloat(Double.pi))
                            
                            tempView.frame.origin.x = self.notificationButton.frame.origin.x
                            tempView.frame.origin.y = self.notificationButton.frame.origin.y
                            
                        }, completion: { _ in
                            
                            tempView.removeFromSuperview()
                            
                            UIView.animate(withDuration: 1.0, animations: {
                                
                                
                                self.notificationButton.animationZoom(scaleX: 1.4, y: 1.4)
                            }, completion: {_ in
                                self.notificationButton.animationZoom(scaleX: 1.0, y: 1.0)
                            })
                            
                        })
                        
                       })
    }
}

extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
}

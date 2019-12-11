//
//  MainViewController.swift
//  SnakeGame
//
//  Created by Svetlana Timofeeva on 09/12/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private var startGameButton: UIButton!
    
    //private var currentPlayer: CurrentPlayer?
    
    var data = Array<Int>(0...10)
    
    private var collectionView = ScoreDataCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var gradient: CAGradientLayer = {
        let grad = CAGradientLayer()
        grad.colors = [UIColor.white.cgColor, UIColor.green.cgColor]
        grad.locations = [0.0, 1.0]
        grad.startPoint = CGPoint(x: 0.5, y: 1.0)
        grad.endPoint = CGPoint(x: 0.5, y: 0.0)
        return grad
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello, \(CurrentPlayerSingleton.shared.player.name)!"
        
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Your top 10 scores"
        title.font = .boldSystemFont(ofSize: 28)
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.text = "Your best game records will be shown here:"
        description.font = .systemFont(ofSize: 24)
        

        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ScoreCollectionViewCell.self, forCellWithReuseIdentifier: ScoreCollectionViewCell.identifier)
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.addShadow()
        //collectionView.layer.masksToBounds = false
        //collectionView.layer.insertSublayer(shadowLayer, at: 0)
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 320)
        ])

        let stack = UIStackView(arrangedSubviews: [title, description])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 8)
        ])
        
        startGameButton = UIButton(frame: .zero)
        startGameButton.addTarget(self, action: #selector(onStartGameButtonTapped), for: .touchUpInside)
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.setTitle("Start playing!", for: .normal)
        startGameButton.setTitleColor(.black, for: .normal)
        startGameButton.backgroundColor = .green
        startGameButton.layer.shadowColor = UIColor.gray.cgColor
        startGameButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        startGameButton.layer.shadowOpacity = 1.0
        startGameButton.layer.cornerRadius = 15
        view.addSubview(startGameButton)
        
        
        NSLayoutConstraint.activate([
            startGameButton.widthAnchor.constraint(equalToConstant: 150),
            startGameButton.heightAnchor.constraint(equalToConstant: 30),
            //button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 16/9),
            startGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startGameButton.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        ])
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        print("main")
        // Do any additional setup after loading the view.
    }
    
    @objc func logout() {
        let alert = UIAlertController(title: "Logging out", message: "Are you sure you'd like to log out?", preferredStyle: .alert)
        
        let logout = UIAlertAction(title: "Yes", style: .destructive) { (action:UIAlertAction) in
            AppDelegate.shared.rootViewController.switchToAuthScreen()
        }
        let stay = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in }
        stay.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(stay)

        alert.addAction(logout)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func onStartGameButtonTapped() {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
}


extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScoreCollectionViewCell.identifier, for: indexPath) as! ScoreCollectionViewCell
        let data = self.data[indexPath.item]
        cell.textLabel.text = String(data)
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 0.3
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.masksToBounds = true;
        cell.backgroundColor = .clear
        cell.layer.shadowColor = UIColor.clear.cgColor
        cell.layer.shadowOffset = CGSize(width:0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = true;
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

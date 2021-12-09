//
//  ViewController.swift
//  Tictactoe
//
//  Created by DCS on 07/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let player1:UILabel={
        let label=UILabel()
        label.text="Player 1 : X"
        label.textAlignment = .center
        label.textColor = UIColor(red: 50/255, green: 54/255, blue: 178/255, alpha: 1.0)
        label.backgroundColor = .white
        return label
        
    }()
    private let player2:UILabel={
        let label=UILabel()
        label.text="Player 2 : O"
        label.textAlignment = .center
         label.textColor =  UIColor(red: 50/255, green: 54/255, blue: 178/255, alpha: 1.0)
        label.backgroundColor = .white
        return label
        
    }()
    
    private let turn:UILabel={
        let label=UILabel()
        label.text = "it`s your turn player 1 "
        label.textAlignment = .center
        label.textColor =  UIColor(red: 50/255, green: 54/255, blue: 178/255, alpha: 1.0)
        label.backgroundColor = .white
        return label
        
    }()
    
    private  var state = [2,2,2,2,
                          2,2,2,2,
                          2,2,2,2,
                          2,2,2,2]
    private let winningCombination = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],[0,5,10,15],[3,6,9,12]]
    
    private var zeroFlag = false
    
    private let myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TicTacToe"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg4")!)
        view.addSubview(player1)
        view.addSubview(player2)
        view.addSubview(turn)
        view.addSubview(myCollectionView)
        setupcollectionview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        player1.frame = CGRect(x: 30, y: 50, width: 130, height: 40)
        player2.frame = CGRect(x: player1.right+5, y: 50, width: 130, height: 40)
        turn.frame = CGRect(x: 60, y: 130, width: 250, height: 40)
        myCollectionView.frame = CGRect(x: 0, y: 180, width: view.width, height: 400)
    }
}



extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    private func setupcollectionview()
    {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(T3Cell.self, forCellWithReuseIdentifier: "t3Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "t3Cell", for: indexPath) as! T3Cell
        cell.setupCell(with: state[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            
            state.remove(at: indexPath.row)
            if zeroFlag {
                state.insert(0, at: indexPath.row)
                turn.text = "it`s your turn player 1 "
            }
            else{
                state.insert(1, at: indexPath.row)
                turn.text = "it`s your turn player 0 "
            }
            zeroFlag = !zeroFlag
            
            myCollectionView.reloadSections(IndexSet(integer: 0))
            checkWinner()
        }
    }
    
    private  func checkWinner(){
        
        if !state.contains(2){
            let alert = UIAlertController(title: "TicTacToe", message: "Draw...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Start Again ", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert,animated:  true)
            }
            resetState()
            print("Draw")
        }else{
            for i in winningCombination{
                if state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] && state[i[2]]==state[i[3]] && state[i[0]] != 2{
                    var msg:String
                    if state[i[0]] == 1{
                        msg = player1.text!
                    }
                    else{
                        msg = player2.text!
                    }
                    let alert = UIAlertController(title: "TicTacToe", message:  "\(msg) win..", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    DispatchQueue.main.async {
                        self.present(alert,animated:  true)
                    }
                    print("\(state[i[0]]) won..")
                    resetState()
                    break
                }
            }
        }
       
    }
    private func resetState(){
        state = [2,2,2,2,
                 2,2,2,2,
                 2,2,2,2,
                 2,2,2,2]
    
        zeroFlag = false
        turn.text = "it`s your turn player 1 "
        myCollectionView.reloadSections(IndexSet(integer: 0))
    }
}



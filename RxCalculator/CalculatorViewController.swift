//
//  CalculatorViewController.swift
//  RxCalculator
//
//  Created by Joe_Liu on 17/2/13.
//  Copyright © 2017年 Joe_Liu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorViewController: UIViewController {

    @IBOutlet weak var lastSignLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var allClearButton: UIButton!
    @IBOutlet weak var changeSignButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    @IBOutlet weak var dotButton: UIButton!
    
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let commands: [Observable<Action>] = [
            allClearButton.rx.tap.map { _ in .clear },
            changeSignButton.rx.tap.map { _ in .changeSign },
            percentButton.rx.tap.map { _ in .percent },
            
            divideButton.rx.tap.map { _ in Action.operation(.division) },
            multiplyButton.rx.tap.map { _ in Action.operation(.multiplication) },
            minusButton.rx.tap.map { _ in Action.operation(.subtraction) },
            plusButton.rx.tap.map { _ in Action.operation(.addition) },
            
            dotButton.rx.tap.map { _ in Action.addDot },
            equalButton.rx.tap.map { _ in Action.equal },
            
            zeroButton.rx.tap.map { _ in Action.addNumber("0") },
            oneButton.rx.tap.map { _ in Action.addNumber("1") },
            twoButton.rx.tap.map { _ in Action.addNumber("2") },
            threeButton.rx.tap.map { _ in Action.addNumber("3") },
            fourButton.rx.tap.map { _ in Action.addNumber("4") },
            fiveButton.rx.tap.map { _ in Action.addNumber("5") },
            sixButton.rx.tap.map { _ in Action.addNumber("6") },
            sevenButton.rx.tap.map { _ in Action.addNumber("7") },
            eightButton.rx.tap.map { _ in Action.addNumber("8") },
            nineButton.rx.tap.map { _ in Action.addNumber("9") }
        ]
        
        Observable.from(commands)
            .merge()
            .scan(CalculatorState.CLEAR_STATE) { return $0.0.tranformState($0.1) }
            .debug("debugging")
            .subscribe(onNext: { [unowned self] in
                self.resultLabel.text = $0.inScreen
                switch $0.action {
                case .operation(let op):
                    switch op {
                    case .addition:
                        self.lastSignLabel.text = "+"
                    case .subtraction:
                        self.lastSignLabel.text = "-"
                    case .multiplication:
                        self.lastSignLabel.text = "x"
                    case .division:
                        self.lastSignLabel.text = "/"
                    }
                default:
                    self.lastSignLabel.text = ""
                }
            })
            .addDisposableTo(disposeBag)
        
    }

}

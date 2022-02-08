//
//  ViewController.swift
//  Timer Pomodoro
//
//  Created by SNZ on 05.02.2022.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - UI/UX

    //Добавление заднего фона(У меня не получилось ее добавить через функцию ниже. У меня тем самым продают другие элементы)
    //    private lazy var background = designUiUx(width: "Background")
    let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageIcon.background)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView

    }()

    //Добавление елементов
    private lazy var centreCircle = designUiUx(width: ImageIcon.circleElement)
    private lazy var buttonStartAndPause = designUiUx(width: ImageIcon.button1)
    private lazy var buttonAddSchedule = designUiUx(width: ImageIcon.button2)
    private lazy var buttonСoncentration = designUiUx(width: ImageIcon.button2)

    private lazy var startAndPause = addIcons(colorTitle: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), icon: ImageIcon.play, iconSize: Metric.size30)
    private lazy var schedule = addIcons(colorTitle: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), icon: ImageIcon.schedule, iconSize: Metric.size20)
    private lazy var concentration = addIcons(colorTitle: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), icon: ImageIcon.brain, iconSize: Metric.size20)

    //Создание лейбла помодоро
    private lazy var pomodoro: UILabel = {
        let pomodoro = UILabel()
        pomodoro.text = Strings.pomodoro
        pomodoro.font = UIFont(name: Strings.font, size: Metric.size35)
        pomodoro.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pomodoro.adjustsFontSizeToFitWidth = true

        return pomodoro
    }()


    //MARK: - Life style

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierrarhy()
        linkingConstraints()
        setupView()

    }

    //MARK: - Add to view

    private func setupHierrarhy() {
        view.addSubview(backgroundView)
        view.addSubview(centreCircle)
        view.addSubview(buttonStartAndPause)
        view.addSubview(buttonAddSchedule)
        view.addSubview(buttonСoncentration)
        view.addSubview(pomodoro)


        view.addSubview(startAndPause)
        view.addSubview(schedule)
        view.addSubview(concentration)

    }

    //MARK: - Constrains

    private func linkingConstraints() {

        setWidthHeight(subview: backgroundView, width: Metric.size1170, height: Metric.size2532)
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true


        setWidthHeight(subview: centreCircle, width: Metric.size370, height: Metric.size370)
        centreCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centreCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constraints.constrMinus120).isActive = true


        setWidthHeight(subview: buttonStartAndPause, width: Metric.size100, height: Metric.size100)
        buttonStartAndPause.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStartAndPause.topAnchor.constraint(equalTo: centreCircle.bottomAnchor, constant: Constraints.constr150).isActive = true


        setWidthHeight(subview: startAndPause, width: Metric.size100, height: Metric.size100)
        startAndPause.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startAndPause.topAnchor.constraint(equalTo: centreCircle.bottomAnchor, constant: Constraints.constr150).isActive = true


        setWidthHeight(subview: buttonAddSchedule, width: Metric.size100, height: Metric.size100)
        buttonAddSchedule.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constraints.constr10).isActive = true
        buttonAddSchedule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true


        setWidthHeight(subview: schedule, width: Metric.size100, height: Metric.size100)
        schedule.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constraints.constr8).isActive = true
        schedule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.constr5).isActive = true


        setWidthHeight(subview: buttonСoncentration, width: Metric.size100, height: Metric.size100)
        buttonСoncentration.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constraints.constrMinus10).isActive = true
        buttonСoncentration.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.constr5).isActive = true


        setWidthHeight(subview: concentration, width: Metric.size100, height: Metric.size100)
        concentration.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constraints.constrMinus12).isActive = true
        concentration.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.constr5).isActive = true


        setWidthHeight(subview: pomodoro, width: Metric.size150, height: Metric.size60)
        pomodoro.leftAnchor.constraint(equalTo: schedule.rightAnchor, constant: Constraints.constr10).isActive = true
        pomodoro.topAnchor.constraint(equalTo: view.topAnchor, constant: Constraints.constr70).isActive = true


    }

    private func setupView() {
    }

    //MARK: - Create Function

    //Функция добавления высоты и ширины
    private func setWidthHeight(subview: UIView, width: CGFloat, height: CGFloat) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        subview.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    //Функция для добавления элементов
    private func designUiUx(width named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }

    //Добавление иконок
    private func addIcons(colorTitle: UIColor, icon: String?, iconSize: CGFloat?) -> UIButton {
        let icons = UIButton(type: .system)
        icons.translatesAutoresizingMaskIntoConstraints = false
        icons.setTitleColor(colorTitle, for: .normal)
        icons.titleLabel?.adjustsFontSizeToFitWidth = true

        if icon != nil {
            let mediumConfig = UIImage.SymbolConfiguration(pointSize: iconSize ?? 0 , weight: .medium, scale: .medium)
            icons.setImage(UIImage(systemName: icon ?? "" , withConfiguration: mediumConfig), for: .normal)
            icons.tintColor = colorTitle
        }

        return icons
    }


}
//MARK: - Constans

extension ViewController {
    //Размеры
    enum Metric {
        static let size2532: CGFloat = 2532
        static let size1170: CGFloat = 1170
        static let size370: CGFloat = 370
        static let size100: CGFloat = 100
        static let size150: CGFloat = 150
        static let size60: CGFloat = 60
        static let size35: CGFloat = 35
        static let size30: CGFloat = 30
        static let size20: CGFloat = 20

    }

    //Констрейнты
    enum Constraints {
        static let constrMinus120: CGFloat = -120
        static let constrMinus12: CGFloat = -12
        static let constrMinus10: CGFloat = -10
        static let constr150: CGFloat = 150
        static let constr70: CGFloat = 70
        static let constr10: CGFloat = 10
        static let constr8: CGFloat = 8
        static let constr5: CGFloat = 5
    }

    //Наименования
    enum Strings {
        static let pomodoro: String = "Pomodoro"
        static let font: String = "Quicksand-Light"
    }

    //Изображения и иконки
    enum ImageIcon {
        static let background: String = "Background"
        static let circleElement: String = "circleElement"
        static let button1: String = "button 1"
        static let button2: String = "button 2"
        static let play: String = "play"
        static let pause: String = "pause"
        static let schedule: String = "text.viewfinder"
        static let brain: String = "brain"
    }
}

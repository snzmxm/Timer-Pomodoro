//
//  ViewController.swift
//  Timer Pomodoro
//
//  Created by SNZ on 05.02.2022.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    //MARK: - UI/UX

    //Добавление елементов
    private lazy var background = designUiUx(width: ImageIcon.background)
    private lazy var centreCircleImage = designUiUx(width: ImageIcon.circleElement)
    private lazy var startAndPauseImage = designUiUx(width: ImageIcon.button1)
    private lazy var buttonAddScheduleImage = designUiUx(width: ImageIcon.button2)
    private lazy var buttonСoncentrationImage = designUiUx(width: ImageIcon.button2)


    private lazy var scheduleIcon = addIcons(colorTitle: Colors.white, icon: ImageIcon.schedule, iconSize: Metric.size20)
    private lazy var concentrationIcon = addIcons(colorTitle: Colors.white, icon: ImageIcon.brain, iconSize: Metric.size20)

    //Создание лейбла помодоро
    private lazy var pomodoroLabel: UILabel = {
        let pomodoro = UILabel()
        pomodoro.text = Strings.pomodoro
        pomodoro.font = UIFont(name: Strings.font, size: Metric.size35)
        pomodoro.textColor = Colors.white
        pomodoro.adjustsFontSizeToFitWidth = true
        pomodoro.doGlowAnimation(withColor: pomodoro.textColor, withEffect: .big)

        return pomodoro
    }()

    //MARK: - Timer

    //Флаг для анимации
    private var isAnimation = false
    //Флаг для конфигурации кнопок
    private var isStarted = false
    //Флаг для конфигурации рабочего режима и режима отдыха
    private var isWorkTime = true

    //Создание таймера
    private var timer = Timer()
    private var allTime = Time.workTime {
        didSet {
            print(allTime)
        }
    }

    //Создание лейбла таймера
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()

        timerLabel.text = Strings.timerWork
        timerLabel.textColor = Colors.orange
        timerLabel.font = UIFont(name: Strings.font, size: Metric.size60)

        return timerLabel
    }()

    //Создание таймлайна таймера
    private lazy var timeLineCircle = timeLine()

    //Создание кнопки старт и пауза
    private lazy var startAndPauseButton: UIButton = {
        let button = UIButton(type: .system)

        let confButton = UIImage.SymbolConfiguration(pointSize: Metric.size30, weight: .medium)
        button.setImage(UIImage(systemName: ImageIcon.play, withConfiguration: confButton), for: .normal)
        button.tintColor = Colors.orange
        button.addTarget(self, action: #selector(startButtonTapped) , for: .touchUpInside)

        return button
    }()

    //Создание анимации для таймлайна
    let animationTimeLine = CABasicAnimation(keyPath: Strings.strokeEnd)

    //MARK: - Life style

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierrarhy()
        linkingConstraints()
    }

    //MARK: - Add to view

    private func setupHierrarhy() {
        view.addSubview(background)
        view.addSubview(centreCircleImage)
        view.addSubview(startAndPauseImage)
        view.addSubview(buttonAddScheduleImage)
        view.addSubview(buttonСoncentrationImage)
        view.addSubview(pomodoroLabel)

        view.addSubview(timerLabel)
        view.layer.addSublayer(timeLineCircle)

        view.addSubview(startAndPauseButton)
        view.addSubview(scheduleIcon)
        view.addSubview(concentrationIcon)
    }

    //MARK: - Constrains

    private func linkingConstraints() {

        setWidthHeight(subview: background, width: Metric.size1170, height: Metric.size2532)
        background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true


        setWidthHeight(subview: centreCircleImage, width: Metric.size370, height: Metric.size370)
        centreCircleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centreCircleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constraints.constrMinus120).isActive = true


        setWidthHeight(subview: startAndPauseImage, width: Metric.size100, height: Metric.size100)
        startAndPauseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startAndPauseImage.topAnchor.constraint(equalTo: centreCircleImage.bottomAnchor, constant: Constraints.constr150).isActive = true


        setWidthHeight(subview: startAndPauseButton, width: Metric.size100, height: Metric.size100)
        startAndPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startAndPauseButton.topAnchor.constraint(equalTo: centreCircleImage.bottomAnchor, constant: Constraints.constr150).isActive = true


        setWidthHeight(subview: buttonAddScheduleImage, width: Metric.size100, height: Metric.size100)
        buttonAddScheduleImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constraints.constr10).isActive = true
        buttonAddScheduleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.constr5).isActive = true


        setWidthHeight(subview: scheduleIcon, width: Metric.size100, height: Metric.size100)
        scheduleIcon.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constraints.constr8).isActive = true
        scheduleIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.constr5).isActive = true


        setWidthHeight(subview: buttonСoncentrationImage, width: Metric.size100, height: Metric.size100)
        buttonСoncentrationImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constraints.constrMinus10).isActive = true
        buttonСoncentrationImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.constr5).isActive = true


        setWidthHeight(subview: concentrationIcon, width: Metric.size100, height: Metric.size100)
        concentrationIcon.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constraints.constrMinus12).isActive = true
        concentrationIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.constr5).isActive = true


        setWidthHeight(subview: pomodoroLabel, width: Metric.size150, height: Metric.size60)
        pomodoroLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constraints.constr70).isActive = true
        pomodoroLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.constr108).isActive = true
        pomodoroLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constraints.constrMinus100).isActive = true


        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constraints.constrMinus125).isActive = true
    }

    //MARK: - Create methods

    //Метод добавления высоты и ширины
    private func setWidthHeight(subview: UIView, width: CGFloat, height: CGFloat) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        subview.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    //Метод для добавления элементов
    private func designUiUx(width named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }

    //Метод обавления иконок
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

    //Метод для перевода в минуты и секунды
    private func convertTime(){
        var minutes: Int
        var seconds: Int
        minutes = (allTime % 3600) / 60
        seconds = (allTime % 3600) % 60

        timerLabel.text = String(format: "%02i:%02i", minutes, seconds)
    }

    //Метод установки режима работы в зависимости от таймера
    @objc private func timerMode() {
        let confButton = UIImage.SymbolConfiguration(pointSize: Metric.size30, weight: .medium)
        allTime -= 1
        timerLabel.text = "\(allTime)"
        convertTime()

        //Режим отдыха
        if allTime == 0 && isWorkTime == true {
            allTime = Time.breakTime
            animationTimeLine.duration = CFTimeInterval(allTime)
            changeColor( Colors.cian)
            timerLabel.text = Strings.timerBreak
            startAndPauseButton.setImage(UIImage(systemName: ImageIcon.play, withConfiguration: confButton), for: .normal)
            isStarted = false
            isWorkTime = false
            timer.invalidate()

            //Режим работы
        } else if allTime == 0 && isWorkTime == false{
            allTime = Time.workTime
            animationTimeLine.duration = CFTimeInterval(allTime)
            changeColor(Colors.orange)
            timerLabel.text = Strings.timerWork
            startAndPauseButton.setImage(UIImage(systemName: ImageIcon.play, withConfiguration: confButton), for: .normal)
            isWorkTime = true
            isStarted = false
            timer.invalidate()
        }
    }

    //Метод режима кнопки работы старт и паузы
    @objc private func startButtonTapped() {
        let confButton = UIImage.SymbolConfiguration(pointSize: Metric.size30, weight: .medium)

        if isStarted == false {
            startAndPauseButton.setImage(UIImage(systemName: ImageIcon.pause, withConfiguration: confButton), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerMode), userInfo: nil, repeats: true)
            resumeAnimationStart()
            isStarted = true
        } else {
            startAndPauseButton.setImage(UIImage(systemName: ImageIcon.play, withConfiguration: confButton), for: .normal)
            timer.invalidate()
            pauseAnimation(for: timeLineCircle)
            isStarted = false
        }
    }

    //Метод создания таймлайна
    private func timeLine() -> CAShapeLayer {
        let timeLine = CAShapeLayer()
        let endLine = (-CGFloat.pi / 2)
        let startLine = 2 * CGFloat.pi + endLine

        timeLine.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.width / TimeLine.line2, y: view.frame.height / TimeLine.line2 - 120), radius: .minimum(view.frame.width / TimeLine.line4And2, view.frame.height / TimeLine.line2And5), startAngle: startLine, endAngle: endLine, clockwise: false).cgPath
        timeLine.lineWidth = TimeLine.line5
        timeLine.strokeColor = Colors.orange.cgColor
        timeLine.fillColor = UIColor.clear.cgColor
        timeLine.lineCap = CAShapeLayerLineCap.round

        return timeLine
    }

    //Метод изменения цвета при смене режима
    private func changeColor(_ color: UIColor) {
        timerLabel.textColor = color
        startAndPauseButton.tintColor = color
        timeLineCircle.strokeColor = color.cgColor
    }

    //MARK: - Сreating methods for animation

    //Метод для настройки старта анимации
    private func startAnimation() {
        resetAnimation()
        animationTimeLine.keyPath = Strings.strokeEnd
        animationTimeLine.fromValue = Animation.value0
        animationTimeLine.toValue = Animation.value1
        animationTimeLine.fillMode = CAMediaTimingFillMode.forwards
        animationTimeLine.duration = CFTimeInterval(allTime)
        animationTimeLine.isAdditive = true
        animationTimeLine.isRemovedOnCompletion = false
        animationTimeLine.delegate = self
        timeLineCircle.strokeEnd = Animation.value00
        timeLineCircle.add(animationTimeLine, forKey: Strings.strokeEnd)
        isAnimation = true
    }

    //Метод режима работы анимации
    private func resumeAnimationStart() {
        if isAnimation == false {
            startAnimation()
        } else {
            resumeAnimation(for: timeLineCircle)
        }
    }

    //Метод настройки для продолжения анимации
    private func resumeAnimation(for circle: CAShapeLayer) {
        let pauseTime = circle.timeOffset
        circle.speed = Animation.speed1
        circle.timeOffset = Animation.value00
        circle.beginTime = Animation.value00
        let timeSincePaused = circle.convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        circle.beginTime = timeSincePaused
    }

    //Метод настройки для паузы анимации
    private func pauseAnimation(for circle: CAShapeLayer) {
        let pauseTime = circle.convertTime(CACurrentMediaTime(), from: nil)
        circle.speed = Animation.speed0
        circle.timeOffset = pauseTime
    }

    //Метод настройки для перезагрузки анимации
    private func resetAnimation() {
        timeLineCircle.speed = Animation.speed1
        timeLineCircle.timeOffset = Animation.value00
        timeLineCircle.beginTime = Animation.value00
        timeLineCircle.strokeEnd = Animation.value00
        isAnimation = false
    }

    //Метод настройки для остановки анимации
    private func stopAnimation() {
        timeLineCircle.speed = Animation.speed1
        timeLineCircle.timeOffset = Animation.value00
        timeLineCircle.beginTime = Animation.value00
        timeLineCircle.strokeEnd = Animation.value00
        timeLineCircle.removeAllAnimations()
        isAnimation = false
    }

    //Метод передачи настроек для остановки анимации делегату
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stopAnimation()
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
        static let size48: CGFloat = 48
        static let size35: CGFloat = 35
        static let size30: CGFloat = 30
        static let size20: CGFloat = 20
    }

    //Констрейнты
    enum Constraints {
        static let constrMinus125: CGFloat = -125
        static let constrMinus120: CGFloat = -120
        static let constrMinus100: CGFloat = -100
        static let constrMinus12: CGFloat = -12
        static let constrMinus10: CGFloat = -10
        static let constr150: CGFloat = 150
        static let constr108: CGFloat = 108
        static let constr70: CGFloat = 70
        static let constr10: CGFloat = 10
        static let constr8: CGFloat = 8
        static let constr5: CGFloat = 5
    }

    //Наименования
    enum Strings {
        static let pomodoro: String = "Pomodoro"
        static let font: String = "Quicksand-Light"
        static let timerWork: String = "00:10"
        static let timerBreak: String = "00:05"
        static let strokeEnd: String = "strokeEnd"
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

    //Время
    enum Time {
        static let workTime = 10
        static let breakTime = 5
    }

    enum TimeLine {
        static let line2: CGFloat = 2
        static let line2And5: CGFloat = 2.5
        static let line4And2: CGFloat = 4.2
        static let line5: CGFloat = 5
    }

    enum Animation {
        static let speed0: Float = 0.0
        static let speed1: Float = 1.0
        static let value00: CGFloat = 0.0
        static let value1: CGFloat = 1
        static let value0: CGFloat = 0
    }

    enum Colors {
        static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let orange = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        static let cian = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
    }
}

//MARK: - Extension

extension UIView {
    enum GlowEffect: Float {
        case small = 0.4, normal = 2, big = 15
    }

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero

        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = effect.rawValue
        glowAnimation.beginTime = CACurrentMediaTime()+0.3
        glowAnimation.duration = CFTimeInterval(0.3)
        glowAnimation.fillMode = .removed
        glowAnimation.autoreverses = true
        glowAnimation.isRemovedOnCompletion = true
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
}

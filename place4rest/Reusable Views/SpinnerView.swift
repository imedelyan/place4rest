//
//  SpinnerView.swift
//  place4rest
//
//  Created by Igor Medelian on 5/8/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

final class SpinnerView: UIView {

    @IBInspectable var spinnerColor: UIColor = UIColor.black {
        didSet {
            animationLayer.strokeColor = spinnerColor.cgColor
        }
    }

    @IBInspectable var lineWidth: CGFloat = 4 {
        didSet {
            animationLayer.lineWidth = lineWidth
        }
    }

    lazy var animationLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = nil
        return circleLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(animationLayer)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.addSublayer(animationLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        animationLayer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: animationLayer.lineWidth / 2,
                                                                  dy: animationLayer.lineWidth / 2)).cgPath
    }

    func stopAnimating() {
        animationLayer.opacity = 0
        animationLayer.removeAllAnimations()
        layer.removeAllAnimations()
    }

    func animate() {
        guard layer.animation(forKey: "transform.rotation") == nil
            || animationLayer.animation(forKey: "strokeEnd") == nil
            else { return }
        animationLayer.opacity = 1
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()

        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }

        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * .pi)
            strokeEnds.append(pose.length)
        }

        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])

        let strokeEndAnimation = keyPathAnimation(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animationLayer.add(strokeEndAnimation, forKey: strokeEndAnimation.keyPath)

        let rotationAnimation = keyPathAnimation(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)
        layer.add(rotationAnimation, forKey: rotationAnimation.keyPath)
    }

    private func keyPathAnimation(keyPath: String,
                                  duration: CFTimeInterval,
                                  times: [CFTimeInterval],
                                  values: [CGFloat]) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = .linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        return animation
    }
}

fileprivate extension SpinnerView {

    var poses: [Pose] {
        return [
            Pose(0.0, 0.000, 0.7),
            Pose(0.6, 0.500, 0.5),
            Pose(0.6, 1.000, 0.3),
            Pose(0.6, 1.500, 0.1),
            Pose(0.2, 1.875, 0.1),
            Pose(0.2, 2.250, 0.3),
            Pose(0.2, 2.625, 0.5),
            Pose(0.2, 3.000, 0.7)
        ]
    }

    struct Pose {
        let secondsSincePriorPose: CFTimeInterval
        let start: CGFloat
        let length: CGFloat
        init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
            self.secondsSincePriorPose = secondsSincePriorPose
            self.start = start
            self.length = length
        }
    }

}

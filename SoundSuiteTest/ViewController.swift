//
//  ViewController.swift
//  SoundSuiteTest
//
//  Created by Ari Jain on 6/25/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var player2 = AVAudioPlayer()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("play", for: [])
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    let secondAudioButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("add background noise", for: [])
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    let combineAudiosButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("combine audios", for: [])
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    let slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        setupViews()
    }
    
    func setupViews() {
        setupPlayButtonConstraints()
        setupSecondButtonConstraints()
        setupSliderConstraints()
        setupCombineAudiosConstraints()
    }
    
    func setupSlider() {
        slider.addTarget(self, action: #selector(controlVolume), for: .valueChanged)
        slider.maximumValue = 1
        slider.value = 0.5
    }
    
    @objc func controlVolume() {
        player.volume = slider.value
        player2.volume = 1 - slider.value
    }
    
    @objc func playAudio() {
        if player.isPlaying {
            player.stop()
            player2.stop()
        } else {
            if secondAudioButton.isSelected {
                playPlayerTwoAudio()
            }
            playPlayerOneAudio()
        }
    }
    
    func playPlayerOneAudio() {
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "DJ Got Us", ofType: "mp3")!))
            player.volume = slider.value
            player.play()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func playPlayerTwoAudio() {
        do {
            player2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Purple Lamborghini", ofType: "mp3")!))
            player2.volume = slider.value
            player2.play()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    @objc func addBackgroundAudio() {
        if secondAudioButton.isSelected {
            secondAudioButton.isSelected = false
            secondAudioButton.backgroundColor = .white
        } else {
            secondAudioButton.isSelected = true
            secondAudioButton.backgroundColor = .gray
        }
    }
    
    @objc func combineAudios() {
        // Combine both audios with their correct volume levels
    }
    
    
}

extension ViewController {
    func setupPlayButtonConstraints() {
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: 100),
            playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        playButton.addTarget(self, action: #selector(playAudio), for: .touchDown)
    }
    
    func setupSliderConstraints() {
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.widthAnchor.constraint(equalToConstant: 300),
            slider.heightAnchor.constraint(equalToConstant: 300),
            slider.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            slider.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        setupSlider()
    }
    
    func setupSecondButtonConstraints() {
        view.addSubview(secondAudioButton)
        secondAudioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondAudioButton.heightAnchor.constraint(equalToConstant: 100),
            secondAudioButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 150),
            secondAudioButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            secondAudioButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        secondAudioButton.addTarget(self, action: #selector(addBackgroundAudio), for: .touchDown)
    }
    
    func setupCombineAudiosConstraints() {
        view.addSubview(combineAudiosButton)
        combineAudiosButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            combineAudiosButton.heightAnchor.constraint(equalToConstant: 100),
            combineAudiosButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 300),
            combineAudiosButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            combineAudiosButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        combineAudiosButton.addTarget(self, action: #selector(combineAudios), for: .touchDown)
    }
}

//
//  CreateLyricsViewController.swift
//  Silly Song
//
//  Created by Cay Cornelius on 22.07.17.
//  Copyright © 2017 Cornelius.Media. All rights reserved.
//

import UIKit

// MARK: - UITextFieldDelegate
extension CreateLyricsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func stripChars(_ convertString :String)->String {
    return convertString.folding(options: .diacriticInsensitive, locale: .current)
}

func shortNameForName(name: String) -> String {
    var shortenedName = stripChars(name.lowercased())
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    let index = shortenedName.rangeOfCharacter(from: vowelSet)?.lowerBound
    if index != nil {
        shortenedName = shortenedName.substring(from: index!)
    }
    return shortenedName
}

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameForName(name: fullName)
    let finalLyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return finalLyrics
}


class CreateLyricsViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    
    @IBAction func displayLyrics(_ sender: Any) {
        if (nameField.text != "") {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        }
    }

}

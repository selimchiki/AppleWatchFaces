//
//  HourTextNodeNode.swift
//  SwissClock
//
//  Created by Mike Hill on 11/11/15.
//  Copyright © 2015 Mike Hill. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit

enum NumberTextTypes: String {
    case NumberTextTypeModernInteger,
    NumberTextTypeBlackRose,
    NumberTextTypeCorneriaScript,
    NumberTextTypeGermanica,
    NumberTextTypeKingThings,
    NumberTextTypeRothernburgDecorative,
    NumberTextTypeHelvica,
    NumberTextTypeHelvicaNeueBold,
    NumberTextTypeNumeralTrajan,
    NumberTextTypeDINPro,
    NumberTextTypeUltraCondensedSerif,
    NumberTextTypeTypeWriter,
    NumberTextTypeIronLounge
    
    static let randomizableValues = [NumberTextTypeModernInteger,
        NumberTextTypeBlackRose,
        NumberTextTypeCorneriaScript,
        NumberTextTypeGermanica,
        NumberTextTypeKingThings,
        NumberTextTypeRothernburgDecorative,
        NumberTextTypeHelvica,
        NumberTextTypeHelvicaNeueBold,
        NumberTextTypeNumeralTrajan,
        NumberTextTypeDINPro,
        NumberTextTypeTypeWriter,
        NumberTextTypeIronLounge
        ]
    static let userSelectableValues = [NumberTextTypeModernInteger,
        NumberTextTypeBlackRose,
        NumberTextTypeCorneriaScript,
        NumberTextTypeGermanica,
        NumberTextTypeKingThings,
        NumberTextTypeRothernburgDecorative,
        NumberTextTypeHelvica,
        NumberTextTypeHelvicaNeueBold,
        NumberTextTypeNumeralTrajan,
        NumberTextTypeDINPro,
        NumberTextTypeUltraCondensedSerif,
        NumberTextTypeTypeWriter,
        NumberTextTypeIronLounge]
    
    static func random() -> NumberTextTypes {
        let randomIndex = Int(arc4random_uniform(UInt32(randomizableValues.count)))
        return randomizableValues[randomIndex]
    }
}

class NumberTextNode: SKNode {
    
    static func typeDescriptions() -> [String] {
        var typeDescriptionsArray = [String]()
        for nodeType in NumberTextTypes.userSelectableValues {
            typeDescriptionsArray.append(descriptionForType(nodeType))
        }
        
        return typeDescriptionsArray
    }
    
    static func typeKeys() -> [String] {
        var typeKeysArray = [String]()
        for nodeType in NumberTextTypes.userSelectableValues {
            typeKeysArray.append(nodeType.rawValue)
        }
        
        return typeKeysArray
    }
    
    static func descriptionForType(_ nodeType: NumberTextTypes) -> String {
        var typeDescription = ""
        
        if (nodeType == NumberTextTypes.NumberTextTypeModernInteger)  { typeDescription = "Modern Integer" }
        if (nodeType == NumberTextTypes.NumberTextTypeBlackRose)  { typeDescription = "Black Rose" }
        if (nodeType == NumberTextTypes.NumberTextTypeCorneriaScript)  { typeDescription = "Corneria Script" }
        if (nodeType == NumberTextTypes.NumberTextTypeGermanica)  { typeDescription = "Germanica" }
        if (nodeType == NumberTextTypes.NumberTextTypeKingThings)  { typeDescription = "King Things" }
        if (nodeType == NumberTextTypes.NumberTextTypeRothernburgDecorative)  { typeDescription = "Rothernburg Decorative" }
        if (nodeType == NumberTextTypes.NumberTextTypeHelvicaNeueBold)  { typeDescription = "Helvica Neue Bold" }
        if (nodeType == NumberTextTypes.NumberTextTypeHelvica)  { typeDescription = "Helvica" }
        if (nodeType == NumberTextTypes.NumberTextTypeNumeralTrajan)  { typeDescription = "Numeral Trajan" }
        if (nodeType == NumberTextTypes.NumberTextTypeDINPro)  { typeDescription = "DIN Pro" }
        if (nodeType == NumberTextTypes.NumberTextTypeUltraCondensedSerif)  { typeDescription = "Ultra Condensed" }
        
        if (nodeType == NumberTextTypes.NumberTextTypeTypeWriter) { typeDescription = "Automania" }
        if (nodeType == NumberTextTypes.NumberTextTypeIronLounge) { typeDescription = "Iron Lounge" }
        
        return typeDescription
    }
    
    func fontNameForNumberTextType( _ textType : NumberTextTypes ) -> String {
        var fontName = "HelveticaNeue-Medium"
        
        if (textType == .NumberTextTypeHelvicaNeueBold) { fontName = "HelveticaNeue-Bold" }
        if (textType == .NumberTextTypeModernInteger) { fontName = "RationalInteger" }
        if (textType == .NumberTextTypeBlackRose) { fontName = "BlackRose" }
        if (textType == .NumberTextTypeCorneriaScript) { fontName = "ConeriaScriptDemo" }
        if (textType == .NumberTextTypeGermanica) { fontName = "PlainGermanica" }
        if (textType == .NumberTextTypeRothernburgDecorative) { fontName = "RothenburgDecorative" }
        if (textType == .NumberTextTypeKingThings) { fontName = "KingthingsFoundation" }
        
        if (textType == .NumberTextTypeNumeralTrajan) { fontName = "TrajanPro-Regular" }
        if (textType == .NumberTextTypeDINPro) { fontName = "DINPro-Light" }
        if (textType == .NumberTextTypeUltraCondensedSerif) { fontName = "UltraCondensedSerif" }
        
        if (textType == .NumberTextTypeTypeWriter) { fontName = "AmericanTypewriter" }
        if (textType == .NumberTextTypeIronLounge) { fontName = "IronLounge2" }
        
        //AppleSDGothicNeo-SemiBold     // best VERY CLEAN
        //KohinoorTelugu-Medium         // basic but not bad
        //GillSans-SemiBold             // not amazing curvy
        //AvenirNextCondensed-Bold      // feels like fallout
        //Kailasa-Bold
        //SnellRoundhand-Black
        //ZapfDingbatsITC               //clean
        
        return fontName
    }
    
    //used when generating node for clock faces ( the numbers )
    init(numberTextType: NumberTextTypes, textSize: Float, currentNum: Int, totalNum: Int, shouldDisplayRomanNumerals: Bool, pivotMode: Int, fillColor: SKColor) {
        
        super.init()

        self.name = "hourText"
        var currentNum = currentNum
        if (currentNum == 0 && totalNum == 12) { currentNum = totalNum }
        
        //TODO this should dependant on overall scale setting?
        let textScale = Float(0.0175)
        
        //support for roman numerals
        var hourString = currentNum.description
        if (shouldDisplayRomanNumerals) {
            hourString = self.toRoman(currentNum)
        }
        
        let hourText = SKLabelNode.init(text: hourString)
        
        let fontName = fontNameForNumberTextType(numberTextType)
        hourText.fontName = fontName
        hourText.fontSize = CGFloat( Float(textSize) / textScale )
        hourText.fontColor = fillColor
        hourText.color = fillColor
        
        hourText.horizontalAlignmentMode = .center
        hourText.verticalAlignmentMode = .center

        self.addChild(hourText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toRoman(_ number: Int) -> String {
        
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = number
        
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            
            let div = startingValue / arabicValue
            
            if (div > 0)
            {
                for _ in 0..<div
                {
                    //println("Should add \(romanChar) to string")
                    romanValue += romanChar
                }
                
                startingValue -= arabicValue * div
            }
        }
        
        return romanValue
    }

}

/* 

Font Family Name = [Rational Integer]
Font Names = [["RationalInteger"]]

------------------------------
Font Family Name = [Coneria Script Demo]
Font Names = [["ConeriaScriptDemo"]]
------------------------------
Font Family Name = [Copperplate]
Font Names = [["Copperplate-Light", "Copperplate", "Copperplate-Bold"]]
------------------------------
Font Family Name = [Heiti SC]
Font Names = [[]]
------------------------------
Font Family Name = [Iowan Old Style]
Font Names = [["IowanOldStyle-Italic", "IowanOldStyle-Roman", "IowanOldStyle-BoldItalic", "IowanOldStyle-Bold"]]
------------------------------
Font Family Name = [Kohinoor Telugu]
Font Names = [["KohinoorTelugu-Regular", "KohinoorTelugu-Medium", "KohinoorTelugu-Light"]]
------------------------------
Font Family Name = [Thonburi]
Font Names = [["Thonburi", "Thonburi-Bold", "Thonburi-Light"]]
------------------------------
Font Family Name = [Heiti TC]
Font Names = [[]]
------------------------------
Font Family Name = [Courier New]
Font Names = [["CourierNewPS-BoldMT", "CourierNewPS-ItalicMT", "CourierNewPSMT", "CourierNewPS-BoldItalicMT"]]
------------------------------
Font Family Name = [Gill Sans]
Font Names = [["GillSans-Italic", "GillSans-Bold", "GillSans-BoldItalic", "GillSans-LightItalic", "GillSans", "GillSans-Light", "GillSans-SemiBold", "GillSans-SemiBoldItalic", "GillSans-UltraBold"]]
------------------------------
Font Family Name = [Apple SD Gothic Neo]
Font Names = [["AppleSDGothicNeo-Bold", "AppleSDGothicNeo-Thin", "AppleSDGothicNeo-UltraLight", "AppleSDGothicNeo-Regular", "AppleSDGothicNeo-Light", "AppleSDGothicNeo-Medium", "AppleSDGothicNeo-SemiBold"]]
------------------------------
Font Family Name = [Marker Felt]
Font Names = [["MarkerFelt-Thin", "MarkerFelt-Wide"]]
------------------------------
Font Family Name = [Avenir Next Condensed]
Font Names = [["AvenirNextCondensed-BoldItalic", "AvenirNextCondensed-Heavy", "AvenirNextCondensed-Medium", "AvenirNextCondensed-Regular", "AvenirNextCondensed-HeavyItalic", "AvenirNextCondensed-MediumItalic", "AvenirNextCondensed-Italic", "AvenirNextCondensed-UltraLightItalic", "AvenirNextCondensed-UltraLight", "AvenirNextCondensed-DemiBold", "AvenirNextCondensed-Bold", "AvenirNextCondensed-DemiBoldItalic"]]
------------------------------
Font Family Name = [Tamil Sangam MN]
Font Names = [["TamilSangamMN", "TamilSangamMN-Bold"]]
------------------------------
Font Family Name = [Helvetica Neue]
Font Names = [["HelveticaNeue-Italic", "HelveticaNeue-Bold", "HelveticaNeue-UltraLight", "HelveticaNeue-CondensedBlack", "HelveticaNeue-BoldItalic", "HelveticaNeue-CondensedBold", "HelveticaNeue-Medium", "HelveticaNeue-Light", "HelveticaNeue-Thin", "HelveticaNeue-ThinItalic", "HelveticaNeue-LightItalic", "HelveticaNeue-UltraLightItalic", "HelveticaNeue-MediumItalic", "HelveticaNeue"]]
------------------------------
Font Family Name = [Gurmukhi MN]
Font Names = [["GurmukhiMN-Bold", "GurmukhiMN"]]
------------------------------
Font Family Name = [Times New Roman]
Font Names = [["TimesNewRomanPSMT", "TimesNewRomanPS-BoldItalicMT", "TimesNewRomanPS-ItalicMT", "TimesNewRomanPS-BoldMT"]]
------------------------------
Font Family Name = [Georgia]
Font Names = [["Georgia-BoldItalic", "Georgia", "Georgia-Italic", "Georgia-Bold"]]
------------------------------
Font Family Name = [Apple Color Emoji]
Font Names = [["AppleColorEmoji"]]
------------------------------
Font Family Name = [Arial Rounded MT Bold]
Font Names = [["ArialRoundedMTBold"]]
------------------------------
Font Family Name = [Kailasa]
Font Names = [["Kailasa-Bold", "Kailasa"]]
------------------------------
Font Family Name = [Kohinoor Devanagari]
Font Names = [["KohinoorDevanagari-Light", "KohinoorDevanagari-Regular", "KohinoorDevanagari-Semibold"]]
------------------------------
Font Family Name = [Kohinoor Bangla]
Font Names = [["KohinoorBangla-Semibold", "KohinoorBangla-Regular", "KohinoorBangla-Light"]]
------------------------------
Font Family Name = [Chalkboard SE]
Font Names = [["ChalkboardSE-Bold", "ChalkboardSE-Light", "ChalkboardSE-Regular"]]
------------------------------
Font Family Name = [Sinhala Sangam MN]
Font Names = [["SinhalaSangamMN-Bold", "SinhalaSangamMN"]]
------------------------------
Font Family Name = [PingFang TC]
Font Names = [["PingFangTC-Medium", "PingFangTC-Regular", "PingFangTC-Light", "PingFangTC-Ultralight", "PingFangTC-Semibold", "PingFangTC-Thin"]]
------------------------------
Font Family Name = [Gujarati Sangam MN]
Font Names = [["GujaratiSangamMN-Bold", "GujaratiSangamMN"]]
------------------------------
Font Family Name = [Damascus]
Font Names = [["DamascusLight", "DamascusBold", "DamascusSemiBold", "DamascusMedium", "Damascus"]]
------------------------------
Font Family Name = [Noteworthy]
Font Names = [["Noteworthy-Light", "Noteworthy-Bold"]]
------------------------------
Font Family Name = [Geeza Pro]
Font Names = [["GeezaPro", "GeezaPro-Bold"]]
------------------------------
Font Family Name = [PlainGermanica]
Font Names = [["PlainGermanica"]]
------------------------------
Font Family Name = [Avenir]
Font Names = [["Avenir-Medium", "Avenir-HeavyOblique", "Avenir-Book", "Avenir-Light", "Avenir-Roman", "Avenir-BookOblique", "Avenir-Black", "Avenir-MediumOblique", "Avenir-BlackOblique", "Avenir-Heavy", "Avenir-LightOblique", "Avenir-Oblique"]]
------------------------------
Font Family Name = [Academy Engraved LET]
Font Names = [["AcademyEngravedLetPlain"]]
------------------------------
Font Family Name = [Mishafi]
Font Names = [["DiwanMishafi"]]
------------------------------
Font Family Name = [Futura]
Font Names = [["Futura-CondensedMedium", "Futura-CondensedExtraBold", "Futura-Medium", "Futura-MediumItalic"]]
------------------------------
Font Family Name = [Farah]
Font Names = [["Farah"]]
------------------------------
Font Family Name = [Kannada Sangam MN]
Font Names = [["KannadaSangamMN", "KannadaSangamMN-Bold"]]
------------------------------
Font Family Name = [Arial Hebrew]
Font Names = [["ArialHebrew-Bold", "ArialHebrew-Light", "ArialHebrew"]]
------------------------------
Font Family Name = [Arial]
Font Names = [["ArialMT", "Arial-BoldItalicMT", "Arial-BoldMT", "Arial-ItalicMT"]]
------------------------------
Font Family Name = [Party LET]
Font Names = [["PartyLetPlain"]]
------------------------------
Font Family Name = [Chalkduster]
Font Names = [["Chalkduster"]]
------------------------------
Font Family Name = [Hoefler Text]
Font Names = [["HoeflerText-Italic", "HoeflerText-Regular", "HoeflerText-Black", "HoeflerText-BlackItalic"]]
------------------------------
Font Family Name = [Optima]
Font Names = [["Optima-Regular", "Optima-ExtraBlack", "Optima-BoldItalic", "Optima-Italic", "Optima-Bold"]]
------------------------------
Font Family Name = [Palatino]
Font Names = [["Palatino-Bold", "Palatino-Roman", "Palatino-BoldItalic", "Palatino-Italic"]]
------------------------------
Font Family Name = [Lao Sangam MN]
Font Names = [["LaoSangamMN"]]
------------------------------
Font Family Name = [Malayalam Sangam MN]
Font Names = [["MalayalamSangamMN-Bold", "MalayalamSangamMN"]]
------------------------------
Font Family Name = [Al Nile]
Font Names = [["AlNile-Bold", "AlNile"]]
------------------------------
Font Family Name = [Bradley Hand]
Font Names = [["BradleyHandITCTT-Bold"]]
------------------------------
Font Family Name = [PingFang HK]
Font Names = [["PingFangHK-Ultralight", "PingFangHK-Semibold", "PingFangHK-Thin", "PingFangHK-Light", "PingFangHK-Regular", "PingFangHK-Medium"]]
------------------------------
Font Family Name = [Trebuchet MS]
Font Names = [["Trebuchet-BoldItalic", "TrebuchetMS", "TrebuchetMS-Bold", "TrebuchetMS-Italic"]]
------------------------------
Font Family Name = [Helvetica]
Font Names = [["Helvetica-Bold", "Helvetica", "Helvetica-LightOblique", "Helvetica-Oblique", "Helvetica-BoldOblique", "Helvetica-Light"]]
------------------------------
Font Family Name = [Courier]
Font Names = [["Courier-BoldOblique", "Courier", "Courier-Bold", "Courier-Oblique"]]
------------------------------
Font Family Name = [Cochin]
Font Names = [["Cochin-Bold", "Cochin", "Cochin-Italic", "Cochin-BoldItalic"]]
------------------------------
Font Family Name = [Hiragino Mincho ProN]
Font Names = [["HiraMinProN-W6", "HiraMinProN-W3"]]
------------------------------
Font Family Name = [Devanagari Sangam MN]
Font Names = [["DevanagariSangamMN", "DevanagariSangamMN-Bold"]]
------------------------------
Font Family Name = [Oriya Sangam MN]
Font Names = [["OriyaSangamMN", "OriyaSangamMN-Bold"]]
------------------------------
Font Family Name = [Snell Roundhand]
Font Names = [["SnellRoundhand-Bold", "SnellRoundhand", "SnellRoundhand-Black"]]
------------------------------
Font Family Name = [Zapf Dingbats]
Font Names = [["ZapfDingbatsITC"]]
------------------------------
Font Family Name = [Bodoni 72]
Font Names = [["BodoniSvtyTwoITCTT-Bold", "BodoniSvtyTwoITCTT-Book", "BodoniSvtyTwoITCTT-BookIta"]]
------------------------------
Font Family Name = [Verdana]
Font Names = [["Verdana-Italic", "Verdana-BoldItalic", "Verdana", "Verdana-Bold"]]
------------------------------
Font Family Name = [American Typewriter]
Font Names = [["AmericanTypewriter-CondensedLight", "AmericanTypewriter", "AmericanTypewriter-CondensedBold", "AmericanTypewriter-Light", "AmericanTypewriter-Bold", "AmericanTypewriter-Condensed"]]
------------------------------
Font Family Name = [Rothenburg Decorative]
Font Names = [["RothenburgDecorative"]]
------------------------------
Font Family Name = [Avenir Next]
Font Names = [["AvenirNext-UltraLight", "AvenirNext-UltraLightItalic", "AvenirNext-Bold", "AvenirNext-BoldItalic", "AvenirNext-DemiBold", "AvenirNext-DemiBoldItalic", "AvenirNext-Medium", "AvenirNext-HeavyItalic", "AvenirNext-Heavy", "AvenirNext-Italic", "AvenirNext-Regular", "AvenirNext-MediumItalic"]]
------------------------------
Font Family Name = [Baskerville]
Font Names = [["Baskerville-Italic", "Baskerville-SemiBold", "Baskerville-BoldItalic", "Baskerville-SemiBoldItalic", "Baskerville-Bold", "Baskerville"]]
------------------------------
Font Family Name = [Khmer Sangam MN]
Font Names = [["KhmerSangamMN"]]
------------------------------
Font Family Name = [Didot]
Font Names = [["Didot-Italic", "Didot-Bold", "Didot"]]
------------------------------
Font Family Name = [Savoye LET]
Font Names = [["SavoyeLetPlain"]]
------------------------------
Font Family Name = [Bodoni Ornaments]
Font Names = [["BodoniOrnamentsITCTT"]]
------------------------------
Font Family Name = [Kingthings Foundation]
Font Names = [["KingthingsFoundation"]]
------------------------------
Font Family Name = [Symbol]
Font Names = [["Symbol"]]
------------------------------
Font Family Name = [Menlo]
Font Names = [["Menlo-Italic", "Menlo-Bold", "Menlo-Regular", "Menlo-BoldItalic"]]
------------------------------
Font Family Name = [Bodoni 72 Smallcaps]
Font Names = [["BodoniSvtyTwoSCITCTT-Book"]]
------------------------------
Font Family Name = [Papyrus]
Font Names = [["Papyrus", "Papyrus-Condensed"]]
------------------------------
Font Family Name = [Hiragino Sans]
Font Names = [["HiraginoSans-W3", "HiraginoSans-W6"]]
------------------------------
Font Family Name = [PingFang SC]
Font Names = [["PingFangSC-Ultralight", "PingFangSC-Regular", "PingFangSC-Semibold", "PingFangSC-Thin", "PingFangSC-Light", "PingFangSC-Medium"]]
------------------------------
Font Family Name = [Euphemia UCAS]
Font Names = [["EuphemiaUCAS-Italic", "EuphemiaUCAS", "EuphemiaUCAS-Bold"]]
------------------------------
Font Family Name = [Telugu Sangam MN]
Font Names = [[]]
------------------------------
Font Family Name = [Bangla Sangam MN]
Font Names = [[]]
------------------------------
Font Family Name = [Zapfino]
Font Names = [["Zapfino"]]
------------------------------
Font Family Name = [Bodoni 72 Oldstyle]
Font Names = [["BodoniSvtyTwoOSITCTT-Book", "BodoniSvtyTwoOSITCTT-Bold", "BodoniSvtyTwoOSITCTT-BookIt"]]
------------------------------
Font Family Name = [Black Rose]
Font Names = [["BlackRose"]]

*/

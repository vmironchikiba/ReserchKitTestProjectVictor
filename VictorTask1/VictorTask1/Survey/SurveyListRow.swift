//
//  SurveyListRow.swift
//  VictorTask1
//
//  Created by Mironchik on 26.10.24.
//

import ResearchKit.Private
import AudioToolbox
import ResearchKit
import HealthKit


class SystemSound {
    var soundID: SystemSoundID = 0
    
    init?(soundURL: URL) {
        if AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID) != noErr {
           return nil
        }
    }
    
    deinit {
        AudioServicesDisposeSystemSoundID(soundID)
    }
}

enum SurveyListRow: Int, CustomStringConvertible {
    case form = 0
    case groupedForm
    case survey
    case platterUIQuestion
    case booleanQuestion
    case customBooleanQuestion
    case dateQuestion
    case dateTimeQuestion
    case date3DayLimitQuestionTask
    case imageChoiceQuestion
    case locationQuestion
    case numericQuestion
    case scaleQuestion
    case textQuestion
    case textChoiceQuestion
    case textChoiceQuestionWithImageTask
    case timeIntervalQuestion
    case timeOfDayQuestion
    case valuePickerChoiceQuestion
    case validatedTextQuestion
    case imageCapture
    case videoCapture
    case frontFacingCamera
    case wait
    case PDFViewer
    case requestPermissions
    case eligibilityTask
    case accountCreation
    case login
    case passcode
    case biometricPasscode
    case audio
    case amslerGrid
    case sixMinuteWalk
    case fitness
    case holePegTest
    case psat
    case reactionTime
    case normalizedReactionTime
    case shortWalk
    case spatialSpanMemory
    case speechRecognition
    case speechInNoise
    case stroop
    case swiftStroop
    case timedWalkWithTurnAround
    case toneAudiometry
    case dBHLToneAudiometry
    case splMeter
    case towerOfHanoi
    case tremorTest
    case twoFingerTappingInterval
    case walkBackAndForth
    case heightQuestion
    case weightQuestion
    case healthQuantity
    case kneeRangeOfMotion
    case shoulderRangeOfMotion
    case trailMaking
    case visualAcuityLandoltC
    case contrastSensitivityPeakLandoltC
    case videoInstruction
    case review
    case webView
    case tintColor
    
    class TaskListRowSection {
        var title: String
        var rows: [SurveyListRow]
        
        init(title: String, rows: [SurveyListRow]) {
            self.title = title
            self.rows = rows
        }
    }
    
    
    static var sections: [ TaskListRowSection ] {
        
        var defaultSections = [
            TaskListRowSection(title: "Surveys", rows:
                [
                    .form,
                    .groupedForm,
                    .survey
                ]),
            TaskListRowSection(title: "Survey Questions", rows:
                [
                    .platterUIQuestion,
                    .booleanQuestion,
                    .customBooleanQuestion,
                    .dateQuestion,
                    .dateTimeQuestion,
                    .date3DayLimitQuestionTask,
                    .heightQuestion,
                    .weightQuestion,
                    .healthQuantity,
                    .imageChoiceQuestion,
                    .locationQuestion,
                    .numericQuestion,
                    .scaleQuestion,
                    .textQuestion,
                    .textChoiceQuestion,
                    .textChoiceQuestionWithImageTask,
                    .timeIntervalQuestion,
                    .timeOfDayQuestion,
                    .valuePickerChoiceQuestion,
                    .validatedTextQuestion,
                    .imageCapture,
                    .videoCapture,
                    .frontFacingCamera,
                    .wait,
                    .PDFViewer,
                    .requestPermissions
                ]),
            TaskListRowSection(title: "Onboarding", rows:
                [
                    .eligibilityTask,
                    .accountCreation,
                    .login,
                    .passcode,
                    .biometricPasscode,
                    .review
                ]),
            TaskListRowSection(title: "Active Tasks", rows:
                [
                    .audio,
                    .amslerGrid,
                    .sixMinuteWalk,
                    .fitness,
                    .holePegTest,
                    .psat,
                    .reactionTime,
                    .normalizedReactionTime,
                    .shortWalk,
                    .spatialSpanMemory,
                    .speechRecognition,
                    .speechInNoise,
                    .stroop,
                    .swiftStroop,
                    .timedWalkWithTurnAround,
                    .toneAudiometry,
                    .dBHLToneAudiometry,
                    .splMeter,
                    .towerOfHanoi,
                    .tremorTest,
                    .twoFingerTappingInterval,
                    .walkBackAndForth,
                    .kneeRangeOfMotion,
                    .shoulderRangeOfMotion,
                    .trailMaking,
                    .visualAcuityLandoltC,
                    .contrastSensitivityPeakLandoltC
                ]),
            TaskListRowSection(title: "Miscellaneous", rows:
                [
                    .tintColor,
                    .videoInstruction,
                    .webView
                ])]
        
            return defaultSections
        }
    
    
    
    var description: String {
        switch self {
        case .form:
            return NSLocalizedString("Form Survey Example", comment: "")
            
        case .groupedForm:
            return NSLocalizedString("Grouped Form Survey Example", comment: "")

        case .survey:
            return NSLocalizedString("Simple Survey Example", comment: "")
            
        case .platterUIQuestion:
            return NSLocalizedString("Platter UI Question", comment: "")
            
        case .booleanQuestion:
            return NSLocalizedString("Boolean Question", comment: "")
            
        case .customBooleanQuestion:
            return NSLocalizedString("Custom Boolean Question", comment: "")
            
        case .dateQuestion:
            return NSLocalizedString("Date Question", comment: "")
            
        case .dateTimeQuestion:
            return NSLocalizedString("Date and Time Question", comment: "")
            
        case .date3DayLimitQuestionTask:
            return NSLocalizedString("Date and Time 3 day Limit Question", comment: "")

        case .heightQuestion:
            return NSLocalizedString("Height Question", comment: "")
    
        case .weightQuestion:
            return NSLocalizedString("Weight Question", comment: "")
        case .healthQuantity:
            return NSLocalizedString("Health Quantity Question", comment: "")
        case .imageChoiceQuestion:
            return NSLocalizedString("Image Choice Question", comment: "")
            
        case .locationQuestion:
            return NSLocalizedString("Location Question", comment: "")
            
        case .numericQuestion:
            return NSLocalizedString("Numeric Question", comment: "")
            
        case .scaleQuestion:
            return NSLocalizedString("Scale Question", comment: "")
            
        case .textQuestion:
            return NSLocalizedString("Text Question", comment: "")
            
        case .textChoiceQuestion:
            return NSLocalizedString("Text Choice Question", comment: "")
        
        case .textChoiceQuestionWithImageTask:
            return NSLocalizedString("Text Choice Image Question", comment: "")
            
        case .timeIntervalQuestion:
            return NSLocalizedString("Time Interval Question", comment: "")
            
        case .timeOfDayQuestion:
            return NSLocalizedString("Time of Day Question", comment: "")
            
        case .valuePickerChoiceQuestion:
            return NSLocalizedString("Value Picker Choice Question", comment: "")
            
        case .validatedTextQuestion:
            return NSLocalizedString("Validated Text Question", comment: "")
            
        case .imageCapture:
            return NSLocalizedString("Image Capture Step", comment: "")
            
        case .videoCapture:
            return NSLocalizedString("Video Capture Step", comment: "")
            
        case .frontFacingCamera:
            return NSLocalizedString("Front Facing Camera Step", comment: "")
            
        case .wait:
            return NSLocalizedString("Wait Step", comment: "")
        
        case .PDFViewer:
            return NSLocalizedString("PDF Viewer Step", comment: "")
            
        case .requestPermissions:
            return NSLocalizedString("Request Permissions Step", comment: "")

        case .review:
            return NSLocalizedString("Review Step", comment: "")
            
        case .eligibilityTask:
            return NSLocalizedString("Eligibility Task Example", comment: "")

        case .accountCreation:
            return NSLocalizedString("Account Creation", comment: "")
        
        case .login:
            return NSLocalizedString("Login", comment: "")

        case .passcode:
            return NSLocalizedString("Passcode Creation", comment: "")
        
        case .biometricPasscode:
            return NSLocalizedString("Biometric Passcode Creation and Authorization", comment: "")
            
        case .audio:
            return NSLocalizedString("Audio", comment: "")
        
        case .amslerGrid:
            return NSLocalizedString("Amsler Grid", comment: "")

        case .sixMinuteWalk:
            return NSLocalizedString("Six Minute Walk", comment: "")

        case .fitness:
            return NSLocalizedString("Fitness Check", comment: "")
        
        case .holePegTest:
            return NSLocalizedString("Hole Peg Test", comment: "")
            
        case .psat:
            return NSLocalizedString("PSAT", comment: "")
            
        case .reactionTime:
            return NSLocalizedString("Reaction Time", comment: "")
        
        case .normalizedReactionTime:
            return NSLocalizedString("Normalized Reaction Time", comment: "")

        case .shortWalk:
            return NSLocalizedString("Short Walk", comment: "")
            
        case .spatialSpanMemory:
            return NSLocalizedString("Spatial Span Memory", comment: "")
            
        case .speechRecognition:
            return NSLocalizedString("Speech Recognition", comment: "")
            
        case .speechInNoise:
            return NSLocalizedString("Speech in Noise", comment: "")
            
        case .stroop:
            return NSLocalizedString("Stroop", comment: "")
            
        case .swiftStroop:
            return NSLocalizedString("Swift Stroop", comment: "")
            
        case .timedWalkWithTurnAround:
            return NSLocalizedString("Timed Walk with Turn Around", comment: "")
            
        case .toneAudiometry:
            return NSLocalizedString("Tone Audiometry", comment: "")
            
        case .dBHLToneAudiometry:
            return NSLocalizedString("dBHL Tone Audiometry", comment: "")
            
        case .splMeter:
            return NSLocalizedString("Environment SPL Meter", comment: "")
            
        case .towerOfHanoi:
            return NSLocalizedString("Tower of Hanoi", comment: "")

        case .twoFingerTappingInterval:
            return NSLocalizedString("Two Finger Tapping Interval", comment: "")
            
        case .walkBackAndForth:
            return NSLocalizedString("Walk Back and Forth", comment: "")
            
        case .tremorTest:
            return NSLocalizedString("Tremor Test", comment: "")
            
        case .videoInstruction:
            return NSLocalizedString("Video Instruction Task", comment: "")
            
        case .kneeRangeOfMotion:
            return NSLocalizedString("Knee Range of Motion", comment: "")
            
        case .shoulderRangeOfMotion:
            return NSLocalizedString("Shoulder Range of Motion", comment: "")
            
        case .trailMaking:
            return NSLocalizedString("Trail Making Test", comment: "")
            
        case .visualAcuityLandoltC:
            return NSLocalizedString("Visual Acuity Landolt C", comment: "")
            
        case .contrastSensitivityPeakLandoltC:
            return NSLocalizedString("Contrast Sensitivity Peak", comment: "")

        case .webView:
            return NSLocalizedString("Web View", comment: "")

        case .tintColor:
            return NSLocalizedString("Tint Color", comment: "")

        }
    }
    
    

    enum Identifier {
        
        case formTask
        case groupedFormTask
        case formStep
        case groupedFormStep
        case formItem01
        case formItem02
        case formItem03
        case formItem04
        case textChoiceFormItem
        
        
        case surveyTask
        case introStep
        case questionStep
        case birthdayQuestion
        case summaryStep
        
        
        case platterQuestionTask
        case platterQuestionStep
        
        
        case booleanQuestionTask
        case booleanQuestionStep

        
        case dateQuestionTask
        case dateQuestionStep
        case date3DayLimitQuestionTask

        
        case dateTimeQuestionTask
        case dateTimeQuestionStep

        
        case heightQuestionTask
        case heightQuestionStep1
        case heightQuestionStep2
        case heightQuestionStep3
        case heightQuestionStep4

        
        case weightQuestionTask
        case weightQuestionStep1
        case weightQuestionStep2
        case weightQuestionStep3
        case weightQuestionStep4
        case weightQuestionStep5
        case weightQuestionStep6
        case weightQuestionStep7
        
        
        case healthQuantityTask
        case healthQuantityQuestion1
        case healthQuantityQuestion2

        
        case imageChoiceQuestionTask
        case imageChoiceQuestionStep1
        case imageChoiceQuestionStep2
        
        
        case locationQuestionTask
        case locationQuestionStep
        
        
        case numericQuestionTask
        case numericQuestionStep
        case numericNoUnitQuestionStep
        case numericDisplayUnitQuestionStep

        
        case reviewTask
        case embeddedReviewStep
        case standAloneReviewStep
        
        
        case scaleQuestionTask
        case discreteScaleQuestionStep
        case continuousScaleQuestionStep
        case discreteVerticalScaleQuestionStep
        case continuousVerticalScaleQuestionStep
        case textScaleQuestionStep
        case textVerticalScaleQuestionStep

        
        case textQuestionTask
        case textQuestionStep

        
        case textChoiceQuestionTask
        case textChoiceQuestionStep
        case textChoiceQuestionWithImageStep
        case textChoiceQuestionWithImageTask

        
        case timeOfDayQuestionTask
        case timeOfDayQuestionStep

        
        case timeIntervalQuestionTask
        case timeIntervalQuestionStep

        
        case valuePickerChoiceQuestionTask
        case valuePickerChoiceQuestionStep
        
        
        case validatedTextQuestionTask
        case validatedTextQuestionStepEmail
        case validatedTextQuestionStepDomain
        
        
        case imageCaptureTask
        case imageCaptureStep
        
        
        case videoCaptureTask
        case videoCaptureStep
        
        case frontFacingCameraStep
        
        
        case waitTask
        case waitStepDeterminate
        case waitStepIndeterminate
        
        case pdfViewerStep
        case pdfViewerTask
        
        case requestPermissionsStep
        
        
        case eligibilityTask
        case eligibilityIntroStep
        case eligibilityFormStep
        case eligibilityFormItem01
        case eligibilityFormItem02
        case eligibilityFormItem03
        case eligibilityIneligibleStep
        case eligibilityEligibleStep
        
        
        case accountCreationTask
        case registrationStep
        case waitStep
        case verificationStep
        
        
        case loginTask
        case loginStep
        case loginWaitStep

        
        case passcodeTask
        case passcodeStep
        case biometricPasscodeTask
        case biometricPasscodeStep

        
        case audioTask
        case amslerGridTask
        case sixMinuteWalkTask
        case fitnessTask
        case holePegTestTask
        case psatTask
        case reactionTime
        case normalizedReactionTime
        case shortWalkTask
        case spatialSpanMemoryTask
        case speechRecognitionTask
        case speechInNoiseTask
        case stroopTask
        case swiftStroopTask
        case timedWalkWithTurnAroundTask
        case toneAudiometryTask
        case dBHLToneAudiometryTask
        case splMeterTask
        case splMeterStep
        case towerOfHanoi
        case tremorTestTask
        case twoFingerTappingIntervalTask
        case walkBackAndForthTask
        case kneeRangeOfMotion
        case shoulderRangeOfMotion
        case trailMaking
        case visualAcuityLandoltC
        case contrastSensitivityPeakLandoltC
        
        
        case videoInstructionTask
        case videoInstructionStep
        
        
        case webViewTask
        case webViewStep
        
        
        case tintColorTask
        case tintColorStep
        case tintColorQuestion

    }
    
    
    
    
    var representedTask: ORKTask {
        switch self {
        case .form:
            return formTask
            
        case .groupedForm:
            return groupedFormTask
            
        case .survey:
            return surveyTask
            
        case .platterUIQuestion:
            return platterQuestionTask
            
        case .booleanQuestion:
            return booleanQuestionTask
            
        case .customBooleanQuestion:
            return customBooleanQuestionTask
            
        case .dateQuestion:
            return dateQuestionTask
            
        case .dateTimeQuestion:
            return dateTimeQuestionTask
            
        case .date3DayLimitQuestionTask:
            return dateLimited3DayQuestionTask

        case .heightQuestion:
            return heightQuestionTask
            
        case .weightQuestion:
            return weightQuestionTask
            
        case .healthQuantity:
            return healthQuantityTypeTask
            
        case .imageChoiceQuestion:
            return imageChoiceQuestionTask
            
        case .locationQuestion:
            return locationQuestionTask
            
        case .numericQuestion:
            return numericQuestionTask
            
        case .review:
            return reviewTask
            
        case .scaleQuestion:
            return scaleQuestionTask
            
        case .textQuestion:
            return textQuestionTask
            
        case .textChoiceQuestion:
            return textChoiceQuestionTask
            
        case .timeIntervalQuestion:
            return timeIntervalQuestionTask

        case .timeOfDayQuestion:
                return timeOfDayQuestionTask
        
        case .valuePickerChoiceQuestion:
                return valuePickerChoiceQuestionTask
            
        case .validatedTextQuestion:
            return validatedTextQuestionTask
            
        case .imageCapture:
            return imageCaptureTask
            
        case .videoCapture:
            return videoCaptureTask
            
        case .frontFacingCamera:
            return frontFacingCameraStep
            
        case .wait:
            return waitTask
            
        case .PDFViewer:
            return PDFViewerTask
            
        case .requestPermissions:
            return requestPermissionsTask
        
        case .eligibilityTask:
            return eligibilityTask
            
        case .accountCreation:
            return accountCreationTask
            
        case .login:
            return loginTask

        case .passcode:
            return passcodeTask
        
        case .biometricPasscode:
            return biometricPasscodeTask
            
        case .audio:
            return audioTask
            
        case .amslerGrid:
            return amslerGridTask

        case .sixMinuteWalk:
            return sixMinuteWalkTask

        case .fitness:
            return fitnessTask
            
        case .holePegTest:
            return holePegTestTask
            
        case .psat:
            return PSATTask
            
        case .reactionTime:
            return reactionTimeTask
        
        case .normalizedReactionTime:
            return normalizedReactionTimeTask
            
        case .shortWalk:
            return shortWalkTask
            
        case .spatialSpanMemory:
            return spatialSpanMemoryTask

        case .speechRecognition:
            return speechRecognitionTask
            
        case .speechInNoise:
            return speechInNoiseTask
            
        case .stroop:
            return stroopTask
            
        case .swiftStroop:
            return swiftStroopTask
            
        case .timedWalkWithTurnAround:
            return timedWalkWithTurnAroundTask
            
        case .toneAudiometry:
            return toneAudiometryTask
            
        case .dBHLToneAudiometry:
            return dBHLToneAudiometryTask
            
        case .splMeter:
            return splMeterTask
            
        case .towerOfHanoi:
            return towerOfHanoiTask
            
        case .twoFingerTappingInterval:
            return twoFingerTappingIntervalTask
            
        case .walkBackAndForth:
            return walkBackAndForthTask
            
        case .tremorTest:
            return tremorTestTask

        case .kneeRangeOfMotion:
            return kneeRangeOfMotion
        
        case .shoulderRangeOfMotion:
            return shoulderRangeOfMotion
            
        case .trailMaking:
            return trailMaking
    
        case .visualAcuityLandoltC:
            return visualAcuityLandoltC
            
        case .contrastSensitivityPeakLandoltC:
            return contrastSensitivityPeakLandoltC
            
        case .tintColor:
            return tintColor

        case .videoInstruction:
            return videoInstruction
            
        case .webView:
            return webView
            
        case .textChoiceQuestionWithImageTask:
            return textChoiceQuestionWithImageTask
        }
    }

    
    
    private var formTask: ORKTask {
        let step = ORKFormStep(identifier: String(describing: Identifier.formStep), title: NSLocalizedString("Form Step", comment: ""), text: exampleDetailText)

        
        let formItem01Text = NSLocalizedString("Field01", comment: "")
        let formItem01 = ORKFormItem(identifier: String(describing: Identifier.formItem01), text: formItem01Text, answerFormat: ORKAnswerFormat.integerAnswerFormat(withUnit: nil))
        formItem01.placeholder = NSLocalizedString("Your placeholder here", comment: "")

        
        let formItem02Text = NSLocalizedString("Field02", comment: "")
        let formItem02 = ORKFormItem(identifier: String(describing: Identifier.formItem02), text: formItem02Text, answerFormat: ORKTimeIntervalAnswerFormat())
        formItem02.placeholder = NSLocalizedString("Your placeholder here", comment: "")

        let formItem03Text = NSLocalizedString(exampleQuestionText, comment: "")
        let scaleAnswerFormat = ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: 0, step: 1)//ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: 0, step: 1)
        scaleAnswerFormat.shouldHideRanges = true
        let formItem03 = ORKFormItem(identifier: String(describing: Identifier.formItem03), text: formItem03Text, answerFormat: scaleAnswerFormat)

        var textChoices: [ORKTextChoice] = [
            ORKTextChoice(text: "choice 1", detailText: "detail 1", value: 1 as NSNumber, exclusive: false),
            ORKTextChoice(text: "choice 2", detailText: "detail 2", value: 2 as NSNumber, exclusive: false),
            ORKTextChoice(text: "choice 3", detailText: "detail 3", value: 3 as NSNumber, exclusive: false),
            ORKTextChoice(text: "choice 4", detailText: "detail 4", value: 4 as NSNumber, exclusive: false),
            ORKTextChoice(text: "choice 5", detailText: "detail 5", value: 5 as NSNumber, exclusive: false),
            ORKTextChoice(text: "choice 6", detailText: "detail 6", value: 6 as NSNumber, exclusive: false)
        ]

        let textScaleAnswerFormat = ORKTextScaleAnswerFormat(textChoices: textChoices, defaultIndex: 10)
        textScaleAnswerFormat.shouldHideLabels = true
        textScaleAnswerFormat.shouldShowDontKnowButton = true
        
        textChoices.append(ORKTextChoiceOther.choice(withText: "choice 7", detailText: "", value: 7 as NSNumber, exclusive: true, textViewPlaceholderText: "Tap to write your answer"))
        let textChoiceAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: textChoices)

        let formItem04 = ORKFormItem(identifier: String(describing: Identifier.formItem04), text: exampleQuestionText, answerFormat: textScaleAnswerFormat)
        
        let textChoiceFormItem = ORKFormItem(identifier: String(describing: Identifier.textChoiceFormItem), text: exampleQuestionText, answerFormat: textChoiceAnswerFormat)
        
        let appleChoices: [ORKTextChoice] = [ORKTextChoice(text: "Granny Smith", value: 1 as NSNumber), ORKTextChoice(text: "Honeycrisp", value: 2 as NSNumber), ORKTextChoice(text: "Fuji", value: 3 as NSNumber), ORKTextChoice(text: "McIntosh", value: 10 as NSNumber), ORKTextChoice(text: "Kanzi", value: 5 as NSNumber)]
        
        let appleAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: appleChoices)
        
        let appleFormItem = ORKFormItem(identifier: "appleFormItemIdentifier", text: "Which is your favorite apple?", answerFormat: appleAnswerFormat)
        
        let freeTextSection = ORKFormItem(identifier: "freeTextSectionIdentifier", text: "Enter your text below", answerFormat: nil)
        
        let freeTextAnswerFormat = ORKAnswerFormat.textAnswerFormat(withMaximumLength: 200)
        freeTextAnswerFormat.multipleLines = true
        
        let freeTextItem = ORKFormItem(identifier: "freeTextItemIdentifier", text: nil, answerFormat: freeTextAnswerFormat)
        
        step.formItems = [
            appleFormItem,
            formItem03,
            formItem04,
            formItem01,
            formItem02,
            textChoiceFormItem,
            freeTextSection,
            freeTextItem
        ]
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = NSLocalizedString("All Done!", comment: "")
        completionStep.detailText = NSLocalizedString("You have completed the questionnaire.", comment: "")
        return ORKOrderedTask(identifier: String(describing: Identifier.formTask), steps: [step, completionStep])
    }
    
    private var groupedFormTask: ORKTask {
        let step = ORKFormStep(identifier: String(describing: Identifier.groupedFormStep), title: NSLocalizedString("Form Step", comment: ""), text: exampleDetailText)
        
        //Start of first section
        let learnMoreInstructionStep01 = ORKLearnMoreInstructionStep(identifier: "LearnMoreInstructionStep01")
        learnMoreInstructionStep01.title = NSLocalizedString("Learn more title", comment: "")
        learnMoreInstructionStep01.text = NSLocalizedString("Learn more text", comment: "")
        let learnMoreItem01 = ORKLearnMoreItem(text: nil, learnMoreInstructionStep: learnMoreInstructionStep01)
        let section01 = ORKFormItem(sectionTitle: NSLocalizedString("Section title", comment: ""), detailText: NSLocalizedString("Section detail text", comment: ""), learnMoreItem: learnMoreItem01, showsProgress: true)
        
        
        let formItem01Text = NSLocalizedString("Field01", comment: "")
        let formItem01 = ORKFormItem(identifier: String(describing: Identifier.formItem01), text: formItem01Text, answerFormat: ORKAnswerFormat.integerAnswerFormat(withUnit: nil))
        formItem01.placeholder = NSLocalizedString("Your placeholder here", comment: "")
        
        
        let formItem02Text = NSLocalizedString("Field02", comment: "")
        let formItem02 = ORKFormItem(identifier: String(describing: Identifier.formItem02), text: formItem02Text, answerFormat: ORKTimeIntervalAnswerFormat())
        formItem02.placeholder = NSLocalizedString("Your placeholder here", comment: "")
        
        let sesAnswerFormat = ORKSESAnswerFormat(topRungText: "Best Off", bottomRungText: "Worst Off")
        let sesFormItem = ORKFormItem(identifier: "sesIdentifier", text: "Select where you are on the socioeconomic ladder.", answerFormat: sesAnswerFormat)
        
        
        //Start of section for scale question
        let formItem03Text = NSLocalizedString(exampleQuestionText, comment: "")
        let scaleAnswerFormat = ORKContinuousScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: 0.0, maximumFractionDigits: 1)//ORKScaleAnswerFormat(maximumValue: 10, minimumValue: 0, defaultValue: 0, step: 1)
        let formItem03 = ORKFormItem(identifier: String(describing: Identifier.formItem03), text: formItem03Text, detailText: nil, learnMoreItem: nil, showsProgress: true, answerFormat: scaleAnswerFormat, tagText: nil, optional: true)
       
        step.formItems = [
            section01,
            formItem01,
            formItem02,
            formItem03,
            sesFormItem
        ]
        
        
        let question1StepAnswerFormat = ORKBooleanAnswerFormat()
        
        let question1 = NSLocalizedString("Would you like to subscribe to our newsletter?", comment: "")
        
        let learnMoreInstructionStep = ORKLearnMoreInstructionStep(identifier: "LearnMoreInstructionStep01")
        learnMoreInstructionStep.title = NSLocalizedString("Learn more title", comment: "")
        learnMoreInstructionStep.text = NSLocalizedString("Learn more text", comment: "")
        let learnMoreItem = ORKLearnMoreItem(text: nil, learnMoreInstructionStep: learnMoreInstructionStep)
        
        let question1Step = ORKQuestionStep(identifier: String(describing: Identifier.questionStep), title: "Questionnaire", question: question1, answer: question1StepAnswerFormat, learnMoreItem: learnMoreItem)
        question1Step.text = exampleDetailText
        
        //Add a question step with different layout format.
        let question2StepAnswerFormat = ORKAnswerFormat.dateAnswerFormat(withDefaultDate: nil, minimumDate: nil, maximumDate: Date(), calendar: nil)
        
        let question2 = NSLocalizedString("When is your birthday?", comment: "")
        let question2Step = ORKQuestionStep(identifier: String(describing: Identifier.birthdayQuestion), title: "Questionnaire", question: question2, answer: question2StepAnswerFormat)
        question2Step.text = exampleDetailText
        
        
        let appleChoices: [ORKTextChoice] = [ORKTextChoice(text: "Granny Smith", value: 1 as NSNumber), ORKTextChoice(text: "Honeycrisp", value: 2 as NSNumber), ORKTextChoice(text: "Fuji", value: 3 as NSNumber), ORKTextChoice(text: "McIntosh", value: 10 as NSNumber), ORKTextChoice(text: "Kanzi", value: 5 as NSNumber)]
        
        let appleAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: appleChoices)
        
        let appleFormItem = ORKFormItem(identifier: "appleFormItemIdentifier", text: "Which is your favorite apple?", answerFormat: appleAnswerFormat)
        
        let appleFormStep = ORKFormStep(identifier: "appleFormStepIdentifier", title: "Fruit!", text: "Select the fruit you like.")
        
        appleFormStep.formItems = [appleFormItem]
        
        return ORKOrderedTask(identifier: String(describing: Identifier.groupedFormTask), steps: [step, question1Step, question2Step, appleFormStep])
    }

    private var surveyTask: ORKTask {
        
        let instructionStep = ORKInstructionStep(identifier: String(describing: Identifier.introStep))
        instructionStep.title = NSLocalizedString("Simple Survey", comment: "")
        instructionStep.text = exampleDescription
        instructionStep.detailText = NSLocalizedString("Please use this space to provide instructions for participants.  Please make sure to provide enough information so that users can progress through the survey and complete with ease.", comment: "")
        
        
        let question1StepAnswerFormat = ORKBooleanAnswerFormat()
        
        let question1 = NSLocalizedString("Would you like to subscribe to our newsletter?", comment: "")
        
        let learnMoreInstructionStep = ORKLearnMoreInstructionStep(identifier: "LearnMoreInstructionStep01")
        learnMoreInstructionStep.title = NSLocalizedString("Learn more title", comment: "")
        learnMoreInstructionStep.text = NSLocalizedString("Learn more text", comment: "")
        let learnMoreItem = ORKLearnMoreItem(text: nil, learnMoreInstructionStep: learnMoreInstructionStep)
        
        let question1Step = ORKQuestionStep(identifier: String(describing: Identifier.questionStep), title: "Questionnaire", question: question1, answer: question1StepAnswerFormat, learnMoreItem: learnMoreItem)
        question1Step.text = exampleDetailText
        
        //Add a question step with different layout format.
        let question2StepAnswerFormat = ORKAnswerFormat.dateAnswerFormat(withDefaultDate: nil, minimumDate: nil, maximumDate: Date(), calendar: nil)
        
        let question2 = NSLocalizedString("When is your birthday?", comment: "")
        let question2Step = ORKQuestionStep(identifier: String(describing: Identifier.birthdayQuestion), title: "Questionnaire", question: question2, answer: question2StepAnswerFormat)
        question2Step.text = exampleDetailText
        
        
        let summaryStep = ORKInstructionStep(identifier: String(describing: Identifier.summaryStep))
        summaryStep.title = NSLocalizedString("Thanks", comment: "")
        summaryStep.text = NSLocalizedString("Thank you for participating in this sample survey.", comment: "")
        
        return ORKOrderedTask(identifier: String(describing: Identifier.surveyTask), steps: [
            instructionStep,
            question1Step,
            question2Step,
            summaryStep
            ])
    }
    
    private var platterQuestionTask: ORKTask {
        
        let textChoiceOneText = NSLocalizedString("Choice 1", comment: "")
        let textChoiceTwoText = NSLocalizedString("Choice 2", comment: "")
        let textChoiceThreeText = NSLocalizedString("Choice 3", comment: "")
        
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .headline)
        let font = UIFont(descriptor: descriptor, size: descriptor.pointSize)
        
        let primaryAttributes = [NSAttributedString.Key.font:font]
        
        let textChoiceOnePrimaryAttributedString = NSAttributedString(string: textChoiceOneText, attributes:primaryAttributes)
        let textChoiceTwoPrimaryAttributedString = NSAttributedString(string: textChoiceTwoText, attributes: primaryAttributes)
        let textChoiceThreePrimaryAttributedString = NSAttributedString(string: textChoiceThreeText, attributes: primaryAttributes)
        
        let textChoices = [
            ORKTextChoice(text: nil,
                          primaryTextAttributedString: textChoiceOnePrimaryAttributedString,
                          detailText: "Detail",
                          detailTextAttributedString: nil,
                          value: "choice 1" as NSString,
                          exclusive: true),
            ORKTextChoice(text: nil,
                          primaryTextAttributedString: textChoiceTwoPrimaryAttributedString,
                          detailText: "Detail",
                          detailTextAttributedString: nil,
                          value: "choice 2" as NSString,
                          exclusive: true),
            ORKTextChoice(text: nil,
                          primaryTextAttributedString: textChoiceThreePrimaryAttributedString,
                          detailText: "Detail",
                          detailTextAttributedString: nil,
                          value: "choice 3" as NSString,
                          exclusive: true)
        ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice,
                                                              textChoices: textChoices)
        
        let questionStep = ORKQuestionStep.platterQuestion(withIdentifier: String(describing: Identifier.platterQuestionStep),
                                                           question: "How many fingers am I holding up?",
                                                           text: "Answer to the best of your knowledge.",
                                                           answerFormat: answerFormat)
        
        return ORKOrderedTask(identifier: String(describing: Identifier.platterQuestionTask), steps: [questionStep])
    }

    
    private var booleanQuestionTask: ORKTask {
        let answerFormat = ORKBooleanAnswerFormat()
        
        
        let questionStep = ORKQuestionStep(identifier: String(describing: Identifier.booleanQuestionStep), title: NSLocalizedString("Boolean", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.booleanQuestionTask), steps: [questionStep])
    }
    
    
    private var customBooleanQuestionTask: ORKTask {
        let answerFormat = ORKBooleanAnswerFormat(yesString: "Agree", noString: "Disagree")
        
        
        let questionStep = ORKQuestionStep(identifier: String(describing: Identifier.booleanQuestionStep), title: NSLocalizedString("Custom Boolean", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.booleanQuestionTask), steps: [questionStep])
    }

    
    private var dateQuestionTask: ORKTask {

        let answerFormat = ORKAnswerFormat.dateAnswerFormat()
        
        let step = ORKQuestionStep(identifier: String(describing: Identifier.dateQuestionStep), title: NSLocalizedString("Date", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        step.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.dateQuestionTask), steps: [step])
    }
    
    
    private var dateLimited3DayQuestionTask: ORKTask {

        let answerFormat = ORKAnswerFormat.dateAnswerFormatWithDays(beforeCurrentDate: 3, daysAfterCurrentDate: 3, calendar: nil)
        
        let step = ORKQuestionStep(identifier: String(describing: Identifier.dateQuestionStep), title: NSLocalizedString("Date", comment: ""), question: exampleDate3DayLimitQuestionTask, answer: answerFormat)
        
        step.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.dateQuestionTask), steps: [step])
    }
    
    
    
    private var dateTimeQuestionTask: ORKTask {

        let answerFormat = ORKAnswerFormat.dateTime()
        
        let step = ORKQuestionStep(identifier: String(describing: Identifier.dateTimeQuestionStep), title: NSLocalizedString("Date and Time", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        step.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.dateTimeQuestionTask), steps: [step])
    }

    
    private var heightQuestionTask: ORKTask {
        let answerFormat1 = ORKAnswerFormat.heightAnswerFormat()
        
        let step1 = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep1), title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat1)
        
        step1.text = "Local system"
        
        
        let step1NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep1)  + "NonOptional", title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat1)
        step1NonOptional.text = "Local system (Non Optional)"
        step1NonOptional.isOptional = false
        
        let answerFormat2 = ORKAnswerFormat.heightAnswerFormat(with: ORKMeasurementSystem.metric)
        
        let step2 = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep2), title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat2)
        
        step2.text = "Metric system"

        let step2NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep2)  + "NonOptional", title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat2)
        step2NonOptional.text = "Metric system (Non Optional)"
        step2NonOptional.isOptional = false
        
        
        let answerFormat3 = ORKAnswerFormat.heightAnswerFormat(with: ORKMeasurementSystem.USC)
        
        let step3 = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep3), title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat3)
        
        step3.text = "USC system"

        let step3NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep3)  + "NonOptional", title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat3)
        step3NonOptional.text = "USC system (Non Optional)"
        step3NonOptional.isOptional = false
 

        
        let answerFormat4 = ORKAnswerFormat.heightAnswerFormat(with: ORKMeasurementSystem.metric)
        
        let step4 = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep4), title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat4)
        
        step4.text = "HealthKit, height"
        
        let step4NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.heightQuestionStep4)  + "NonOptional", title: NSLocalizedString("Height", comment: ""), question: exampleQuestionText, answer: answerFormat4)
        step4NonOptional.text = "HealthKit, height (Non Optional"
        step4NonOptional.isOptional = false
        
        return ORKOrderedTask(identifier: String(describing: Identifier.heightQuestionTask), steps: [step1, step1NonOptional, step2, step2NonOptional, step3, step3NonOptional, step4NonOptional, step4])
    }

    
    private var weightQuestionTask: ORKTask {
        let answerFormat1 = ORKAnswerFormat.weightAnswerFormat()
             
         let step1 = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep1), title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat1)
         
         step1.text = "Local system, default precision"
                 
         let step1NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep1)  + "NonOptional", title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat1)
         
         step1NonOptional.text = "Local system, default precision (nonOptional)"
         step1NonOptional.isOptional = false
         
         let answerFormat2 = ORKAnswerFormat.weightAnswerFormat(with: ORKMeasurementSystem.metric)
         
         let step2 = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep2), title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat2)
         
         step2.text = "Metric system, default precision"
         
         let step2NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep2)  + "NonOptional", title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat2)
         
         step2NonOptional.text = "Metric system, default precision (nonOptional)"
         step2NonOptional.isOptional = false
         
         let answerFormat3 = ORKAnswerFormat.weightAnswerFormat(with: ORKMeasurementSystem.metric, numericPrecision: ORKNumericPrecision.low, minimumValue: ORKDoubleDefaultValue, maximumValue: ORKDoubleDefaultValue, defaultValue: ORKDoubleDefaultValue)
         
         let step3 = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep3), title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat3)
         
         step3.text = "Metric system, low precision"

         let step3NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep3)  + "NonOptional", title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat3)
         step3NonOptional.text = "Metric system, low precision (nonOptional)"
         step3NonOptional.isOptional = false
         
         let answerFormat4 = ORKAnswerFormat.weightAnswerFormat(with: ORKMeasurementSystem.metric, numericPrecision: ORKNumericPrecision.high, minimumValue: 20.0, maximumValue: 100.0, defaultValue: 45.50)
         
         let step4 = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep4), title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat4)
         
         step4.text = "Metric system, high precision"

         let step4NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep4)  + "NonOptional", title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat4)
         step4NonOptional.text = "Metric system, high precision (nonOptional)"
         step4NonOptional.isOptional = false
         
         let answerFormat5 = ORKAnswerFormat.weightAnswerFormat(with: ORKMeasurementSystem.USC)
         
         let step5 = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep5), title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat5)
         
         step5.text = "USC system, default precision"
         
         let step5NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep5)  + "NonOptional", title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat5)
         step5NonOptional.text = "USC system, default precision (nonOptional)"
         step5NonOptional.isOptional = false
         
         let answerFormat6 = ORKAnswerFormat.weightAnswerFormat(with: ORKMeasurementSystem.USC, numericPrecision: ORKNumericPrecision.high, minimumValue: 50.0, maximumValue: 150.0, defaultValue: 100.0)
         
         let step6 = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep6), title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat6)
         
         step6.text = "USC system, high precision"

         let step6NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep6)  + "NonOptional", title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat6)
         step6NonOptional.text = "USC system, high precision (nonOptional)"
         step6NonOptional.isOptional = false
        
        let answerFormat7 = ORKAnswerFormat.weightAnswerFormat(with: ORKMeasurementSystem.USC, numericPrecision: ORKNumericPrecision.low, minimumValue: 50.0, maximumValue: 150.0, defaultValue: 100.0)
         

         let step7 = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep7), title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat7)
         step7.text = "HealthKit, body mass"
        
         let step7NonOptional = ORKQuestionStep(identifier: String(describing: Identifier.weightQuestionStep7)  + "NonOptional", title: NSLocalizedString("Weight", comment: ""), question: exampleQuestionText, answer: answerFormat7)
         step7NonOptional.text =  "HealthKit, body mass (nonOptional)"
         step7NonOptional.isOptional = false
        
        return ORKOrderedTask(identifier: String(describing: Identifier.weightQuestionTask), steps: [step1, step1NonOptional, step2, step2NonOptional, step3, step3NonOptional, step4, step4NonOptional, step5, step5NonOptional, step6, step6NonOptional, step7NonOptional, step7])
    }

    private var healthQuantityTypeTask: ORKTask {
        let heartRateHealthKitQuantityTypeAnswerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "YES", noString: "NO")

        let heartRateQuestion = ORKQuestionStep(identifier: String(describing: Identifier.healthQuantityQuestion1), title: NSLocalizedString("Heart Rate", comment: ""), question: "What is your Heart Rate?", answer: heartRateHealthKitQuantityTypeAnswerFormat)
        heartRateQuestion.text = "Heart Rate"
        heartRateQuestion.isOptional = false
        
        
        let bloodType = HKCharacteristicType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!
        let bloodTypeAnswerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "YES", noString: "NO")

        let bloodTypeQuestion = ORKQuestionStep(identifier: String(describing: Identifier.healthQuantityQuestion2), title: NSLocalizedString("Blood Type", comment: ""), question: "What is your Blood Type?", answer: bloodTypeAnswerFormat)
        
        return ORKOrderedTask(identifier: String(describing: Identifier.healthQuantityTask), steps: [heartRateQuestion, bloodTypeQuestion])
    }
    
    private var imageChoiceQuestionTask: ORKTask {
        let roundShapeImage = UIImage(named: "round_shape")!
        let roundShapeText = NSLocalizedString("Round Shape", comment: "")
        
        let squareShapeImage = UIImage(named: "square_shape")!
        let squareShapeText = NSLocalizedString("Square Shape", comment: "")
        
        let imageChoces = [
            ORKImageChoice(normalImage: roundShapeImage, selectedImage: nil, text: roundShapeText, value: roundShapeText as NSString),
            ORKImageChoice(normalImage: squareShapeImage, selectedImage: nil, text: squareShapeText, value: squareShapeText as NSString)
        ]
        
        let answerFormat1 = ORKAnswerFormat.choiceAnswerFormat(with: imageChoces)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing: Identifier.imageChoiceQuestionStep1), title: NSLocalizedString("Image Choice", comment: ""), question: exampleQuestionText, answer: answerFormat1)

        questionStep1.text = exampleDetailText

        let answerFormat2 = ORKAnswerFormat.choiceAnswerFormat(with: imageChoces, style: .multipleChoice, vertical: true)
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing: Identifier.imageChoiceQuestionStep2), title: NSLocalizedString("Image Choice", comment: ""), question: exampleQuestionText, answer: answerFormat2)

        questionStep2.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.imageChoiceQuestionTask), steps: [questionStep1, questionStep2])
    }
    
    
    private var locationQuestionTask: ORKTask {
        let answerFormat = ORKLocationAnswerFormat()
        
        
        let questionStep = ORKQuestionStep(identifier: String(describing: Identifier.locationQuestionStep), title: NSLocalizedString("Location", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        questionStep.text = exampleDetailText
        questionStep.placeholder = NSLocalizedString("Address", comment: "")
        
        return ORKOrderedTask(identifier: String(describing: Identifier.locationQuestionTask), steps: [questionStep])
    }
    
    
    private var reviewTask: ORKTask {
        let embeddedReviewStep = ORKReviewStep.embeddedReviewStep(withIdentifier: String(describing: Identifier.embeddedReviewStep))
        embeddedReviewStep.bodyItems = [
            ORKBodyItem(text: "Review Item #1", detailText: nil, image: nil, learnMoreItem: nil, bodyItemStyle: .bulletPoint),
            ORKBodyItem(text: "Review Item #2", detailText: nil, image: nil, learnMoreItem: nil, bodyItemStyle: .bulletPoint),
            ORKBodyItem(text: "Review Item #3", detailText: nil, image: nil, learnMoreItem: nil, bodyItemStyle: .bulletPoint),
            ORKBodyItem(text: "Review Item #4", detailText: nil, image: nil, learnMoreItem: nil, bodyItemStyle: .bulletPoint)
        ]
        embeddedReviewStep.title = "Embedded Review Step"
        
        let standAloneInstructionStep1 =  ORKInstructionStep(identifier: "standAloneInstruction1")
        standAloneInstructionStep1.text = "First Item"
        standAloneInstructionStep1.detailText = "There is a lot of detail to cover in this Instruction Step"
        
        let standAloneInstructionStep2 =  ORKInstructionStep(identifier: "standAloneInstruction2")
        standAloneInstructionStep2.text = "Second Item"
        standAloneInstructionStep2.detailText = "There is a lot of detail to cover in this Instruction Step"

        let standAloneInstructionStep3 =  ORKInstructionStep(identifier: "standAloneInstruction3")
        standAloneInstructionStep3.text = "Third Item"
        standAloneInstructionStep3.detailText = "There is a lot of detail to cover in this Instruction Step"
        
        let questionStep = ORKQuestionStep(identifier: "questionStep", title: "Question Step", question: "What is your name?", answer: ORKTextAnswerFormat())
        
        let standAloneReviewStep = ORKReviewStep.standaloneReviewStep(withIdentifier:String(describing: Identifier.standAloneReviewStep), steps:[standAloneInstructionStep1, standAloneInstructionStep2, standAloneInstructionStep3, questionStep], resultSource: nil)
        standAloneReviewStep.title = "Standalone Review"
        return ORKOrderedTask(identifier: String(describing: Identifier.reviewTask), steps: [embeddedReviewStep, standAloneReviewStep])
    }

    private var numericQuestionTask: ORKTask {
        
        let localizedQuestionStep1AnswerFormatUnit = NSLocalizedString("Your unit", comment: "")
        let questionStep1AnswerFormat = ORKAnswerFormat.decimalAnswerFormat(withUnit: localizedQuestionStep1AnswerFormatUnit)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing: Identifier.numericQuestionStep), title: NSLocalizedString("Numeric", comment: ""), question: exampleQuestionText, answer: questionStep1AnswerFormat)
        
        questionStep1.text = exampleDetailText
        questionStep1.placeholder = NSLocalizedString("Your placeholder.", comment: "")
                
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing: Identifier.numericNoUnitQuestionStep), title: NSLocalizedString("Numeric", comment: ""), question: exampleQuestionText, answer: ORKAnswerFormat.decimalAnswerFormat(withUnit: nil))
        
        questionStep2.text = exampleDetailText
        questionStep2.placeholder = NSLocalizedString("Placeholder without unit.", comment: "")
        
        
        let questionStep3 = ORKQuestionStep(identifier: String(describing: Identifier.numericDisplayUnitQuestionStep), title: NSLocalizedString("Numeric with Display Unit", comment: ""), question: exampleQuestionText, answer: ORKNumericAnswerFormat(style: .decimal, unit: "weeks", displayUnit: "semanas", minimum: nil, maximum: nil, maximumFractionDigits: 1))
        
        questionStep3.text = exampleDetailText
        questionStep3.placeholder = NSLocalizedString("Placeholder with display unit.", comment: "")
        
        
        return ORKOrderedTask(identifier: String(describing: Identifier.numericQuestionTask), steps: [
            questionStep1,
            questionStep2,
            questionStep3
        ])
    }
    
    
    private var scaleQuestionTask: ORKTask {
        
        let stepTitle = NSLocalizedString("Scale", comment: "")
        
        let step1AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing: Identifier.discreteScaleQuestionStep), title: stepTitle, question: exampleQuestionText, answer: step1AnswerFormat)
        
        questionStep1.text = NSLocalizedString("Discrete Scale", comment: "")
        
        
        let step2AnswerFormat = ORKAnswerFormat.continuousScale(withMaximumValue: 1.0, minimumValue: 0.0, defaultValue: 99.0, maximumFractionDigits: 0, vertical: false, maximumValueDescription: nil, minimumValueDescription: nil)
        step2AnswerFormat.numberStyle = .percent
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing: Identifier.continuousScaleQuestionStep), title: stepTitle, question: exampleQuestionText, answer: step2AnswerFormat)
        
        questionStep2.text = NSLocalizedString("Continuous Scale", comment: "")
        
        
        let step3AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: true, maximumValueDescription: nil, minimumValueDescription: nil)
        
        let questionStep3 = ORKQuestionStep(identifier: String(describing: Identifier.discreteVerticalScaleQuestionStep), title: stepTitle, question: exampleQuestionText, answer: step3AnswerFormat)
        
        questionStep3.text = NSLocalizedString("Discrete Vertical Scale", comment: "")
        
        
        let step4AnswerFormat = ORKAnswerFormat.continuousScale(withMaximumValue: 5.0, minimumValue: 1.0, defaultValue: 99.0, maximumFractionDigits: 2, vertical: true, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
        
        let questionStep4 = ORKQuestionStep(identifier: String(describing: Identifier.continuousVerticalScaleQuestionStep), title: stepTitle, question: exampleQuestionText, answer: step4AnswerFormat)
        
        questionStep4.text = "Continuous Vertical Scale"
        
        
        let textChoices: [ORKTextChoice] = [ORKTextChoice(text: "Poor", value: 1 as NSNumber), ORKTextChoice(text: "Fair", value: 2 as NSNumber), ORKTextChoice(text: "Good", value: 3 as NSNumber), ORKTextChoice(text: "Above Average", value: 10 as NSNumber), ORKTextChoice(text: "Excellent", value: 5 as NSNumber)]

        let step5AnswerFormat = ORKAnswerFormat.textScale(with: textChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let questionStep5 = ORKQuestionStep(identifier: String(describing: Identifier.textScaleQuestionStep), title: stepTitle, question: exampleQuestionText, answer: step5AnswerFormat)
        
        questionStep5.text = "Text Scale"
        
        
        let step6AnswerFormat = ORKAnswerFormat.textScale(with: textChoices, defaultIndex: NSIntegerMax, vertical: true)
        
        let questionStep6 = ORKQuestionStep(identifier: String(describing: Identifier.textVerticalScaleQuestionStep), title: stepTitle, question: exampleQuestionText, answer: step6AnswerFormat)
        
        questionStep6.text = "Text Vertical Scale"
        
        return ORKOrderedTask(identifier: String(describing: Identifier.scaleQuestionTask), steps: [
            questionStep1,
            questionStep2,
            questionStep3,
            questionStep4,
            questionStep5,
            questionStep6
            ])
    }
    
    private var textQuestionTask: ORKTask {
        let answerFormat = ORKAnswerFormat.textAnswerFormat()
        answerFormat.multipleLines = true
        answerFormat.maximumLength = 280

        let step = ORKQuestionStep(identifier: String(describing: Identifier.textQuestionStep), title: NSLocalizedString("Text", comment: ""), question: exampleQuestionText, answer: answerFormat)
        step.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.textQuestionTask), steps: [step])
    }
    
    private var textChoiceQuestionTask: ORKTask {
        let textChoiceOneText = NSLocalizedString("Choice 1", comment: "")
        let textChoiceTwoText = NSLocalizedString("Choice 2", comment: "")
        let textChoiceThreeText = NSLocalizedString("Choice 3", comment: "")
        let textChoiceFourText = NSLocalizedString("Other", comment: "")
        
        
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSString),
            ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSString),
            ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSString),
            ORKTextChoiceOther.choice(withText: textChoiceFourText, detailText: nil, value: "choice_4" as NSString, exclusive: true, textViewPlaceholderText: "enter additional information")
        ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)

        let questionStep = ORKQuestionStep(identifier: String(describing: Identifier.textChoiceQuestionStep), title: NSLocalizedString("Text Choice", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.textChoiceQuestionTask), steps: [questionStep])
    }

    
    private var textChoiceQuestionWithImageTask: ORKTask {
        let textChoiceOneText = NSLocalizedString("Choice 1", comment: "")
        let textChoiceTwoText = NSLocalizedString("Choice 2", comment: "")
        let textChoiceThreeText = NSLocalizedString("Choice 3", comment: "")
        
        
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, image: UIImage(named: "Face")!, value: "tap 1" as NSString),
            ORKTextChoice(text: textChoiceTwoText, image: UIImage(named: "Face")!, value: "tap 2" as NSString),
            ORKTextChoice(text: textChoiceThreeText, image: UIImage(named: "Face")!, value: "tap 3" as NSString)
        ]
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
        let questionStep = ORKQuestionStep(identifier: String(describing: Identifier.textChoiceQuestionWithImageStep), title: NSLocalizedString("Text Choice", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.textChoiceQuestionWithImageTask), steps: [questionStep])
    }
    
    private var timeIntervalQuestionTask: ORKTask {

        let answerFormat = ORKAnswerFormat.timeIntervalAnswerFormat()
        
        let step = ORKQuestionStep(identifier: String(describing: Identifier.timeIntervalQuestionStep), title: NSLocalizedString("Time Interval", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        step.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.timeIntervalQuestionTask), steps: [step])
    }

    
    private var timeOfDayQuestionTask: ORKTask {

        let answerFormat = ORKAnswerFormat.timeOfDayAnswerFormat()
        
        let questionStep = ORKQuestionStep(identifier: String(describing: Identifier.timeOfDayQuestionStep), title: NSLocalizedString("Time", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        questionStep.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.timeOfDayQuestionTask), steps: [questionStep])
    }

    private var valuePickerChoiceQuestionTask: ORKTask {
        let textChoiceOneText = NSLocalizedString("Choice 1", comment: "")
        let textChoiceTwoText = NSLocalizedString("Choice 2", comment: "")
        let textChoiceThreeText = NSLocalizedString("Choice 3", comment: "")
        
        
        let textChoices = [
            ORKTextChoice(text: textChoiceOneText, value: "choice_1" as NSString),
            ORKTextChoice(text: textChoiceTwoText, value: "choice_2" as NSString),
            ORKTextChoice(text: textChoiceThreeText, value: "choice_3" as NSString)
        ]
        
        let answerFormat = ORKAnswerFormat.valuePickerAnswerFormat(with: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: String(describing: Identifier.valuePickerChoiceQuestionStep), title: NSLocalizedString("Value Picker", comment: ""), question: exampleQuestionText, answer: answerFormat)
        
        questionStep.text = NSLocalizedString("Text Value picker", comment: "")
        
        return ORKOrderedTask(identifier: String(describing: Identifier.valuePickerChoiceQuestionTask), steps: [questionStep])
    }

    private var validatedTextQuestionTask: ORKTask {
        let emailDomainRegularExpressionPattern =  "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
        let emailDomainRegularExpression = try? NSRegularExpression(pattern: emailDomainRegularExpressionPattern)
        let emailAnswerFormatDomain = ORKAnswerFormat.textAnswerFormat(withValidationRegularExpression: emailDomainRegularExpression!, invalidMessage: "Invalid Email: %@")
        
        let stepEmail = ORKQuestionStep(identifier: String(describing: Identifier.validatedTextQuestionStepEmail), title: NSLocalizedString("Validated Text", comment: ""), question: NSLocalizedString("Email", comment: ""), answer: emailAnswerFormatDomain)
        stepEmail.text = exampleDetailText
        
        let urlDomainRegularExpressionPattern = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        let urlDomainRegularExpression = try? NSRegularExpression(pattern: urlDomainRegularExpressionPattern)
        let answerFormatDomain = ORKAnswerFormat.textAnswerFormat(withValidationRegularExpression: urlDomainRegularExpression!, invalidMessage: "Invalid URL: %@")

        answerFormatDomain.multipleLines = false
        answerFormatDomain.keyboardType = .URL
        answerFormatDomain.autocapitalizationType = UITextAutocapitalizationType.none
        answerFormatDomain.autocorrectionType = UITextAutocorrectionType.no
        answerFormatDomain.spellCheckingType = UITextSpellCheckingType.no
        answerFormatDomain.textContentType = UITextContentType.URL
        let stepDomain = ORKQuestionStep(identifier: String(describing: Identifier.validatedTextQuestionStepDomain), title: NSLocalizedString("Validated Text", comment: ""), question: NSLocalizedString("URL", comment: ""), answer: answerFormatDomain)
        stepDomain.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.validatedTextQuestionTask), steps: [stepEmail, stepDomain])
    }
    
    
    private var imageCaptureTask: ORKTask {
        
        let instructionStep = ORKInstructionStep(identifier: String(describing: Identifier.introStep))
        
        instructionStep.title = NSLocalizedString("Image Capture Survey", comment: "")
        
        instructionStep.text = exampleDescription
        
        let handSolidImage = UIImage(named: "hand_solid")!
        instructionStep.image = handSolidImage.withRenderingMode(.alwaysTemplate)
        
        let imageCaptureStep = ORKImageCaptureStep(identifier: String(describing: Identifier.imageCaptureStep))
        imageCaptureStep.title = NSLocalizedString("Image Capture", comment: "")
        imageCaptureStep.isOptional = false
        imageCaptureStep.accessibilityInstructions = NSLocalizedString("Your instructions for capturing the image", comment: "")
        imageCaptureStep.accessibilityHint = NSLocalizedString("Captures the image visible in the preview", comment: "")
        
        imageCaptureStep.templateImage = UIImage(named: "hand_outline_big")!
        
        imageCaptureStep.templateImageInsets = UIEdgeInsets(top: 0.05, left: 0.05, bottom: 0.05, right: 0.05)
        
        return ORKOrderedTask(identifier: String(describing: Identifier.imageCaptureTask), steps: [
            instructionStep,
            imageCaptureStep
            ])
    }
    
    
    private var videoCaptureTask: ORKTask {
        
        let instructionStep = ORKInstructionStep(identifier: String(describing: Identifier.introStep))
        
        instructionStep.title = NSLocalizedString("Video Capture Survey", comment: "")
        
        instructionStep.text = exampleDescription
        
        let handSolidImage = UIImage(named: "hand_solid")!
        instructionStep.image = handSolidImage.withRenderingMode(.alwaysTemplate)
        
        let videoCaptureStep = ORKVideoCaptureStep(identifier: String(describing: Identifier.videoCaptureStep))
        videoCaptureStep.title = NSLocalizedString("Video Capture", comment: "")
        videoCaptureStep.accessibilityInstructions = NSLocalizedString("Your instructions for capturing the video", comment: "")
        videoCaptureStep.accessibilityHint = NSLocalizedString("Captures the video visible in the preview", comment: "")
        videoCaptureStep.templateImage = UIImage(named: "hand_outline_big")!
        videoCaptureStep.templateImageInsets = UIEdgeInsets(top: 0.05, left: 0.05, bottom: 0.05, right: 0.05)
        videoCaptureStep.duration = 30.0; 
        
        return ORKOrderedTask(identifier: String(describing: Identifier.videoCaptureTask), steps: [
            instructionStep,
            videoCaptureStep
            ])
    }
    
    
    private var waitTask: ORKTask {
        let waitStepIndeterminate = ORKWaitStep(identifier: String(describing: Identifier.waitStepIndeterminate))
        waitStepIndeterminate.title = NSLocalizedString("Wait Step", comment: "")
        waitStepIndeterminate.text = exampleDescription
        waitStepIndeterminate.indicatorType = ORKProgressIndicatorType.indeterminate
        
        let waitStepDeterminate = ORKWaitStep(identifier: String(describing: Identifier.waitStepDeterminate))
        waitStepDeterminate.title = NSLocalizedString("Wait Step", comment: "")
        waitStepDeterminate.text = exampleDescription
        waitStepDeterminate.indicatorType = ORKProgressIndicatorType.progressBar
        
        return ORKOrderedTask(identifier: String(describing: Identifier.waitTask), steps: [waitStepIndeterminate, waitStepDeterminate])
    }
    
    
    private var PDFViewerTask: ORKTask {

        let PDFViewerStep = ORKPDFViewerStep(identifier: String(describing: Identifier.pdfViewerStep), pdfURL: Bundle.main.bundleURL.appendingPathComponent("ResearchKit.pdf"))
        PDFViewerStep.title = NSLocalizedString("PDF Step", comment: "")
        
        return ORKOrderedTask(identifier: String(describing: Identifier.pdfViewerTask), steps: [PDFViewerStep])
    }
    
    private var requestPermissionsTask: ORKTask {

        let notificationsPermissionType = ORKNotificationPermissionType(authorizationOptions: [.alert, .badge, .sound])

        let motionActivityPermissionType = ORKMotionActivityPermissionType()
        let locationPermissionType = ORKLocationPermissionType()

        let healthKitTypesToWrite: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.workoutType()]

        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: .bloodType)!,
            HKObjectType.workoutType()]

        let healthKitPermissionType = ORKHealthKitPermissionType(sampleTypesToWrite: healthKitTypesToWrite,
                                                                 objectTypesToRead: healthKitTypesToRead)

        let requestPermissionsStep = ORKRequestPermissionsStep(
                   identifier: String(describing: Identifier.requestPermissionsStep),
                   permissionTypes: [notificationsPermissionType, motionActivityPermissionType, healthKitPermissionType, locationPermissionType])

        requestPermissionsStep.title = "Health Data Request"
        requestPermissionsStep.text = "Please review the health data types below and enable sharing to contribute to the study."

        return ORKOrderedTask(identifier: String(describing: Identifier.requestPermissionsStep), steps: [requestPermissionsStep])
    }
    
    private var eligibilityTask: ORKTask {
        
        let introStep = ORKInstructionStep(identifier: String(describing: Identifier.eligibilityIntroStep))
        introStep.title = NSLocalizedString("Eligibility Task", comment: "")
        introStep.text = exampleDescription
        introStep.detailText = NSLocalizedString("Please use this space to provide instructions for participants.  Please make sure to provide enough information so that users can progress through the survey and complete with ease.", comment: "")
        
        
        let formStep = ORKFormStep(identifier: String(describing: Identifier.eligibilityFormStep))
        formStep.title = NSLocalizedString("Eligibility", comment: "")
        formStep.isOptional = false
        
        
        let textChoices: [ORKTextChoice] = [ORKTextChoice(text: "Yes", value: "Yes" as NSString), ORKTextChoice(text: "No", value: "No" as NSString), ORKTextChoice(text: "N/A", value: "N/A" as NSString)]

        let answerFormat = ORKTextChoiceAnswerFormat(style: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
        
        let formItem01 = ORKFormItem(identifier: String(describing: Identifier.eligibilityFormItem01), text: exampleQuestionText, answerFormat: answerFormat)
        formItem01.isOptional = false
        let formItem02 = ORKFormItem(identifier: String(describing: Identifier.eligibilityFormItem02), text: exampleQuestionText, answerFormat: answerFormat)
        formItem02.isOptional = false
        let formItem03 = ORKFormItem(identifier: String(describing: Identifier.eligibilityFormItem03), text: exampleQuestionText, answerFormat: answerFormat)
        formItem03.isOptional = false
        
        formStep.formItems = [
            formItem01,
            formItem02,
            formItem03
        ]
        
        
        let ineligibleStep = ORKInstructionStep(identifier: String(describing: Identifier.eligibilityIneligibleStep))
        ineligibleStep.title = NSLocalizedString("Eligibility Result", comment: "")
        ineligibleStep.detailText = NSLocalizedString("You are ineligible to join the study", comment: "")
        
        
        let eligibleStep = ORKCompletionStep(identifier: String(describing: Identifier.eligibilityEligibleStep))
        eligibleStep.title = NSLocalizedString("Eligibility Result", comment: "")
        eligibleStep.detailText = NSLocalizedString("You are eligible to join the study", comment: "")
        
        
        let eligibilityTask = ORKNavigableOrderedTask(identifier: String(describing: Identifier.eligibilityTask), steps: [
            introStep,
            formStep,
            ineligibleStep,
            eligibleStep
            ])
        
        
        var resultSelector = ORKResultSelector(stepIdentifier: String(describing: Identifier.eligibilityFormStep), resultIdentifier: String(describing: Identifier.eligibilityFormItem01))

        let predicateFormItem01 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: "Yes" as NSString)
        
        resultSelector = ORKResultSelector(stepIdentifier: String(describing: Identifier.eligibilityFormStep), resultIdentifier: String(describing: Identifier.eligibilityFormItem02))
        let predicateFormItem02 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: "Yes" as NSString)
        
        resultSelector = ORKResultSelector(stepIdentifier: String(describing: Identifier.eligibilityFormStep), resultIdentifier: String(describing: Identifier.eligibilityFormItem03))
        let predicateFormItem03 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: "No" as NSString)
        
        let predicateEligible = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateFormItem01, predicateFormItem02, predicateFormItem03])
        let predicateRule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [ (predicateEligible, String(describing: Identifier.eligibilityEligibleStep)) ])
        
        eligibilityTask.setNavigationRule(predicateRule, forTriggerStepIdentifier: String(describing: Identifier.eligibilityFormStep))
        
        
        let directRule = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
        eligibilityTask.setNavigationRule(directRule, forTriggerStepIdentifier: String(describing: Identifier.eligibilityIneligibleStep))
        
        return eligibilityTask
    }
    
    
    private var accountCreationTask: ORKTask {
        let registrationTitle = NSLocalizedString("Registration", comment: "")
        let passcodeValidationRegexPattern = "^(?=.*\\d).{4,8}$"
        let passcodeValidationRegularExpression = try? NSRegularExpression(pattern: passcodeValidationRegexPattern)
        let passcodeInvalidMessage = NSLocalizedString("A valid password must be 4 to 8 characters long and include at least one numeric character.", comment: "")
        let registrationOptions: ORKRegistrationStepOption = [.includeGivenName, .includeFamilyName, .includeGender, .includeDOB, .includePhoneNumber]
        let registrationStep = ORKRegistrationStep(identifier: String(describing: Identifier.registrationStep), title: registrationTitle, text: exampleDetailText, passcodeValidationRegularExpression: passcodeValidationRegularExpression, passcodeInvalidMessage: passcodeInvalidMessage, options: registrationOptions)
        registrationStep.phoneNumberValidationRegularExpression = try? NSRegularExpression(pattern: "^[+]{1,1}[1]{1,1}\\s{1,1}[(]{1,1}[1-9]{3,3}[)]{1,1}\\s{1,1}[1-9]{3,3}\\s{1,1}[1-9]{4,4}$")
        registrationStep.phoneNumberInvalidMessage = "Expected format +1 (555) 555 5555"
        
        let waitTitle = NSLocalizedString("Creating account", comment: "")
        let waitText = NSLocalizedString("Please wait while we upload your data", comment: "")
        let waitStep = ORKWaitStep(identifier: String(describing: Identifier.waitStep))
        waitStep.title = waitTitle
        waitStep.text = waitText
        
        class VerificationViewController: ORKVerificationStepViewController {
            override func resendEmailButtonTapped() {
                let alertTitle = NSLocalizedString("Resend Verification Email", comment: "")
                let alertMessage = NSLocalizedString("Button tapped", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let verificationStep = ORKVerificationStep(identifier: String(describing: Identifier.verificationStep), text: exampleDetailText, verificationViewControllerClass: VerificationViewController.self)
        
        return ORKOrderedTask(identifier: String(describing: Identifier.accountCreationTask), steps: [
            registrationStep,
            waitStep,
            verificationStep
            ])
    }
    
    
    private var loginTask: ORKTask {

        class LoginViewController: ORKLoginStepViewController {
            override func forgotPasswordButtonTapped() {
                let alertTitle = NSLocalizedString("Forgot password?", comment: "")
                let alertMessage = NSLocalizedString("Button tapped", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let loginTitle = NSLocalizedString("Login", comment: "")
        let loginStep = ORKLoginStep(identifier: String(describing: Identifier.loginStep), title: loginTitle, text: exampleDetailText, loginViewControllerClass: LoginViewController.self)

        let waitTitle = NSLocalizedString("Logging in", comment: "")
        let waitText = NSLocalizedString("Please wait while we validate your credentials", comment: "")
        let waitStep = ORKWaitStep(identifier: String(describing: Identifier.loginWaitStep))
        waitStep.title = waitTitle
        waitStep.text = waitText
        
        return ORKOrderedTask(identifier: String(describing: Identifier.loginTask), steps: [loginStep, waitStep])
    }
    
    
    private var passcodeTask: ORKTask {
        let passcodeConsentStep = ORKPasscodeStep(identifier: String(describing: Identifier.passcodeStep))
        passcodeConsentStep.title = NSLocalizedString("Passcode", comment: "")
        return ORKOrderedTask(identifier: String(describing: Identifier.passcodeTask), steps: [passcodeConsentStep])
    }
    
    private var biometricPasscodeTask: ORKTask {

        let passcodeConsentStep = ORKPasscodeStep(identifier: String(describing: Identifier.biometricPasscodeStep))
        passcodeConsentStep.useBiometrics = true
        passcodeConsentStep.title = NSLocalizedString("Passcode", comment: "")
        
        let passcodeAuthConsentStep = ORKPasscodeStep(identifier: String(describing: Identifier.biometricPasscodeStep) + "auth", passcodeFlow: .authenticate)
        passcodeAuthConsentStep.useBiometrics = true
        passcodeAuthConsentStep.title = NSLocalizedString("Passcode", comment: "")

        return ORKOrderedTask(identifier: String(describing: Identifier.biometricPasscodeTask), steps: [passcodeConsentStep, passcodeAuthConsentStep])
    }
    
    
    private var audioTask: ORKTask {
        return ORKOrderedTask.audioTask(withIdentifier: String(describing: Identifier.audioTask), intendedUseDescription: exampleDescription, speechInstruction: exampleSpeechInstruction, shortSpeechInstruction: exampleSpeechInstruction, duration: 20, recordingSettings: nil, checkAudioLevel: true, options: [])
    }
    
    private var amslerGridTask: ORKTask {
        return ORKOrderedTask.amslerGridTask(withIdentifier: String(describing: Identifier.amslerGridTask), intendedUseDescription: exampleDescription, options: [])
    }
    
    private var fitnessTask: ORKTask {
        return ORKOrderedTask.fitnessCheck(withIdentifier: String(describing: Identifier.fitnessTask), intendedUseDescription: exampleDescription, walkDuration: 20, restDuration: 20, options: [])
    }

    private var sixMinuteWalkTask: ORKTask {
        if #available(iOS 14, *) {
            return ORKOrderedTask.sixMinuteWalk(
                withIdentifier: String(describing: Identifier.sixMinuteWalkTask),
                intendedUseDescription: exampleDescription,
                options: []
            )
        } else {
            return ORKOrderedTask.fitnessCheck(
                withIdentifier: String(describing: Identifier.sixMinuteWalkTask),
                intendedUseDescription: exampleDescription,
                walkDuration: 360,
                restDuration: 0,
                options: []
            )
        }
    }

    
    private var holePegTestTask: ORKTask {
        return ORKNavigableOrderedTask.holePegTest(withIdentifier: String(describing: Identifier.holePegTestTask), intendedUseDescription: exampleDescription, dominantHand: .right, numberOfPegs: 9, threshold: 0.2, rotated: false, timeLimit: 300, options: [])
    }
    
    
    private var PSATTask: ORKTask {
        return ORKOrderedTask.psatTask(withIdentifier: String(describing: Identifier.psatTask), intendedUseDescription: exampleDescription, presentationMode: ORKPSATPresentationMode.auditory.union(.visual), interStimulusInterval: 3.0, stimulusDuration: 1.0, seriesLength: 60, options: [])
    }
    
    
    private var reactionTimeTask: ORKTask {
        
        let successSoundURL = Bundle.main.url(forResource: "tap", withExtension: "aif")!
        let successSound = SystemSound(soundURL: successSoundURL)!
        return ORKOrderedTask.reactionTime(withIdentifier: String(describing: Identifier.reactionTime), intendedUseDescription: exampleDescription, maximumStimulusInterval: 10, minimumStimulusInterval: 4, thresholdAcceleration: 0.5, numberOfAttempts: 3, timeout: 3, successSound: successSound.soundID, timeoutSound: 0, failureSound: UInt32(kSystemSoundID_Vibrate), options: [])
    }
    
    private var normalizedReactionTimeTask: ORKTask {
        
        let successSoundURL = Bundle.main.url(forResource: "tap", withExtension: "aif")!
        let successSound = SystemSound(soundURL: successSoundURL)!
        return ORKOrderedTask.normalizedReactionTime(withIdentifier: String(describing: Identifier.normalizedReactionTime), intendedUseDescription: exampleDescription, maximumStimulusInterval: 10, minimumStimulusInterval: 4, thresholdAcceleration: 0.5, numberOfAttempts: 3, timeout: 3, successSound: successSound.soundID, timeoutSound: 0, failureSound: UInt32(kSystemSoundID_Vibrate), options: [])
    }
    
    
    private var shortWalkTask: ORKTask {
        return ORKOrderedTask.shortWalk(withIdentifier: String(describing: Identifier.shortWalkTask), intendedUseDescription: exampleDescription, numberOfStepsPerLeg: 20, restDuration: 20, options: [])
    }
    
    
    private var spatialSpanMemoryTask: ORKTask {
        return ORKOrderedTask.spatialSpanMemoryTask(withIdentifier: String(describing: Identifier.spatialSpanMemoryTask), intendedUseDescription: exampleDescription, initialSpan: 3, minimumSpan: 2, maximumSpan: 15, playSpeed: 1.0, maximumTests: 5, maximumConsecutiveFailures: 3, customTargetImage: nil, customTargetPluralName: nil, requireReversal: false, options: [])
    }
    
    
    private var speechRecognitionTask: ORKTask {
        return ORKOrderedTask.speechRecognitionTask(withIdentifier: String(describing: Identifier.speechRecognitionTask), intendedUseDescription: exampleDescription, speechRecognizerLocale: .englishUS, speechRecognitionImage: nil, speechRecognitionText: NSLocalizedString("A quick brown fox jumps over the lazy dog.", comment: ""), shouldHideTranscript: false, allowsEdittingTranscript: true, options: [])
    }
    
    
    private var speechInNoiseTask: ORKTask {
        return ORKOrderedTask.speechInNoiseTask(withIdentifier: String(describing: Identifier.speechInNoiseTask), intendedUseDescription: nil, options: [])
    }
    
    
    
    private var stroopTask: ORKTask {
        return ORKOrderedTask.stroopTask(withIdentifier: String(describing: Identifier.stroopTask), intendedUseDescription: exampleDescription, numberOfAttempts: 10, options: [])
    }
    
    
    private var swiftStroopTask: ORKTask {
        let instructionStep = ORKInstructionStep(identifier: "stroopInstructionStep")
        instructionStep.title = "Stroop"
        instructionStep.text = "Your description goes here."
        instructionStep.image = UIImage(named: "stroop")
        instructionStep.imageContentMode = .center
        instructionStep.detailText = "Every time a word appears, select the first letter of the name of the COLOR that is shown."
        
        let instructionStep2 = ORKInstructionStep(identifier: "stroopInstructionStep2")
        instructionStep2.title = "Stroop"
        instructionStep2.text = "Your description goes here."
        instructionStep2.detailText = "Every time a word appears, select the first letter of the name of the COLOR that is shown."
        instructionStep2.image = UIImage(named: "stroop")
        instructionStep2.imageContentMode = .center
        
        let countdownStep = ORKCountdownStep(identifier: "stroopCountdownStep")
        countdownStep.title = "Stroop"
        
        let stroopStep = ORKSwiftStroopStep(identifier: "stroopStep")
        stroopStep.numberOfAttempts = 10
        stroopStep.title = "Stroop"
        stroopStep.text = "Select the first letter of the name of the COLOR that is shown."
        stroopStep.spokenInstruction = stroopStep.text
        
        let completionStep = ORKCompletionStep(identifier: "stroopCompletionStep")
        completionStep.title = "Activity Complete"
        completionStep.text = "Your data will be analyzed and you will be notified when your results are ready."
        
        return ORKOrderedTask(identifier: "stroopTask", steps: [instructionStep, instructionStep2, countdownStep, stroopStep, completionStep])
    }

    
    private var timedWalkWithTurnAroundTask: ORKTask {
        return ORKOrderedTask.timedWalk(withIdentifier: String(describing: Identifier.timedWalkWithTurnAroundTask), intendedUseDescription: exampleDescription, distanceInMeters: 100.0, timeLimit: 180.0, turnAroundTimeLimit: 60.0, includeAssistiveDeviceForm: true, options: [])
    }

    
    private var toneAudiometryTask: ORKTask {
        return ORKOrderedTask.toneAudiometryTask(withIdentifier: String(describing: Identifier.toneAudiometryTask), intendedUseDescription: exampleDescription, speechInstruction: nil, shortSpeechInstruction: nil, toneDuration: 20, options: [])
    }
    
    
    private var dBHLToneAudiometryTask: ORKTask {
        return ORKOrderedTask.dBHLToneAudiometryTask(withIdentifier: String(describing: Identifier.dBHLToneAudiometryTask), intendedUseDescription: nil, options: [])
    }
    
    
    private var splMeterTask: ORKTask {
        let splMeterStep = ORKEnvironmentSPLMeterStep(identifier: String(describing: Identifier.splMeterStep))
        splMeterStep.samplingInterval = 2
        splMeterStep.requiredContiguousSamples = 10
        splMeterStep.thresholdValue = 60
        splMeterStep.title = NSLocalizedString("SPL Meter", comment: "")
        return ORKOrderedTask(identifier: String(describing: Identifier.splMeterTask), steps: [splMeterStep])
    }

    private var towerOfHanoiTask: ORKTask {
        return ORKOrderedTask.towerOfHanoiTask(withIdentifier: String(describing: Identifier.towerOfHanoi), intendedUseDescription: exampleDescription, numberOfDisks: 5, options: [])
    }
    
    
    private var twoFingerTappingIntervalTask: ORKTask {
        return ORKOrderedTask.twoFingerTappingIntervalTask(withIdentifier: String(describing: Identifier.twoFingerTappingIntervalTask), intendedUseDescription: exampleDescription, duration: 10,
        handOptions: [.both], options: [])
    }
    
    
    private var walkBackAndForthTask: ORKTask {
        return ORKOrderedTask.walkBackAndForthTask(withIdentifier: String(describing: Identifier.walkBackAndForthTask), intendedUseDescription: exampleDescription, walkDuration: 30, restDuration: 30, options: [])
    }
    
    
    private var tremorTestTask: ORKTask {
        return ORKOrderedTask.tremorTest(withIdentifier: String(describing: Identifier.tremorTestTask),
                                                           intendedUseDescription: exampleDescription,
                                                           activeStepDuration: 10,
                                                           activeTaskOptions: [],
                                                           handOptions: [.both],
                                                           options: [])
    }
    
    
    private var kneeRangeOfMotion: ORKTask {
        return ORKOrderedTask.kneeRangeOfMotionTask(withIdentifier: String(describing: Identifier.kneeRangeOfMotion), limbOption: .right, intendedUseDescription: exampleDescription, options: [])
    }
    
    
    private var shoulderRangeOfMotion: ORKTask {
        return ORKOrderedTask.shoulderRangeOfMotionTask(withIdentifier: String(describing: Identifier.shoulderRangeOfMotion), limbOption: .left, intendedUseDescription: exampleDescription, options: [])
    }
    
    
    private var trailMaking: ORKTask {
        let intendedUseDescription = "Tests visual attention and task switching"
        return ORKOrderedTask.trailmakingTask(withIdentifier: String(describing: Identifier.trailMaking), intendedUseDescription: intendedUseDescription, trailmakingInstruction: nil, trailType: .B, options: [])
    }

    
    private var visualAcuityLandoltC: ORKTask {
        let orderedTask = ORKOrderedTask.landoltCVisualAcuityTask(withIdentifier: String(describing: Identifier.visualAcuityLandoltC), intendedUseDescription: "lorem ipsum")
        return orderedTask
    }
    
    
    private var contrastSensitivityPeakLandoltC: ORKTask {
        let orderedTask = ORKOrderedTask.landoltCContrastSensitivityTask(withIdentifier: String(describing: Identifier.contrastSensitivityPeakLandoltC), intendedUseDescription: "lorem ipsum")
        return orderedTask
    }
    
    
    private var videoInstruction: ORKTask {
        let videoInstructionStep = ORKVideoInstructionStep(identifier: String(describing: Identifier.videoInstructionStep))
        videoInstructionStep.title = NSLocalizedString("Video Instruction Step", comment: "")
        videoInstructionStep.videoURL = URL(string: "https://www.apple.com/media/us/researchkit/2016/a63aa7d4_e6fd_483f_a59d_d962016c8093/films/carekit/researchkit-carekit-cc-us-20160321_r848-9dwc.mov")
        videoInstructionStep.thumbnailTime = 2 
        return ORKOrderedTask(identifier: String(describing: Identifier.videoInstructionTask), steps: [videoInstructionStep])
    }
    
    
    private var frontFacingCameraStep: ORKTask {
        let frontFacingCameraStep = ORKFrontFacingCameraStep(identifier: String(describing: Identifier.frontFacingCameraStep))
        frontFacingCameraStep.maximumRecordingLimit = 30.0
        frontFacingCameraStep.title = "Front Facing Camera Step"
        frontFacingCameraStep.text = "Your text goes here."
        frontFacingCameraStep.allowsRetry = true
        frontFacingCameraStep.allowsReview = true

        return ORKOrderedTask(identifier: String(describing: Identifier.videoInstructionTask), steps: [frontFacingCameraStep])
    }
    
    
    
    private var webView: ORKTask {
        let webViewStep = ORKWebViewStep(identifier: String(describing: Identifier.webViewStep), html: exampleHtml)
        webViewStep.title = NSLocalizedString("Web View", comment: "")
        webViewStep.showSignatureAfterContent = true
        return ORKOrderedTask(identifier: String(describing: Identifier.webViewTask), steps: [webViewStep])
    }

    private var tintColor: ORKTask {
        let customStep = ORKFormStep(identifier: String(describing: Identifier.tintColorStep))
        customStep.formItems = [
            ORKFormItem(
                identifier: String(describing: Identifier.tintColorQuestion),
                text: NSLocalizedString("Select a Tint Color", comment: ""),
                detailText: NSLocalizedString("The tint color you select will be propagated to the app window after the task completes", comment: ""),
                learnMoreItem: nil,
                showsProgress: false,
                answerFormat: ORKAnswerFormat.choiceAnswerFormat(
                    with: .singleChoice,
                    textChoices: [
                        ORKTextChoice(text: "Green", value: NSString(string: #keyPath(UIColor.green))),
                        ORKTextChoice(text: "Red", value: NSString(string: #keyPath(UIColor.red))),
                        ORKTextChoice(text: "Yellow", value: NSString(string: #keyPath(UIColor.yellow))),
                        ORKTextChoice(text: "Blue", value: NSString(string: #keyPath(UIColor.blue))),
                    ]
                ),
                tagText: nil,
                optional: true
            )
        ]
        return ORKOrderedTask(identifier: String(describing: Identifier.tintColorTask), steps: [customStep])
    }

    
    
    private var exampleDescription: String {
        return NSLocalizedString("Your description goes here.", comment: "")
    }
    
    private var exampleSpeechInstruction: String {
        return NSLocalizedString("Your more specific voice instruction goes here. For example, say 'Aaaah'.", comment: "")
    }
    
    private var exampleQuestionText: String {
        return NSLocalizedString("Your question goes here.", comment: "")
    }
    
    private var exampleHighValueText: String {
        return NSLocalizedString("High Value", comment: "")
    }
    
    private var exampleLowValueText: String {
        return NSLocalizedString("Low Value", comment: "")
    }
    
    private var exampleDetailText: String {
        return NSLocalizedString("Additional text can go here.", comment: "")
    }
    
    private var exampleEmailText: String {
        return NSLocalizedString("jappleseed@example.com", comment: "")
    }
    
    private var exampleDate3DayLimitQuestionTask: String {
        return NSLocalizedString("This date picker is restricted to 3 days before or after the current date.", comment: "")
    }
    
    private var loremIpsumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    private var loremIpsumShortText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    private var loremIpsumMediumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo?"
    }
    
    private var loremIpsumLongText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo? An potest, inquit ille, quicquam esse suavius quam nihil dolere? Cave putes quicquam esse verius. Quonam, inquit, modo?"
    }
    
    private var exampleHtml: String {
        return """
        <!DOCTYPE html>

        <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta name="viewport" content="width=400, user-scalable=no">
            <meta charset="utf-8" />
            <style type="text/css">
            body
            {
                background: #FFF;
                font-family: Helvetica, sans-serif;
                text-align: center;
            }

            .container
            {
                width: 100%;
                padding: 10px;
                box-sizing: border-box;
            }

            .answer-box
            {
                width: 100%;
                box-sizing: border-box;
                padding: 10px;
                border: solid 1px #ddd;
                border-radius: 2px;
                -webkit-appearance: none;
            }

            .continue-button
            {
                width: 140px;
                text-align: center;
                padding-top: 10px;
                padding-bottom: 10px;
                font-size: 16px;
                color: #2e6e9e;
                border-radius: 2px;
                border: solid 1px #2e6e9e;
                background: #FFF;
                cursor: pointer;
                margin-top: 40px;
            }
            </style>
            <script type="text/javascript">
            function completeStep() {
                var answer = document.getElementById("answer").value;
                window.webkit.messageHandlers.ResearchKit.postMessage(answer);
            }
            </script>
        </head>
        <body>
            <div class="container">
                <input type="text" id="answer" class="answer-box" placeholder="Answer" />
                <button onclick="completeStep();" class="continue-button">Continue</button>
            </div>
        </body>
        </html>
        """
    }
        
}

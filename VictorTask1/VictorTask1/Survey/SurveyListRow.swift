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
    case userCreation = 0
    case eligibilityTask
    case wait
    
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
            TaskListRowSection(title: "Onboarding", rows:
                [
                    .userCreation,
                    .eligibilityTask,
                ]),
        ]
        
            return defaultSections
        }
    
    
    
    var description: String {
        switch self {
            
        case .wait:
            return NSLocalizedString("Wait Step", comment: "")
            
        case .eligibilityTask:
            return NSLocalizedString("Eligibility Task Example", comment: "")

        case .userCreation:
            return NSLocalizedString("User Creation", comment: "")

        }
    }
    
    

    enum Identifier {
        case introStep
        case questionStep
        case birthdayQuestion
        case summaryStep
        
        case waitTask
        case waitStepDeterminate
        case waitStepIndeterminate

        
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
        case waitStep
        case verificationStep

        case tintColorTask
        case tintColorStep
        case tintColorQuestion

    }

    var representedTask: ORKTask {
        switch self {
            
        case .wait:
            return waitTask
        
        case .eligibilityTask:
            return eligibilityTask
            
        case .userCreation:
            return userCreationTask
            
        }
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
    
    
    private var userCreationTask: ORKTask {
        
        let formStep = ORKFormStep(identifier: String(describing: Identifier.eligibilityFormStep), title: "User details", text: exampleDetailText)
        formStep.title = NSLocalizedString("User", comment: "")
        formStep.isOptional = false
        let firstNameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
        let firstNameFormItem = ORKFormItem(identifier: "firstNameFormItemIdentifier", text: "First name", answerFormat: firstNameAnswerFormat)

        let lastNameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
        let lastNameFormItem = ORKFormItem(identifier: "lastNameFormItemIdentifier", text: "Last name", answerFormat: lastNameAnswerFormat)
        
        let yearsFormat = ORKNumericAnswerFormat(style: .integer, unit: "Years", minimum: 18, maximum: 90)
        let yearsFormItem = ORKFormItem(identifier: "yearsFormItemIdentifier", text: "Years", answerFormat: yearsFormat)

        let emailFormat = ORKTextAnswerFormat(maximumLength: 20)
        let emailValidationRegexPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
        let emailValidationRegularExpression = try? NSRegularExpression(pattern: emailValidationRegexPattern)
        emailFormat.validationRegularExpression = emailValidationRegularExpression
        emailFormat.invalidMessage = "Please enter a valid email address."
        let emailFormItem = ORKFormItem(identifier: "emailFormItemIdentifier", text: "email", answerFormat: emailFormat)

        let interestChoices: [ORKTextChoice] = [ORKTextChoice(text: "Sport", value: 1 as NSNumber), ORKTextChoice(text: "Books", value: 2 as NSNumber), ORKTextChoice(text: "Music", value: 3 as NSNumber), ORKTextChoice(text: "TV Show", value: 10 as NSNumber), ORKTextChoice(text: "Nothing", value: 5 as NSNumber)]
        
        let interestAnswerFormat = ORKTextChoiceAnswerFormat(style: .singleChoice, textChoices: interestChoices)
        
        let interestFormItem = ORKFormItem(identifier: "appleFormItemIdentifier", text: "What are your interests?", answerFormat: interestAnswerFormat)
        
        formStep.formItems = [
            emailFormItem,
            firstNameFormItem,
            lastNameFormItem,
            yearsFormItem,
            interestFormItem
        ]
        
        let waitTitle = NSLocalizedString("Creating user", comment: "")
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
        
        let verificationStep = ORKVerificationStep(identifier: String(describing: Identifier.verificationStep), text: exampleEmailText, verificationViewControllerClass: VerificationViewController.self)
        
        return ORKOrderedTask(identifier: String(describing: Identifier.accountCreationTask), steps: [
            formStep,
//            waitStep,
            verificationStep
            ])
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
    
    private var exampleDetailText: String {
        return NSLocalizedString("Additional text can go here.", comment: "")
    }
   
    private var exampleEmailText: String {
        return NSLocalizedString("jappleseed@example.com", comment: "")
    }
        
}

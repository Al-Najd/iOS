//
//  File 2.swift
//  
//
//  Created by Ahmed Ramy on 16/02/2022.
//

import ComposableArchitecture
import Business
import Common
import SwiftUI

// MARK: - State
public struct OnboardingState: Equatable {
  public var step: Step = .step0_InMemoryOfOurLovedOnes
  public var didFinishOnboarding: Bool = false
  public var showNextFlow: Bool = false
  public var presentationStyle: PresentationStyle = .firstLaunch
  
  public init(step: Step = .step0_InMemoryOfOurLovedOnes) {
    self.step = step
  }
}

// MARK: - Step
public extension OnboardingState {
  enum Step: Int, CaseIterable, Comparable, Equatable, Codable, Identifiable {
    // MARK: - Memories & Disclaimers Starts
    case step0_InMemoryOfOurLovedOnes
    case step00_ThisWorkIsSadaqaForAllOfUs
    // MARK: - Memories & Disclaimers Ends
    
    // MARK: - Story of You Starts
    case step1_Wakeup
    case step2_YouDontRemember
    case step3_YouAreBetterThanThis
    case step4_DoNotListenToHimHeIsNotYourFriend
    case step5_TryToRememberYourSelf
    case step6_WakeupMuslim
    case step7_RememberAllah
    case step8_RememberWhoYouAreAndWhereYouBelong
    case step9_RememberHowYouGetThere
    case step10_KnowYourWeapons
    case step11_TheRoadIsLongAndUnforgiving
    case step12_YouMustBecomeAMuslim
    case step13_Rise
    // MARK: - Story of You Ends
    
    // MARK: - Walkthrough Starts
    case step14_Prayer
    case step15_Azkar
    case step16_Rewards
    case step17_Dashboard
    case step18_DashboardInsight
    case step19_Calendar
    case step20_Settings
    // MARK: - Walkthrough Ends
    
    // MARK: - Permissions Start
//    case step21_LocationPermission
    // MARK: - Permission Ends
    
    // MARK: - End of Onboarding Starts
    case step22_UntilWeMeetAgain
    // MARK: - End of Onboarding Ends
    
    public var id: Int {
      self.rawValue
    }
    
    var isFirstStep: Bool { self == Step.allCases.first }
    var isLastStep: Bool { self == Step.allCases.last }
    
    var isStoryStep: Bool {
      (Self.step0_InMemoryOfOurLovedOnes ... Self.step13_Rise).contains(self)
    }
    
    var isWalkthroughStep: Bool {
      (Self.step14_Prayer ... Self.step20_Settings).contains(self)
    }
    
    var isPermissionStep: Bool {
      (Self.step22_UntilWeMeetAgain ... Self.step22_UntilWeMeetAgain).contains(self)
    }
    
    mutating func next() {
      self = Self(rawValue: self.rawValue + 1) ?? Self.allCases.last!
    }
    
    mutating func previous() {
      self = Self(rawValue: self.rawValue - 1) ?? Self.allCases.first!
    }
    
    public static func < (lhs: OnboardingState.Step, rhs: OnboardingState.Step) -> Bool {
      lhs.rawValue < rhs.rawValue
    }
  }
}

// MARK: - Presentation Style
public extension OnboardingState {
  enum PresentationStyle {
    case firstLaunch
  }
}

// MARK: - Action
public enum OnboardingAction: Equatable {
  case onAppear
  case delegate(DelegateAction)
  case nextStep
  case delayedNextStep
  case previousStep
  case getStarted
}

public extension OnboardingAction {
  enum DelegateAction {
    case getStarted
  }
}

// MARK: - Environment
public struct OnboardingEnvironment { public init() { } }

// MARK: - Reducer
public let onboardingReducer = Reducer<
  OnboardingState,
  OnboardingAction,
  CoreEnvironment<OnboardingEnvironment>
> { state, action, env in
  switch action {
    case .onAppear:
      state.step = env.cache().fetch(OnboardingState.Step.self, for: .onboardingStep) ?? .step0_InMemoryOfOurLovedOnes
      state.didFinishOnboarding = env.cache().fetch(Bool.self, for: .didCompleteOnboarding) ?? false
      return state.step.isFirstStep
      ? Effect(value: .delayedNextStep)
        .delay(for: 4, scheduler: env.mainQueue.animation())
        .eraseToEffect()
        .cancellable(id: DelayedNextStepId())
      : .none
    case .nextStep, .delayedNextStep:
      state.step.next()
      return env
        .cache()
        .asyncSave(state.step, for: .onboardingStep)
        .fireAndForget()
    case .previousStep:
      state.step.previous()
    case .delegate(.getStarted):
      withAnimation(.easeInOut(duration: 0.65)) {
        state.didFinishOnboarding = true
      }
      
      withAnimation(.spring().delay(0.65)) {
        state.showNextFlow = true
      }
      
      return .merge(
        env
          .cache()
          .asyncSave(true, for: .didCompleteOnboarding)
          .fireAndForget(),
        .cancel(id: DelayedNextStepId())
      )
    case .getStarted:
      return .init(value: .delegate(.getStarted))
  }
  
  return .none
}

extension CacheManager {
  public func asyncSave<T: Codable>(_ value: T, for key: StorageKey) -> Effect<Never, Never> {
    .fireAndForget { [weak self] in
      self?.save(value, for: key)
    }
  }
}

private struct DelayedNextStepId: Hashable {}
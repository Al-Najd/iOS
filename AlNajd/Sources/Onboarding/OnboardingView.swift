//
//  OnboardingView.swift
//  
//
//  Created by Ahmed Ramy on 16/02/2022.
//

import ComposableArchitecture
import SwiftUI
import DesignSystem
import Utils

public struct OnboardingView: View {
  let store: Store<OnboardingState, OnboardingAction>
  @ObservedObject var viewStore: ViewStore<ViewState, OnboardingAction>
  
  public init(store: Store<OnboardingState, OnboardingAction>) {
    self.store = store
    self.viewStore = ViewStore(self.store.scope(state: ViewState.init))
  }
  
  struct ViewState: Equatable {
    let isNextButtonVisible: Bool
    let step: OnboardingState.Step
    
    init(onboardingState state: OnboardingState) {
      self.isNextButtonVisible = state.step != OnboardingState.Step.allCases.first && state.step != OnboardingState.Step.allCases.last
      self.step = state.step
    }
  }
  
  public var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .bottom) {
        VStack(alignment: .center, spacing: .p16) {
          Spacer()
          Group {
            ForEach(OnboardingState.Step.allCases) { step in
              if step == viewStore.step {
                step.view
              }
            }
          }.transition(
            AnyTransition.asymmetric(
              insertion: .offset(x: 0, y: 50),
              removal: .offset(x: 0, y: -50)
            )
              .combined(with: .opacity)
          )
          
          Group {
            Spacer()
            HStack {
              if viewStore.step > OnboardingState.Step.step00_ThisWorkIsSadaqaForAllOfUs {
                
                if viewStore.step != OnboardingState.Step.allCases.last {
                  Button(action: {
                    withAnimation {
                      viewStore.send(.previousStep)
                    }
                  }, label: {
                    Image(systemName: viewStore.step.previousButtonIcon)
                      .frame(width: 80, height: 80)
                      .background(
                        viewStore.step.previousButtonColor.dark
                      )
                      .foregroundColor(
                        viewStore.step.previousButtonColor.light
                      )
                      .shadow(
                        color: viewStore.step.previousButtonColor.light,
                        radius: 10
                      )
                      .font(.system(size: .p32))
                      .clipShape(
                        Circle()
                      )
                      .shadow(
                        color: viewStore.step.previousButtonColor.light,
                        radius: 50
                      )
                  })
                  
                  Spacer()
                }
              }
              
              if viewStore.step != .step0_InMemoryOfOurLovedOnes {
                if viewStore.step != OnboardingState.Step.allCases.last {
                  Button(action: {
                    withAnimation {
                      viewStore.send(.nextStep)
                    }
                  }, label: {
                    Image(systemName: viewStore.step.nextButtonIcon)
                      .frame(width: 80, height: 80)
                      .background(
                        viewStore.step.nextButtonColor.dark
                      )
                      .foregroundColor(
                        viewStore.step.nextButtonColor.light
                      )
                      .shadow(
                        color: viewStore.step.nextButtonColor.light,
                        radius: 10
                      )
                      .font(.system(size: .p32))
                      .clipShape(
                        Circle()
                      )
                      .shadow(
                        color: viewStore.step.nextButtonColor.light,
                        radius: 50
                      )
                  })
                } else {
                  Button(action: {
                    withAnimation {
                      viewStore.send(.nextStep)
                    }
                  }, label: {
                    Image(systemName: "arrow.up")
                      .frame(width: 80, height: 80)
                      .background(
                        viewStore.step.nextButtonColor.dark
                      )
                      .foregroundColor(
                        viewStore.step.nextButtonColor.light
                      )
                      .shadow(
                        color: viewStore.step.nextButtonColor.light,
                        radius: 10
                      )
                      .font(.system(size: .p32))
                      .clipShape(
                        Circle()
                      )
                      .shadow(
                        color: viewStore.step.nextButtonColor.light,
                        radius: 50
                      )
                  })
                }
              }
            }
          }
        }
      }
      .padding()
      .transition(
        AnyTransition.asymmetric(
          insertion: .offset(x: 0, y: 50),
          removal: .offset(x: 0, y: 50)
        )
          .combined(with: .opacity)
      )
      .fill()
    }
    .onAppear { self.viewStore.send(.onAppear) }
    .background(
      Color
        .black
        .ignoresSafeArea()
    )
    .stay(.light)
  }
}

// MARK: - Steps' View
extension OnboardingState.Step {
  var nextButtonIcon: String {
    switch self {
      case .step0_InMemoryOfOurLovedOnes,
          .step00_ThisWorkIsSadaqaForAllOfUs:
        return "heart.fill"
      default:
        return "arrow.forward"
    }
  }
  
  var previousButtonIcon: String {
    "arrow.backward"
  }
  
  var nextButtonColor: BrandColor {
    switch self {
      case .step00_ThisWorkIsSadaqaForAllOfUs:
        return Color.danger
      default:
        return Color.primary
    }
  }
  
  var previousButtonColor: BrandColor {
    switch self {
      case .step1_Wakeup:
        return Color.danger
      default:
        return Color.secondary
    }
  }
}

extension OnboardingState.Step {
  @ViewBuilder
  var view: some View {
    switch self {
      case .step0_InMemoryOfOurLovedOnes:
        buildStep0View()
      case .step00_ThisWorkIsSadaqaForAllOfUs:
        buildStep00View()
      case .step1_Wakeup:
        buildStep1View()
      case .step2_YouDontRemember:
        buildStep2View()
      case .step3_YouAreBetterThanThis:
        buildStep3View()
      case .step4_DoNotListenToHimHeIsNotYourFriend:
        buildStep4View()
      case .step5_TryToRememberYourSelf:
        buildStep5View()
      case .step6_WakeupMuslim:
        buildStep6View()
      case .step7_RememberAllah:
        buildStep7View()
      case .step8_RememberWhoYouAreAndWhereYouBelong:
        buildStep8View()
      case .step9_RememberHowYouGetThere:
        buildStep9View()
      case .step10_KnowYourWeapons:
        buildStep10View()
      case .step11_TheRoadIsLongAndUnforgiving:
        buildStep11View()
      case .step12_YouMustBecomeAMuslim:
        buildStep12View()
      case .step13_Rise:
        buildStep13View()
    }
  }
  
  func buildStep13View() -> some View {
    VStack {
      Text("Rise from your struggles, and pick your")
      +
      Text("Najd")
        .foregroundColor(.primary.darkMode)
    }
    .foregroundColor(.mono.offwhite)
    .font(.pLargeTitle.bold())
    .multilineTextAlignment(.center)
  }
  
  func buildStep12View() -> some View {
    
    (
      Text("You must become a")
      +
      Text("Muslim")
        .foregroundColor(.primary.light)
    )
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle.bold())
      .multilineTextAlignment(.center)
  }
  
  func buildStep11View() -> some View {
    VStack(spacing: .p16) {
      Text("The Road ahead is long, and unforgiving.")
        .foregroundColor(.mono.offwhite)
        
      
      Text("Not that for a dead soul")
        .foregroundColor(.mono.body)
    }
    .font(.pLargeTitle.bold())
    .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep10View() -> some View {
    Text("Know your weapons, and that you will learn them, train on them, and hopefully from Allah, you will master them")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle.bold())
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep9View() -> some View {
   Text("Remember that Islam is the only way to there now.")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle.bold())
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep8View() -> some View {
    VStack(spacing: .p24) {
      Text("Remember why you're here in this ")
      +
      Text("Dunia")
        .foregroundColor(.danger.darkMode)
      +
      Text(".")
      
      Text(" to start your Journey to your Home in ")
      +
      Text("Akhra")
        .foregroundColor(.success.light)
      +
      Text(".\n")
      
      Text("And that you're a ")
      +
      Text("Muslim")
      +
      Text(", whom ")
      +
      Text("\nAllah")
        .foregroundColor(.primary.light)
      +
      Text(" loves")
        .foregroundColor(.danger.darkMode)
      +
      Text(".")
    }
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle.bold())
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep7View() -> some View {
    (
      Text("Remember ")
      +
      Text("Allah")
        .foregroundColor(.primary.light)
      +
      Text(".")
    )
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle)
      .bold()
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep6View() -> some View {
    Text("Wake up, Muslim.")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle)
      .bold()
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep5View() -> some View {
    Text("Try to remember your self, your beautiful self, the alive one, not the current.")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle)
      .bold()
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep4View() -> some View {
    Text("And that 'thing' you listen to, is not your friend, he is an enemy, but...\nRest assured,\n for he's a weak one.")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle)
      .bold()
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep3View() -> some View {
    Text("You're better than this, than not remembering why you're here.")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle)
      .bold()
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep2View() -> some View {
    Text("You don't remember why you're here, do you?")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle)
      .bold()
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep1View() -> some View {
    Text("Wake up.")
      .foregroundColor(.mono.offwhite)
      .font(.pLargeTitle)
      .bold()
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep00View() -> some View {
    VStack(spacing: .p24) {
      Text("This work is a Sadaqa for...")
        .foregroundColor(.mono.background)
      
      Text("All Muslims")
        .foregroundColor(.mono.input)
      
      Text("Those who passed away")
        .foregroundColor(.mono.line)
      
      Text("And those who are living")
        .foregroundColor(.mono.placeholder)
      
      Text("And those who may come after")
        .foregroundColor(.mono.label)
    }
    .font(.pTitle1.bold())
    .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep0View() -> some View {
    Group {
    (
      Text("In the memory of my passed away")
        .foregroundColor(.mono.line)
      +
      Text("\nGrand Mother")
        .foregroundColor(.mono.offwhite)
        .bold()
    )
      .font(.pLargeTitle)
    
    (
      (
        Text("I ask of you to ")
        + Text("Receit ")
      )
      
      +
      
      Text("\nAl Fatihaa\n")
        .bold()
        .foregroundColor(.mono.offwhite)
      
      +
      
      (
        Text("to her\n**&**\n")
        + Text("To all our passed away closed ones.\n❤️")
      )
    )
        .foregroundColor(.mono.label)
      .font(.pTitle1)
    
    
    Text("May we reunite again with them in the highest paradise along all of those who preceeded us\n🤲")
      .font(.pTitle2)
      .bold()
      .foregroundColor(.mono.line)
    }.multilineTextAlignment(.center)
  }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
      OnboardingView(
        store: Store(
          initialState: .init(),
          reducer: onboardingReducer,
          environment: .live(OnboardingEnvironment())
        )
      )
    }
}

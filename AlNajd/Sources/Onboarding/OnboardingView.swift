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
import Common

public struct OnboardingView<Content: View>: View {
  let store: Store<OnboardingState, OnboardingAction>
  @ObservedObject var viewStore: ViewStore<ViewState, OnboardingAction>
  private let injectedView: () -> Content
  
  public init(
    store: Store<OnboardingState, OnboardingAction>,
    @ViewBuilder injectedView: @escaping () -> Content
  ) {
    self.store = store
    self.viewStore = ViewStore(self.store.scope(state: ViewState.init))
    self.injectedView = injectedView
  }
  
  struct ViewState: Equatable {
    let step: OnboardingState.Step
    let didFinishOnboarding: Bool
    let startNewFlow: Bool
    init(onboardingState state: OnboardingState) {
      self.step = state.step
      self.startNewFlow = state.showNextFlow
      self.didFinishOnboarding = state.didFinishOnboarding
    }
  }
  
  public var body: some View {
    ZStack {
      if viewStore.didFinishOnboarding {
        injectedView()
          .offset(
            y: viewStore.startNewFlow
            ? 0
            : -getScreenSize().height
          )
      }
      VStack(alignment: .center, spacing: .p16) {
        HStack {
          Spacer()
          Button(action: {
            openSettings()
          }, label: {
            Label(
              "Language".localized,
              systemImage: "character"
            )
              .scaledFont(.pHeadline, .bold)
              .foregroundColor(.mono.offwhite)
              .labelStyle(.titleAndIcon)
          })
        }
        Spacer()
        Group {
          buildStoryContent()
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
            if !viewStore.step.isLastStep && viewStore.step > OnboardingState.Step.step00_ThisWorkIsSadaqaForAllOfUs {
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
            
            if viewStore.step != .step0_InMemoryOfOurLovedOnes {
              Button(action: {
                withAnimation {
                  viewStore.send(viewStore.step.isLastStep ? .delegate(.getStarted) : .nextStep)
                }
              }, label: {
                Image(systemName: viewStore.step.nextButtonIcon)
                  .frame(width: 80, height: 80)
                  .rotationEffect(.degrees( viewStore.step.isLastStep ? -90 : 0))
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
      }.padding()
        .transition(
          AnyTransition.asymmetric(
            insertion: .offset(x: 0, y: 50),
            removal: .offset(x: 0, y: 50)
          )
            .combined(with: .opacity)
        )
        .fill()
        .offset(y: viewStore.didFinishOnboarding ? -getScreenSize().height : 0)
    }
    .onAppear { self.viewStore.send(.onAppear) }
    .background(
        (viewStore.didFinishOnboarding ? Color.clear : Color.mono.offblack)
        .ignoresSafeArea()
    )
    .stay(viewStore.step.isADarkThought ? .light : .dark)
  }
}

extension OnboardingView {
  @ViewBuilder
  func buildStoryContent() -> some View {
    ForEach(OnboardingState.Step.allCases) { step in
      if step == viewStore.step {
        step.view
      }
    }
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
  var image: String {
    switch self {
      case .step14_Prayer:
        return ImageKey.prayerWalkthrough
      case .step15_Azkar:
        return ImageKey.azkarWalkthrough
      case .step16_Rewards:
        return ImageKey.rewardsWalkthrough
      case .step17_Dashboard:
        return ImageKey.dashboardWalkthrough
      case .step18_DashboardInsight:
        return ImageKey.dashboardInsightsWalkthrough
      case .step19_Calendar:
        return ImageKey.calendarWalkthrough
      case .step20_Settings:
        return ImageKey.settingsWalkthrough
      default:
        return ""
    }
  }
}


// MARK: - Satan's Whispers Start
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
      case .step14_Prayer:
        buildStep14View()
      case .step15_Azkar:
        buildStep15View()
      case .step16_Rewards:
        buildStep16View()
      case .step17_Dashboard:
        buildStep17View()
      case .step18_DashboardInsight:
        buildStep18View()
      case .step19_Calendar:
        buildStep19View()
      case .step20_Settings:
        buildStep20View()
        //      case .step21_LocationPermission:
        //        // TODO: - Implement Location Permission Then add
        //        EmptyView()
      case .step22_UntilWeMeetAgain:
        buildStep22View()
      case .step000_ThereIsNoWayYouCanHide:
        buildStep000View()
      case .step001_PutAsMuchDistanceBetweenYouAndTheTruth:
        buildStep001View()
      case .step002_ItChangesNothing:
        buildStep002View()
      case .step003_PretendToBeEverythingYouAreNot:
        buildStep003View()
      case .step004_ASheikh:
        buildStep004View()
      case .step005_AGoodPerson:
        buildStep005View()
      case .step006_AMuslim:
        buildStep006View()
      case .step007_ButThereIsOneUnavoidableTruthThatYouWillNeverEscape:
        buildStep007View()
      case .step008_YouCanNotChange:
        buildStep008View()
      case .step009_YouWillAlwaysBe:
        buildStep009View()
      case .step0010_ASinner:
        buildStep010View()
    }
  }
  
  func buildStep000View() -> some View {
    VStack {
        Text("😈")
        Text("There is no where you can hide, Muslim".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep001View() -> some View {
      VStack {
          Text("😈")
          Text("Put as much distance between you and the truth as you want".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep002View() -> some View {
    VStack {
        Text("😈")
        Text("It changes nothing".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep003View() -> some View {
    VStack {
        Text("😈")
      Text("Pretend to be everything that you're not.".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
    
    func buildStep004View() -> some View {
        VStack {
            Text("😈")
            Text("A Good Person".localized)
        }
        .foregroundColor(.mono.offwhite)
        .scaledFont(.pLargeTitle, .bold)
        .multilineTextAlignment(.center)
    }
    
    func buildStep005View() -> some View {
        VStack {
            Text("😈")
            Text("A Sheikh".localized)
        }.foregroundColor(.mono.offwhite)
            .scaledFont(.pLargeTitle, .bold)
            .multilineTextAlignment(.center)
    }
    
    func buildStep006View() -> some View {
        VStack {
            Text("😈")
            Text("A Mo'men".localized)
        }.foregroundColor(.mono.offwhite)
            .scaledFont(.pLargeTitle, .bold)
            .multilineTextAlignment(.center)
    }
    
    func buildStep007View() -> some View {
        VStack {
            Text("😈")
            Text("But there is one unavoidable truth that you'll never escape".localized)
        }
        .foregroundColor(.mono.offwhite)
        .scaledFont(.pLargeTitle, .bold)
        .multilineTextAlignment(.center)
    }
    
    func buildStep008View() -> some View {
        VStack {
            Text("😈")
            Text("You can not change...".localized)
        }
        .foregroundColor(.mono.offwhite)
        .scaledFont(.pLargeTitle, .bold)
        .multilineTextAlignment(.center)
    }
    
    func buildStep009View() -> some View {
        VStack {
            Text("😈")
            Text("You will always be...".localized)
        }
        .foregroundColor(.mono.offwhite)
        .scaledFont(.pLargeTitle, .bold)
        .multilineTextAlignment(.center)
    }
    
    func buildStep010View() -> some View {
        VStack {
            Text("😈")
            Text("A Sinner".localized)
        }
        .foregroundColor(.mono.offwhite)
        .scaledFont(.pLargeTitle, .bold)
        .multilineTextAlignment(.center)
    }
}

// MARK: - Satan's Whispers End
extension OnboardingState.Step {
  
  func buildStep22View() -> some View {
    Group {
      Text("And now...\n\n\n\n".localized)
      +
      Text("Welcome to ".localized)
      +
      Text("Al Najd".localized)
        .foregroundColor(.primary.default)
      
      Text("We hope we may be able to help you, even if by something so little".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep21View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      ).resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("Don't like the colors? Font is too small? Got a permission you gave us before\n".localized)
      Text("but now you're not comfortable with it anymore?".localized)
      Text("All of this and more (in the future In Shaa Allah) will be available from the Settings".localized)
    }.foregroundColor(.mono.offwhite)
      .scaledFont(.pBody, .bold)
      .multilineTextAlignment(.center)
  }
  
  func buildStep20View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      ).resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("Don't like the colors? Font is too small? Got a permission you gave us before\n".localized)
      Text("but now you're not comfortable with it anymore?".localized)
      Text("All of this and more (in the future In Shaa Allah) will be available from the Settings".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pBody, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep19View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      ).resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("Got some day you'd like to revisit?".localized)
      Text("You can drag the Calendar from above".localized)
      Text("And revisit your older self to see what insight did you get that day or your work".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pBody, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep18View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("The Dashboard is also able to give insights".localized)
      Text("Like encourage you, praise you, give you some warning for missing critical deeds".localized)
      Text("Or basically suggest an act combined with something else".localized)
      Text(
        "This is not done on any server, your data and actions are personal, and we intend to keep it that way".localized
      )
        .scaledFont(.pBody)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pBody, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep17View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("And our greatest feature ever (till now)".localized)
      Text("The Dashboard".localized)
      Text("Where you will find how did you do during a time period (now its static to 7 days)".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pBody, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep16View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("And since it's in the nature of mankind to be materalistic".localized)
      Text("We took an effort to find what are the benefits of most of the deeds here".localized)
      Text("By the way we need help with this, so if want to help, please reach me out through the settings page".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pBody, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep15View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("Azkar are the fort, your defense, and your offense".localized)
      
      Text("Staying true to it will not only help you reach your destination".localized)
      
      Text("But make your journey full of blessings, unexpected happiness and lots of peace".localized)
    }.foregroundColor(.mono.offwhite)
      .scaledFont(.pBody, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep14View() -> some View {
    VStack {
      Image(
        image,
        bundle: .commonBundle
      )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .shadow(color: .secondary.darkMode, radius: 25, x: 0, y: 0)
      
      Text("Since Prayer is the column of Deen, we made it easy for you to keep\n".localized)
      +
      Text("Track of it by just swiping from the side".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pBody, .bold)
    .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep13View() -> some View {
    VStack {
      Text("Rise from your struggles, and pick ".localized)
      +
      Text("Your Najd".localized)
        .foregroundColor(.primary.darkMode)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
  
  func buildStep12View() -> some View {
    
    (
      Text("It must become a ".localized)
      +
      Text("Lighter".localized)
        .foregroundColor(.primary.light)
      +
      Text(".".localized)
    )
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  func buildStep11View() -> some View {
    VStack(spacing: .p16) {
      Text("The Road ahead is long, and unforgiving.".localized)
        .foregroundColor(.mono.offwhite)
      
      Text("Not that for a dark heart".localized)
        .foregroundColor(.mono.input)
    }
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep10View() -> some View {
    Text("Know your weapons, and that you will learn them, train on them, and hopefully from Allah, you will master them".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep9View() -> some View {
    Text("Remember that Islam is the only way to there now.".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep8View() -> some View {
    VStack(spacing: .p24) {
      Text("Remember why you're here in this ".localized)
      +
      Text("Dunia".localized)
        .foregroundColor(.danger.darkMode)
      +
      Text(".".localized)
      
      Text(" to start your Journey to your Home in ".localized)
      +
      Text("Akhra".localized)
        .foregroundColor(.success.light)
      +
      Text(".\n".localized)
      
      Text("And that you're a ".localized)
      +
      Text("Muslim".localized)
      +
      Text(", whom ".localized)
      +
      Text("\nAllah".localized)
        .foregroundColor(.primary.light)
      +
      Text(" loves".localized)
        .foregroundColor(.danger.darkMode)
      +
      Text(".".localized)
    }
    .foregroundColor(.mono.offwhite)
    .scaledFont(.pLargeTitle, .bold)
    .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep7View() -> some View {
    (
      Text("Remember ".localized)
      +
      Text("Allah".localized)
        .foregroundColor(.primary.light)
      +
      Text(".".localized)
    )
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep6View() -> some View {
    Text("Wake up, Muslim.".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep5View() -> some View {
    Text("Try to remember your self, your beautiful self, the alive one, not the current.".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep4View() -> some View {
    Text("And that 'thing' you listen to, is not your friend, he is an enemy, but...\nRest assured,\n for he's a weak one.".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep3View() -> some View {
    Text("You're better than this, than not remembering why you're here.".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep2View() -> some View {
    Text("You don't remember why you're here, do you?".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep1View() -> some View {
    Text("Wake up.".localized)
      .foregroundColor(.mono.offwhite)
      .scaledFont(.pLargeTitle, .bold)
      .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep00View() -> some View {
    VStack(spacing: .p24) {
      Text("This work is a Sadaqa for...".localized)
        .foregroundColor(.mono.background)
      
      Text("All Muslims".localized)
        .foregroundColor(.mono.input)
      
      Text("Those who passed away".localized)
        .foregroundColor(.mono.input)
      
      Text("And those who are living".localized)
        .foregroundColor(.mono.input)
      
      Text("And those who may come after".localized)
        .foregroundColor(.mono.input)
    }
    .scaledFont(.pTitle1, .bold)
    .multilineTextAlignment(.center)
  }
  
  @ViewBuilder
  func buildStep0View() -> some View {
    Group {
      Group {
        Text("In the memory of my passed away".localized)
          .foregroundColor(.mono.input)
        
        Text("\nGrand Mother".localized)
          .foregroundColor(.mono.offwhite)
          .fontWeight(.bold)
      }
      .scaledFont(.pTitle1)
      
      Group {
        Text("I ask of you to ".localized)
        
        Text("Receit ".localized)
        
        Text("Al Fatihaa".localized)
          .scaledFont(.pTitle1, .bold)
          .foregroundColor(.mono.offwhite)
        
        Text("to her".localized)
        Text("And to all our passed away closed ones.\n❤️".localized)
      }
      .foregroundColor(.mono.input)
      .scaledFont(.pTitle1)
      
      
      Text("May we reunite again with them in the highest paradise along all of those who preceeded us\n🤲".localized)
        .scaledFont(.pHeadline, .bold)
        .foregroundColor(.mono.line)
    }.multilineTextAlignment(.center)
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView(
      store: Store(
        initialState: .init(step: .step22_UntilWeMeetAgain),
        reducer: onboardingReducer,
        environment: .live(OnboardingEnvironment())
      )
    )
    {
      Text("You made it!")
        .foregroundColor(.mono.offwhite)
    }
  }
}

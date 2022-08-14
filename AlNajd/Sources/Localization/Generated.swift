// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// جدتي
  public static let grandMother = L10n.tr("Localizables", "\nGrand Mother", fallback: #"جدتي"#)
  ///  لبدء رحلتك إلى منزلك في 
  public static let toStartYourJourneyToYourHomeIn = L10n.tr("Localizables", " to start your Journey to your Home in ", fallback: #" لبدء رحلتك إلى منزلك في "#)
  /// , و %@
  public static func andDay(_ p1: Any) -> String {
    return L10n.tr("Localizables", ", and day", String(describing: p1), fallback: #", و %@"#)
  }
  /// , ممن 
  public static let whom = L10n.tr("Localizables", ", whom ", fallback: #", ممن "#)
  /// ركعتان بعد العشاء
  public static let _2RaqaatAfterAlAishaa = L10n.tr("Localizables", "2 Raqaat After Al Aishaa", fallback: #"ركعتان بعد العشاء"#)
  /// ركعات بعد المغرب
  public static let _2RaqaatAfterAlMaghrib = L10n.tr("Localizables", "2 Raqaat After Al Maghrib", fallback: #"ركعات بعد المغرب"#)
  /// ركعتان بعد الظهر
  public static let _2RaqaatAfterDuhr = L10n.tr("Localizables", "2 Raqaat After Duhr", fallback: #"ركعتان بعد الظهر"#)
  /// ركعتان قبل الفچر
  public static let _2RaqaatBeforeFajr = L10n.tr("Localizables", "2 Raqaat Before Fajr", fallback: #"ركعتان قبل الفچر"#)
  /// ٣٠ استغفار كل ٢٥ دقيقة
  public static let _30xEstigphar25Mins = L10n.tr("Localizables", "30x Estigphar / 25 mins", fallback: #"٣٠ استغفار كل ٢٥ دقيقة"#)
  /// ٤ ركعات قبل الظهر
  public static let _4RaqaatBeforeDuhr = L10n.tr("Localizables", "4 Raqaat Before Duhr", fallback: #"٤ ركعات قبل الظهر"#)
  /// يوما مليئ بالاعمال الطيبة في انتظارك!
  public static let aDayFullOfBlessingsIsAwaitingYourDeeds = L10n.tr("Localizables", "A day full of blessings is awaiting your deeds!", fallback: #"يوما مليئ بالاعمال الطيبة في انتظارك!"#)
  /// كشخص صالح
  public static let aGoodPerson = L10n.tr("Localizables", "A Good Person", fallback: #"كشخص صالح"#)
  /// كمؤمن
  public static let aMoMen = L10n.tr("Localizables", "A Mo'men", fallback: #"كمؤمن"#)
  /// كشيخ
  public static let aSheikh = L10n.tr("Localizables", "A Sheikh", fallback: #"كشيخ"#)
  /// عاصي
  public static let aSinner = L10n.tr("Localizables", "A Sinner", fallback: #"عاصي"#)
  /// العصر
  public static let aasr = L10n.tr("Localizables", "Aasr", fallback: #"العصر"#)
  /// إمكانية الوصول
  public static let accessibility = L10n.tr("Localizables", "Accessibility", fallback: #"إمكانية الوصول"#)
  /// عشاء
  public static let aishaa = L10n.tr("Localizables", "Aishaa", fallback: #"عشاء"#)
  /// أخرة
  public static let akhra = L10n.tr("Localizables", "Akhra", fallback: #"أخرة"#)
  /// الفاتحة
  public static let alFatihaa = L10n.tr("Localizables", "Al Fatihaa", fallback: #"الفاتحة"#)
  /// النچد
  public static let alNajd = L10n.tr("Localizables", "Al Najd", fallback: #"النچد"#)
  /// ((وَهَدَيْنَاهُ النَّجْدَيْنِ))
  public static let alNajdAya = L10n.tr("Localizables", "Al Najd Aya", fallback: #"((وَهَدَيْنَاهُ النَّجْدَيْنِ))"#)
  /// اي الطريقين (طريق الخير, وطريق الشر).
  public static let alNajdTranslation = L10n.tr("Localizables", "Al Najd Translation", fallback: #"اي الطريقين (طريق الخير, وطريق الشر)."#)
  /// الَّذِينَ آمَنُوا وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ ۗ
  public static let alRa3d28 = L10n.tr("Localizables", "al_ra3d_28", fallback: #"الَّذِينَ آمَنُوا وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ ۗ"#)
  /// جميع المسلمين
  public static let allMuslims = L10n.tr("Localizables", "All Muslims", fallback: #"جميع المسلمين"#)
  /// كل هذا وأكثر (في المستقبل إن شاء الله) سوف تكون متاحة من إعدادات
  public static let allOfThisAndMoreInTheFutureInShaaAllahWillBeAvailableFromTheSettings = L10n.tr("Localizables", "All of this and more (in the future In Shaa Allah) will be available from the Settings", fallback: #"كل هذا وأكثر (في المستقبل إن شاء الله) سوف تكون متاحة من إعدادات"#)
  /// الله
  public static let allah = L10n.tr("Localizables", "Allah", fallback: #"الله"#)
  /// كان حقا علي الله ان يرضيك .
  public static let allahMustSatisfyYou = L10n.tr("Localizables", "Allah Must Satisfy you", fallback: #"كان حقا علي الله ان يرضيك ."#)
  /// متاح
  public static let allowed = L10n.tr("Localizables", "Allowed", fallback: #"متاح"#)
  /// ولدينا أعظم ميزة من أي وقت مضى (حتى الآن)
  public static let andOurGreatestFeatureEverTillNow = L10n.tr("Localizables", "And our greatest feature ever (till now)", fallback: #"ولدينا أعظم ميزة من أي وقت مضى (حتى الآن)"#)
  /// وإعادة النظر في نفسك القديمة لمعرفة ما الترجيحات اللتي حصلت عليها ذلك اليوم
  public static let andRevisitYourOlderSelfToSeeWhatInsightDidYouGetThatDayOrYourWork = L10n.tr("Localizables", "And revisit your older self to see what insight did you get that day or your work", fallback: #"وإعادة النظر في نفسك القديمة لمعرفة ما الترجيحات اللتي حصلت عليها ذلك اليوم"#)
  /// وبما أنه في طبيعة البشرية أن تكون مادية
  public static let andSinceItSInTheNatureOfMankindToBeMateralistic = L10n.tr("Localizables", "And since it's in the nature of mankind to be materalistic", fallback: #"وبما أنه في طبيعة البشرية أن تكون مادية"#)
  /// و اسري بهدي الله و نفسك 
  public static let andTakeYourselfWithAllahSSWTGuidance = L10n.tr("Localizables", "And take yourself with Allah's (SWT) guidance ", fallback: #"و اسري بهدي الله و نفسك "#)
  /// وأنك 
  public static let andThatYouReA = L10n.tr("Localizables", "And that you're a ", fallback: #"وأنك "#)
  /// وأولئك الذين يعيشون
  public static let andThoseWhoAreLiving = L10n.tr("Localizables", "And those who are living", fallback: #"وأولئك الذين يعيشون"#)
  /// وأولئك الذين قد يأتون بعد رحيلنا
  public static let andThoseWhoMayComeAfter = L10n.tr("Localizables", "And those who may come after", fallback: #"وأولئك الذين قد يأتون بعد رحيلنا"#)
  /// و %@ بركات و معززات اخري
  public static func andVarOtherBlessingsAndBuffs(_ p1: Any) -> String {
    return L10n.tr("Localizables", "And var other blessings and Buffs...", String(describing: p1), fallback: #"و %@ بركات و معززات اخري"#)
  }
  /// الأذكار
  public static let azkar = L10n.tr("Localizables", "Azkar", fallback: #"الأذكار"#)
  /// اذكار المساء
  public static let azkarAlMasaa = L10n.tr("Localizables", "Azkar Al-Masaa", fallback: #"اذكار المساء"#)
  /// اذكار الصباح
  public static let azkarAlSabah = L10n.tr("Localizables", "Azkar Al-Sabah", fallback: #"اذكار الصباح"#)
  /// الأذكار هي حصنك، دفاعك، وهجومك 
  public static let azkarAreTheFortYourDefenseAndYourOffense = L10n.tr("Localizables", "Azkar are the fort, your defense, and your offense", fallback: #"الأذكار هي حصنك، دفاعك، وهجومك "#)
  /// كن 
  public static let beYourOwn = L10n.tr("Localizables", "Be your own ", fallback: #"كن "#)
  /// قبل 
  public static let beforeThe = L10n.tr("Localizables", "before the ", fallback: #"قبل "#)
  /// بارك الله لك!
  public static let blessYou = L10n.tr("Localizables", "Bless you", fallback: #"بارك الله لك!"#)
  /// ولكن جعل رحلتك كاملة من البركات والسعادة غير متوقعة والكثير من الراحة النفسية
  public static let butMakeYourJourneyFullOfBlessingsUnexpectedHappinessAndLotsOfPeace = L10n.tr("Localizables", "But make your journey full of blessings, unexpected happiness and lots of peace", fallback: #"ولكن جعل رحلتك كاملة من البركات والسعادة غير متوقعة والكثير من الراحة النفسية"#)
  /// لكن الآن أنت لست مرتاحة معها بعد الآن؟
  public static let butNowYouReNotComfortableWithItAnymore = L10n.tr("Localizables", "but now you're not comfortable with it anymore?", fallback: #"لكن الآن أنت لست مرتاحة معها بعد الآن؟"#)
  /// ولكن, هناك امر واقع لا يمكنك تجاهلها
  public static let butThereIsOneUnavoidableTruthThatYouLlNeverEscape = L10n.tr("Localizables", "But there is one unavoidable truth that you'll never escape", fallback: #"ولكن, هناك امر واقع لا يمكنك تجاهلها"#)
  /// بتعلمك اكثر عن 
  public static let byLearningAboutTheBenefitsOf = L10n.tr("Localizables", "By learning about the benefits of", fallback: #"بتعلمك اكثر عن "#)
  /// بالمناسبة نحن بحاجة إلى مساعدة في هذا، فإن كنت ترغب في مساعدتنا، يرجى ابلاغي
  public static let byTheWayWeNeedHelpWithThisSoIfWantToHelpPleaseReachMeOutThroughTheSettingsPage = L10n.tr("Localizables", "By the way we need help with this, so if want to help, please reach me out through the settings page", fallback: #"بالمناسبة نحن بحاجة إلى مساعدة في هذا، فإن كنت ترغب في مساعدتنا، يرجى ابلاغي"#)
  /// عدد السعرات الحرارية: %@
  public static func categoryCalories(_ p1: Any) -> String {
    return L10n.tr("Localizables", "category_calories", String(describing: p1), fallback: #"عدد السعرات الحرارية: %@"#)
  }
  /// وصف الفئة: %@
  public static func categoryDescription(_ p1: Any) -> String {
    return L10n.tr("Localizables", "category_description", String(describing: p1), fallback: #"وصف الفئة: %@"#)
  }
  /// اسم الفئة: %@
  public static func categoryName(_ p1: Any) -> String {
    return L10n.tr("Localizables", "category_name", String(describing: p1), fallback: #"اسم الفئة: %@"#)
  }
  /// اختر 
  public static let choose = L10n.tr("Localizables", "Choose ", fallback: #"اختر "#)
  /// بياناتي
  public static let dashboard = L10n.tr("Localizables", "Dashboard", fallback: #"بياناتي"#)
  /// ممنوع
  public static let denied = L10n.tr("Localizables", "Denied", fallback: #"ممنوع"#)
  /// لا تحب الألوان؟ الخط صغير جدا؟ حصلت على إذن أعطيتنا إياه من قبل
  /// 
  public static let donTLikeTheColorsFontIsTooSmallGotAPermissionYouGaveUsBefore = L10n.tr("Localizables", "Don't like the colors? Font is too small? Got a permission you gave us before\n", fallback: #"لا تحب الألوان؟ الخط صغير جدا؟ حصلت على إذن أعطيتنا إياه من قبل\n"#)
  /// الضحي
  public static let duha = L10n.tr("Localizables", "Duha", fallback: #"الضحي"#)
  /// الظهر
  public static let duhr = L10n.tr("Localizables", "Duhr", fallback: #"الظهر"#)
  /// الدنيا
  public static let dunia = L10n.tr("Localizables", "Dunia", fallback: #"الدنيا"#)
  /// هذا الإيمال غير صالح.
  public static let emailNotValid = L10n.tr("Localizables", "email_not_valid", fallback: #"هذا الإيمال غير صالح."#)
  /// اعتنق التغيير
  public static let embraceTheChange = L10n.tr("Localizables", "Embrace the Change", fallback: #"اعتنق التغيير"#)
  /// استغفر الله
  public static let estigphar = L10n.tr("Localizables", "estigphar", fallback: #"استغفر الله"#)
  /// الفچر
  public static let fajr = L10n.tr("Localizables", "Fajr", fallback: #"الفچر"#)
  /// الفرائض
  public static let faraaid = L10n.tr("Localizables", "Faraaid", fallback: #"الفرائض"#)
  /// ال%@ لا يمكن ان يكون فارغا.
  public static func fieldCantBeEmpty(_ p1: Any) -> String {
    return L10n.tr("Localizables", "field_cant_be_empty", String(describing: p1), fallback: #"ال%@ لا يمكن ان يكون فارغا."#)
  }
  /// سهولة الكتابة
  public static let fontAccessibility = L10n.tr("Localizables", "Font Accessibility", fallback: #"سهولة الكتابة"#)
  /// Localizables.strings
  ///   Proba B.V.
  /// 
  ///   Created by Ahmed Ramy on 10/1/20.
  /// //  Copyright © 2020 Proba B.V. All rights reserved.
  ///   Copyright © 2020 Proba B.V. All rights reserved.
  public static let genericError = L10n.tr("Localizables", "generic_error", fallback: #"حدث خطأ ما..."#)
  /// بينا نبدأ!
  public static let getStarted = L10n.tr("Localizables", "Get Started", fallback: #"بينا نبدأ!"#)
  /// إعدادات التطبيق
  public static let goToTheIOSSettingsPage = L10n.tr("Localizables", "Go to the iOS Settings Page", fallback: #"إعدادات التطبيق"#)
  /// احسنت!
  public static let goodJob = L10n.tr("Localizables", "Good Job!", fallback: #"احسنت!"#)
  /// هل لديك يوم تود إعادة النظر فيه؟
  public static let gotSomeDayYouDLikeToRevisit = L10n.tr("Localizables", "Got some day you'd like to revisit?", fallback: #"هل لديك يوم تود إعادة النظر فيه؟"#)
  /// ردود الفعل اللمسية
  public static let hapticFeedback = L10n.tr("Localizables", "Haptic Feedback", fallback: #"ردود الفعل اللمسية"#)
  /// انتبه!
  public static let headsUp = L10n.tr("Localizables", "Heads up!", fallback: #"انتبه!"#)
  /// مساعدتك 
  public static let helpYou = L10n.tr("Localizables", "Help you ", fallback: #"مساعدتك "#)
  /// لافتة: عندما تختار تاريخا, ستستطيع رؤية انجازاتك في هذا التاريخ!
  public static let hintChoosingADateAllowsYouToRevisitYourAchievementsAtThatDate = L10n.tr("Localizables", "Hint: Choosing a Date allows you to revisit your achievements at that date!", fallback: #"لافتة: عندما تختار تاريخا, ستستطيع رؤية انجازاتك في هذا التاريخ!"#)
  /// خسارة, لكن ماذال معانا وقت, بينا نجتهد هذا الأسبوع!
  public static let hmmSadButWeStillHaveAChanceLetSPrayHardThisWeek = L10n.tr("Localizables", "Hmm, sad, but we still have a chance! let's pray hard this week!", fallback: #"خسارة, لكن ماذال معانا وقت, بينا نجتهد هذا الأسبوع!"#)
  /// ما رأيك, ان نتخذه تحدي لأنفسنا ان نملئ هذا الأسبوع بأعمال جميلة؟ ألن يكون هذا رائعا؟
  public static let howAboutWeMakeItAChallengeToUsToPopulateThisWithGreatDeedsWouldnTThatBeAwesome = L10n.tr("Localizables", "How about we make it a challenge to us to populate this with great deeds? wouldn't that be awesome?", fallback: #"ما رأيك, ان نتخذه تحدي لأنفسنا ان نملئ هذا الأسبوع بأعمال جميلة؟ ألن يكون هذا رائعا؟"#)
  /// ((إِنْ أُرِيدُ إِلَّا الْإِصْلَاحَ مَا اسْتَطَعْتُ ۚ وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ ۚ عَلَيْهِ تَوَكَّلْتُ وَإِلَيْهِ أُنِيبُ))
  /// — سورة هود: ٨٨
  public static let hud88 = L10n.tr("Localizables", "hud-88", fallback: #"((إِنْ أُرِيدُ إِلَّا الْإِصْلَاحَ مَا اسْتَطَعْتُ ۚ وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ ۚ عَلَيْهِ تَوَكَّلْتُ وَإِلَيْهِ أُنِيبُ))\n— سورة هود: ٨٨"#)
  /// أطلب منكم أن 
  public static let iAskOfYouTo = L10n.tr("Localizables", "I ask of you to ", fallback: #"أطلب منكم أن "#)
  /// إن كانت سنة الفچر خيرا من الدنيا و ما فيها, فما بالك بفرضها؟
  public static let ifTheSunnahWasBetterThanAllOfThatIsGoodOnLifeWhatDoYouThinkTheFajrIs = L10n.tr("Localizables", "If the Sunnah was better than all of that is good on life, what do you think the Fajr is?", fallback: #"إن كانت سنة الفچر خيرا من الدنيا و ما فيها, فما بالك بفرضها؟"#)
  /// في ذكرى وفاة
  public static let inTheMemoryOfMyPassedAway = L10n.tr("Localizables", "In the memory of my passed away", fallback: #"في ذكرى وفاة"#)
  /// يتيح لك زيادة او إنقاص الكلام المكتوب لسهولة رؤيته
  public static let increasesOrDecreasesTheFontSizeForBetterReadingExperienceWithoutStrainingYourEyeVeryMuch = L10n.tr("Localizables", "Increases or decreases the font size for better reading experience without straining your eye very much", fallback: #"يتيح لك زيادة او إنقاص الكلام المكتوب لسهولة رؤيته"#)
  /// غير كافي
  public static let insufficient = L10n.tr("Localizables", "Insufficient", fallback: #"غير كافي"#)
  /// الآن اصبح يصلي معه السنة و النافلة!
  public static let isNowCallingYouToPrayItAndSunnahAndNafila = L10n.tr("Localizables", "Is now calling you to pray it and Sunnah and Nafila!", fallback: #"الآن اصبح يصلي معه السنة و النافلة!"#)
  /// لا يغير هذا شئ
  public static let itChangesNothing = L10n.tr("Localizables", "It changes nothing", fallback: #"لا يغير هذا شئ"#)
  /// يجب أن يصبح 
  public static let itMustBecomeA = L10n.tr("Localizables", "It must become a ", fallback: #"يجب أن يصبح "#)
  /// انضم إلي مجتمع من المسلمين المتكافلين
  public static let joinASupportiveCommunityOfFellowMuslims = L10n.tr("Localizables", "Join a supportive community of fellow Muslims!", fallback: #"انضم إلي مجتمع من المسلمين المتكافلين"#)
  /// يمكنك القيام بها!
  public static let keepItUpYouCanDoIt = L10n.tr("Localizables", "Keep it up, you can do it!", fallback: #"يمكنك القيام بها!"#)
  /// تعرف على أسلحتك، وأنك ستتعلمها، وتتدرب عليها، ونأمل من الله أن تتقنها
  public static let knowYourWeaponsAndThatYouWillLearnThemTrainOnThemAndHopefullyFromAllahYouWillMasterThem = L10n.tr("Localizables", "Know your weapons, and that you will learn them, train on them, and hopefully from Allah, you will master them", fallback: #"تعرف على أسلحتك، وأنك ستتعلمها، وتتدرب عليها، ونأمل من الله أن تتقنها"#)
  /// اللغة
  public static let language = L10n.tr("Localizables", "Language", fallback: #"اللغة"#)
  /// ض
  public static let languageCharacter = L10n.tr("Localizables", "language character", fallback: #"ض"#)
  /// اخر %@ ايام
  public static func lastNDays(_ p1: Any) -> String {
    return L10n.tr("Localizables", "Last n Days", String(describing: p1), fallback: #"اخر %@ ايام"#)
  }
  /// اخر بركة
  public static let latestReward = L10n.tr("Localizables", "Latest Reward", fallback: #"اخر بركة"#)
  /// مشرقا
  public static let lighter = L10n.tr("Localizables", "Lighter", fallback: #"مشرقا"#)
  /// كتشجيعك، والثناء عليك، تعطيك بعض التحذير لتفويت الأعمال الحرجة
  public static let likeEncourageYouPraiseYouGiveYouSomeWarningForMissingCriticalDeeds = L10n.tr("Localizables", "Like encourage you, praise you, give you some warning for missing critical deeds", fallback: #"كتشجيعك، والثناء عليك، تعطيك بعض التحذير لتفويت الأعمال الحرجة"#)
  /// لم تحصل علي اي هداية من %@ بعد
  public static func locked(_ p1: Any) -> String {
    return L10n.tr("Localizables", "Locked", String(describing: p1), fallback: #"لم تحصل علي اي هداية من %@ بعد"#)
  }
  /// المغرب
  public static let maghrib = L10n.tr("Localizables", "Maghrib", fallback: #"المغرب"#)
  /// أجعل الصلاة سهلة و طيبة
  public static let makeSalatEasyAndFun = L10n.tr("Localizables", "Make Salat Easy and Fun", fallback: #"أجعل الصلاة سهلة و طيبة"#)
  /// اللهم اجمعنا بهم جميعا في فردوسك الأعلي
  /// 🤲
  public static let mayWeReuniteAgainWithThemInTheHighestParadiseAlongAllOfThoseWhoPreceededUs🤲 = L10n.tr("Localizables", "May we reunite again with them in the highest paradise along all of those who preceeded us\n🤲", fallback: #"اللهم اجمعنا بهم جميعا في فردوسك الأعلي\n🤲"#)
  /// مسلم
  public static let muslim = L10n.tr("Localizables", "Muslim", fallback: #"مسلم"#)
  /// %@ من %@
  public static func nOutOfN(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizables", "n out of n", String(describing: p1), String(describing: p2), fallback: #"%@ من %@"#)
  }
  /// النوافل
  public static let nafila = L10n.tr("Localizables", "Nafila", fallback: #"النوافل"#)
  /// الأسماء لا يوجد فيها ايموجيز.
  public static let namesCantContainEmojis = L10n.tr("Localizables", "names_cant_contain_emojis", fallback: #"الأسماء لا يوجد فيها ايموجيز."#)
  /// الأسماء لا يوجد فيها أرقام
  public static let namesCantContainNumbers = L10n.tr("Localizables", "names_cant_contain_numbers", fallback: #"الأسماء لا يوجد فيها أرقام"#)
  /// الأسماء لا يوجد فيها حروف غريبة.
  public static let namesCantContainSpecialCharacters = L10n.tr("Localizables", "names_cant_contain_special_characters", fallback: #"الأسماء لا يوجد فيها حروف غريبة."#)
  /// التالي
  public static let next = L10n.tr("Localizables", "Next", fallback: #"التالي"#)
  /// لم يتحدد بعد
  public static let notDetermined = L10n.tr("Localizables", "Not Determined", fallback: #"لم يتحدد بعد"#)
  /// ليس لقلب مظلم
  public static let notThatForADarkHeart = L10n.tr("Localizables", "Not that for a dark heart", fallback: #"ليس لقلب مظلم"#)
  /// الآن اصبحت التوبة اسهل, كذلك حلول المشاكل
  public static let nowRepentenceIsEasierAndSoAreSolutionsToProblems = L10n.tr("Localizables", "Now Repentence is easier, and so are Solutions to problems!", fallback: #"الآن اصبحت التوبة اسهل, كذلك حلول المشاكل"#)
  /// اوه, اهلا وسهلا! لقد وجدت صحيفة الخطط
  public static let ohHeyYouMadeItToThePlansPage = L10n.tr("Localizables", "Oh hey!, you made it to the plans page!", fallback: #"اوه, اهلا وسهلا! لقد وجدت صحيفة الخطط"#)
  /// عملية القلب الأبيض هي أول عملية في النجد، حيث ستنخرط أنت، عزيزي المؤمن ، في رحلة استغفر. قد تكون العملية صعبة، لكنها تسهل الكثير من الخطط المستقبلية!
  public static let operationWhiteHeartIsTheFirstOperationOfAlNajdWhereYouDearBelieverWillEngageOnAJourneyOfEstigpharTheOperationMightBeDifficultButItEaseUpLotsOfFuturePlans = L10n.tr("Localizables", "Operation White Heart is the first Operation of Al Najd, where you, dear believer, will engage on a journey of Estigphar The operation might be difficult, but it ease up lots of future Plans!", fallback: #"عملية القلب الأبيض هي أول عملية في النجد، حيث ستنخرط أنت، عزيزي المؤمن ، في رحلة استغفر. قد تكون العملية صعبة، لكنها تسهل الكثير من الخطط المستقبلية!"#)
  /// العملية: قلب أبيض
  public static let operationWhiteHeart = L10n.tr("Localizables", "Operation: White Heart", fallback: #"العملية: قلب أبيض"#)
  /// أو تشير عليك بخلط عملين او اكثر مع ذكر فضلهم
  public static let orBasicallySuggestAnActCombinedWithSomethingElse = L10n.tr("Localizables", "Or basically suggest an act combined with something else", fallback: #"أو تشير عليك بخلط عملين او اكثر مع ذكر فضلهم"#)
  /// غير انها سنة عن النبي, بل انها ايضا تساعدك في قيام الليل
  public static let otherThanBeingASunnahItContributeTowardsBeingQyamLayil = L10n.tr("Localizables", "Other than being a Sunnah, it contribute towards being Qyam Layil", fallback: #"غير انها سنة عن النبي, بل انها ايضا تساعدك في قيام الليل"#)
  /// ••••••••••••••••••••••••••
  public static let passwordHintLocked = L10n.tr("Localizables", "password_hint_locked", fallback: #"••••••••••••••••••••••••••"#)
  /// كلمة المرور.
  public static let passwordHintUnlocked = L10n.tr("Localizables", "password_hint_unlocked", fallback: #"كلمة المرور."#)
  /// كلمة المرور قصيرة للغاية
  public static let passwordTooShort = L10n.tr("Localizables", "password_too_short", fallback: #"كلمة المرور قصيرة للغاية"#)
  /// الأذونات
  public static let permissions = L10n.tr("Localizables", "Permissions", fallback: #"الأذونات"#)
  /// الخطط
  public static let plans = L10n.tr("Localizables", "Plans", fallback: #"الخطط"#)
  /// صلاة %@
  public static func prayerTitle(_ p1: Any) -> String {
    return L10n.tr("Localizables", "prayer_title", String(describing: p1), fallback: #"صلاة %@"#)
  }
  /// الصلوات
  public static let prayers = L10n.tr("Localizables", "Prayers", fallback: #"الصلوات"#)
  /// تذاهر بكل ما انت لست اهل له
  public static let pretendToBeEverythingThatYouReNot = L10n.tr("Localizables", "Pretend to be everything that you're not.", fallback: #"تذاهر بكل ما انت لست اهل له"#)
  /// ضع مسافة بقدر ما تشاء بينك و بين الحقيقة
  public static let putAsMuchDistanceBetweenYouAndTheTruthAsYouWant = L10n.tr("Localizables", "Put as much distance between you and the truth as you want", fallback: #"ضع مسافة بقدر ما تشاء بينك و بين الحقيقة"#)
  /// قيام الليل
  public static let qyamAlLayl = L10n.tr("Localizables", "Qyam Al Layl", fallback: #"قيام الليل"#)
  /// رضيت بالله ربا و بالإسلام دينا و بمحمد صلي الله عليه نبيا و رسولا
  public static let radytoBellah = L10n.tr("Localizables", "RadytoBellah", fallback: #"رضيت بالله ربا و بالإسلام دينا و بمحمد صلي الله عليه نبيا و رسولا"#)
  /// Plural format key: "%#@raqaatCount@"
  public static func raqaatCount(_ p1: Int) -> String {
    return L10n.tr("Localizables", "raqaat_count", p1, fallback: #"Plural format key: "%#@raqaatCount@""#)
  }
  /// بعد
  public static let raqaatPositionAfter = L10n.tr("Localizables", "raqaat_position_after", fallback: #"بعد"#)
  /// قبل
  public static let raqaatPositionBefore = L10n.tr("Localizables", "raqaat_position_before", fallback: #"قبل"#)
  /// تقرأوا 
  public static let receit = L10n.tr("Localizables", "Receit ", fallback: #"تقرأوا "#)
  /// تذكر 
  public static let remember = L10n.tr("Localizables", "Remember ", fallback: #"تذكر "#)
  /// تذكر أن الإسلام هو السبيل الوحيد إلى هناك الآن.
  public static let rememberThatIslamIsTheOnlyWayToThereNow = L10n.tr("Localizables", "Remember that Islam is the only way to there now.", fallback: #"تذكر أن الإسلام هو السبيل الوحيد إلى هناك الآن."#)
  /// تذكر لماذا أنت هنا في هذه 
  public static let rememberWhyYouReHereInThis = L10n.tr("Localizables", "Remember why you're here in this ", fallback: #"تذكر لماذا أنت هنا في هذه "#)
  /// تكرار متبقي
  public static let repeatsAreLeft = L10n.tr("Localizables", "Repeats are left", fallback: #"تكرار متبقي"#)
  /// الجوائز
  public static let rewards = L10n.tr("Localizables", "Rewards", fallback: #"الجوائز"#)
  /// اغني اهل الأرض لصلاتك لسنة الفچر
  public static let richestManOfAllWhoDidnTPray = L10n.tr("Localizables", "Richest Man of all who didn't pray!", fallback: #"اغني اهل الأرض لصلاتك لسنة الفچر"#)
  /// قم من ظلمات انهزامك ، الي نور رحمة الله و اختار 
  public static let riseFromYourStrugglesAndPick = L10n.tr("Localizables", "Rise from your struggles, and pick ", fallback: #"قم من ظلمات انهزامك ، الي نور رحمة الله و اختار "#)
  /// الطريق
  public static let road = L10n.tr("Localizables", "Road", fallback: #"الطريق"#)
  /// الصلاة و فوائدها 
  public static let salat = L10n.tr("Localizables", "Salat", fallback: #"الصلاة و فوائدها "#)
  /// شاهد تطورك!
  public static let seeHowFarHaveYouGone = L10n.tr("Localizables", "See how far have you gone", fallback: #"شاهد تطورك!"#)
  /// الإعدادات
  public static let settings = L10n.tr("Localizables", "Settings", fallback: #"الإعدادات"#)
  /// بما أن الصلاة هي عمود دين، فقد سهلنا عليك الاحتفاظ بها
  /// 
  public static let sincePrayerIsTheColumnOfDeenWeMadeItEasyForYouToKeep = L10n.tr("Localizables", "Since Prayer is the column of Deen, we made it easy for you to keep\n", fallback: #"بما أن الصلاة هي عمود دين، فقد سهلنا عليك الاحتفاظ بها\n"#)
  /// تخطي
  public static let skip = L10n.tr("Localizables", "Skip", fallback: #"تخطي"#)
  /// ليس فقط النوم المريح ما اكتسبت بالعشاء, بالنصف قيام الليل الأول, وما ادراك ما نصف قيام الليل
  public static let sleepAndTranquility = L10n.tr("Localizables", "Sleep and tranquility", fallback: #"ليس فقط النوم المريح ما اكتسبت بالعشاء, بالنصف قيام الليل الأول, وما ادراك ما نصف قيام الليل"#)
  /// مؤثرات صوتية
  public static let soundEffects = L10n.tr("Localizables", "Sound Effects", fallback: #"مؤثرات صوتية"#)
  /// اصوات
  public static let sounds = L10n.tr("Localizables", "Sounds", fallback: #"اصوات"#)
  /// اصوات & ردود الفعل اللمسية
  public static let soundsHapticFeedback = L10n.tr("Localizables", "Sounds & Haptic Feedback", fallback: #"اصوات & ردود الفعل اللمسية"#)
  /// الإلتزام بها لن يساعدك فقط في الوصول إلى وجهتك
  public static let stayingTrueToItWillNotOnlyHelpYouReachYourDestination = L10n.tr("Localizables", "Staying true to it will not only help you reach your destination", fallback: #"الإلتزام بها لن يساعدك فقط في الوصول إلى وجهتك"#)
  /// صعب الأمر؟ لا تقلق, الشخص المناسب, انه الفچر!, لكي تسهل عليك العبادة, فقط استيقظ له, فيسهل الباقي!
  public static let strugglingYouGotThisDoYouWantToKnowWhoCanHelpAlFajrMakeSureToPrayItSoOtherDeedsBecomeEasier = L10n.tr("Localizables", "Struggling? you got this, do you want to know who can help? Al Fajr!, make sure to pray it so other deeds become easier!", fallback: #"صعب الأمر؟ لا تقلق, الشخص المناسب, انه الفچر!, لكي تسهل عليك العبادة, فقط استيقظ له, فيسهل الباقي!"#)
  /// السنن
  public static let sunnah = L10n.tr("Localizables", "Sunnah", fallback: #"السنن"#)
  /// (مؤكدة)
  public static let sunnahAffirmed = L10n.tr("Localizables", "sunnah_affirmed", fallback: #"(مؤكدة)"#)
  /// (مستحبة)
  public static let sunnahDesired = L10n.tr("Localizables", "sunnah_desired", fallback: #"(مستحبة)"#)
  /// %@ %@ %@
  public static func sunnahSubtitle(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
    return L10n.tr("Localizables", "sunnah_subtitle", String(describing: p1), String(describing: p2), String(describing: p3), fallback: #"%@ %@ %@"#)
  }
  /// سنة %@ %@
  public static func sunnahTitle(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizables", "sunnah_title", String(describing: p1), String(describing: p2), fallback: #"سنة %@ %@"#)
  }
  /// رقيب نفسك
  /// 
  public static let supervisor = L10n.tr("Localizables", "Supervisor ", fallback: #"رقيب نفسك\n"#)
  /// احسنت!
  public static let thatSTheSpirit = L10n.tr("Localizables", "That's the spirit!", fallback: #"احسنت!"#)
  /// صلاة الآوابين, نعم العباد, الله يمدح و يعتز بعباده الآوابين, فما اكرمها من عبادة ان يمدح الله اهلها و ياله من شرف عظيم, بل يجعل لك ايضا الله في كل عمل لك صدقة, و يجعل علي كل سلامة (عظمة في جسدك) صدقة!
  public static let theAwabeenPrayerAllahPraiseThoseWhoAreAwabeenAndYouGetSadaqatOnAnyDeedYouDo = L10n.tr("Localizables", "The Awabeen Prayer, Allah praise those who are Awabeen, and you get sadaqat on any deed you do!", fallback: #"صلاة الآوابين, نعم العباد, الله يمدح و يعتز بعباده الآوابين, فما اكرمها من عبادة ان يمدح الله اهلها و ياله من شرف عظيم, بل يجعل لك ايضا الله في كل عمل لك صدقة, و يجعل علي كل سلامة (عظمة في جسدك) صدقة!"#)
  /// لوحة المعلومات
  public static let theDashboard = L10n.tr("Localizables", "The Dashboard", fallback: #"لوحة المعلومات"#)
  /// هي أيضا قادرة على إعطاءك بعض النصائح
  public static let theDashboardIsAlsoAbleToGiveInsights = L10n.tr("Localizables", "The Dashboard is also able to give insights", fallback: #"هي أيضا قادرة على إعطاءك بعض النصائح"#)
  /// ذاك الفرض اللذي كان صعبا 
  public static let theFaardThatWasTooHard = L10n.tr("Localizables", "The Faard that was too hard", fallback: #"ذاك الفرض اللذي كان صعبا "#)
  /// شرف المؤمن, و اختص الله هذه الصلاة في الثلث الأخير من انه يتنزل الي السماء الدنيا فينادي علي عباده,هل من سائل فيعطى سؤله، هل من داع فيستجاب له، هل من مستغفر فيغفر له هل من تائب، فيتاب عليه؟, بل من معزة مصليها عند ربهم, يشع نور من بيته كل ليلة, حتي اذا غاب سئلت عنه الملائكة و دعت له اذا علمت بمرضه بالشفاء و استغفرت له
  public static let theHonorOfMuslimItSSaidThatAngelsPrayToThoseWhoMissItForADayOrTwoIfTheyMakeAHabitOfItInCaseTheyAreSickAndAngelsPrayersAreBlessed = L10n.tr("Localizables", "The Honor of Muslim, it's said that Angels pray to those who miss it for a day or two if they make a habit of it in case they are sick, and Angels prayers are blessed", fallback: #"شرف المؤمن, و اختص الله هذه الصلاة في الثلث الأخير من انه يتنزل الي السماء الدنيا فينادي علي عباده,هل من سائل فيعطى سؤله، هل من داع فيستجاب له، هل من مستغفر فيغفر له هل من تائب، فيتاب عليه؟, بل من معزة مصليها عند ربهم, يشع نور من بيته كل ليلة, حتي اذا غاب سئلت عنه الملائكة و دعت له اذا علمت بمرضه بالشفاء و استغفرت له"#)
  /// الصديق 
  public static let thePal = L10n.tr("Localizables", "the pal ", fallback: #"الصديق "#)
  /// كان صلي الله عليه و سلم لا يترك ركعتان ما بعد المغرب لفضلهم
  public static let theProphetSAWNeverLeftTheSunnahOfAlMaghrib = L10n.tr("Localizables", "The Prophet SAW never left the Sunnah of Al Maghrib", fallback: #"كان صلي الله عليه و سلم لا يترك ركعتان ما بعد المغرب لفضلهم"#)
  /// إن الطريق أمامنا طويل ولا يرحم.
  public static let theRoadAheadIsLongAndUnforgiving = L10n.tr("Localizables", "The Road ahead is long, and unforgiving.", fallback: #"إن الطريق أمامنا طويل ولا يرحم."#)
  /// هنالك اكثر من ٢٥ فضل في صلاة الظهر, افضلها انها تقربك من الله
  public static let thereAre25BenefitInDuhrTheBestGettingCloserToAllah = L10n.tr("Localizables", "There are 25+ benefit in Duhr, the best? Getting closer to Allah!", fallback: #"هنالك اكثر من ٢٥ فضل في صلاة الظهر, افضلها انها تقربك من الله"#)
  /// لا يوجد مكان لك تهرب اليه, أيها المسلم
  public static let thereIsNoWhereYouCanHideMuslim = L10n.tr("Localizables", "There is no where you can hide, Muslim", fallback: #"لا يوجد مكان لك تهرب اليه, أيها المسلم"#)
  /// لا يتم ذلك على أي خادم، البيانات والإجراءات الخاصة بك ستظل علي هاتفك ولا نية لنا في جمعها.
  public static let thisIsNotDoneOnAnyServerYourDataAndActionsArePersonalAndWeIntendToKeepItThatWay = L10n.tr("Localizables", "This is not done on any server, your data and actions are personal, and we intend to keep it that way", fallback: #"لا يتم ذلك على أي خادم، البيانات والإجراءات الخاصة بك ستظل علي هاتفك ولا نية لنا في جمعها."#)
  /// هذا العمل هو صدقة جارية ل...
  public static let thisWorkIsASadaqaFor = L10n.tr("Localizables", "This work is a Sadaqa for...", fallback: #"هذا العمل هو صدقة جارية ل..."#)
  /// أولئك الذين توفاهم الله
  public static let thoseWhoPassedAway = L10n.tr("Localizables", "Those who passed away", fallback: #"أولئك الذين توفاهم الله"#)
  /// نصيحة اليوم
  public static let tipOfTheDay = L10n.tr("Localizables", "Tip of the day", fallback: #"نصيحة اليوم"#)
  /// حتي تصل إلي 
  public static let toBeABetterVersionOf = L10n.tr("Localizables", "To be a better version of ", fallback: #"حتي تصل إلي "#)
  /// لها
  public static let toHer = L10n.tr("Localizables", "to her", fallback: #"لها"#)
  /// إلي أعلي الچنة!
  public static let toTheHighestRanksInJannah = L10n.tr("Localizables", "To the highest ranks in Jannah", fallback: #"إلي أعلي الچنة!"#)
  /// اليوم
  public static let today = L10n.tr("Localizables", "Today", fallback: #"اليوم"#)
  /// تتبع ذلك عن طريق سحبها من الجانب
  public static let trackOfItByJustSwipingFromTheSide = L10n.tr("Localizables", "Track of it by just swiping from the side", fallback: #"تتبع ذلك عن طريق سحبها من الجانب"#)
  /// حاول أن تتذكر نفسك، نفسك الجميلة، اللتي على قيد الحياة، لا المنهكة.
  public static let tryToRememberYourSelfYourBeautifulSelfTheAliveOneNotTheCurrent = L10n.tr("Localizables", "Try to remember your self, your beautiful self, the alive one, not the current.", fallback: #"حاول أن تتذكر نفسك، نفسك الجميلة، اللتي على قيد الحياة، لا المنهكة."#)
  /// للأسف, لا يوجد ما يكفي من البيانات لتحليل هذا الأسبوع
  public static let unfortunatelyThereIsNotEnoughDataToAnalyzeThisWeek = L10n.tr("Localizables", "Unfortunately there is not enough data to analyze this week", fallback: #"للأسف, لا يوجد ما يكفي من البيانات لتحليل هذا الأسبوع"#)
  /// إستيقظ أيها المسلم.
  public static let wakeUpMuslim = L10n.tr("Localizables", "Wake up, Muslim.", fallback: #"إستيقظ أيها المسلم."#)
  /// إستيقظ.
  public static let wakeUp = L10n.tr("Localizables", "Wake up.", fallback: #"إستيقظ."#)
  /// بإمكاننا 
  public static let weCan = L10n.tr("Localizables", "We Can ", fallback: #"بإمكاننا "#)
  /// حاليا يوجد خطة واحدة فقط و هي الأستغفار, ولكن المزيد قادم إن شاء الله, فترقب!
  public static let weCurrentlyHaveOnly1PlanForEstigpharButMoreIsComingIsA = L10n.tr("Localizables", "We currently have only 1 plan for Estigphar, but more is Coming isA", fallback: #"حاليا يوجد خطة واحدة فقط و هي الأستغفار, ولكن المزيد قادم إن شاء الله, فترقب!"#)
  /// نأمل أن نتمكن من مساعدتك، حتى لو كان ذلك عن طريق شيء صغير جدا
  public static let weHopeWeMayBeAbleToHelpYouEvenIfBySomethingSoLittle = L10n.tr("Localizables", "We hope we may be able to help you, even if by something so little", fallback: #"نأمل أن نتمكن من مساعدتك، حتى لو كان ذلك عن طريق شيء صغير جدا"#)
  /// لذلك بذلنا جهدا للعثور على فوائد معظم الأفعال هنا
  public static let weTookAnEffortToFindWhatAreTheBenefitsOfMostOfTheDeedsHere = L10n.tr("Localizables", "We took an effort to find what are the benefits of most of the deeds here", fallback: #"لذلك بذلنا جهدا للعثور على فوائد معظم الأفعال هنا"#)
  /// هنئا لك, اصبح مالك, و دعاءك, و امنياتك مباركة, و ان شاء الله يفيض الله عليك ببركات, هذا ما كسبت من صلاة المغرب
  public static let wealthBuffedDuaAndWishesBuffedBlessingShoweredThatSWhatYouVeWonWithAlMaghrib = L10n.tr("Localizables", "Wealth Buffed, Dua and Wishes Buffed, Blessing Showered, That's what you've won with Al Maghrib", fallback: #"هنئا لك, اصبح مالك, و دعاءك, و امنياتك مباركة, و ان شاء الله يفيض الله عليك ببركات, هذا ما كسبت من صلاة المغرب"#)
  /// مرحبا بكم في 
  public static let welcomeTo = L10n.tr("Localizables", "Welcome to ", fallback: #"مرحبا بكم في "#)
  /// اهلا بك في النچد
  public static let welcomeToTheNajd = L10n.tr("Localizables", "Welcome To The Najd", fallback: #"اهلا بك في النچد"#)
  /// ما شاء الله! الله عليك! اتممت صلاوات %@ كلها, ما شاء الله!
  public static func wellDone(_ p1: Any) -> String {
    return L10n.tr("Localizables", "Well Done", String(describing: p1), fallback: #"ما شاء الله! الله عليك! اتممت صلاوات %@ كلها, ما شاء الله!"#)
  }
  /// أبليت حسنا علي صلاتك للفجر في %@
  public static func wellDoneOnPrayingAlFajrOnDay(_ p1: Any) -> String {
    return L10n.tr("Localizables", "Well done on praying Al Fajr on day", String(describing: p1), fallback: #"أبليت حسنا علي صلاتك للفجر في %@"#)
  }
  /// بارك الله فيك 👏
  /// إن كنت صليتم في جماعة, فكأنما قمت الليل كله
  public static let wellDoneOnPrayingFajrAndAishaa👏IfYouPrayedThisInGroupTheRewardIsLikeYouVeDoneQeyamAlLayilOfTheWholeNight = L10n.tr("Localizables", "Well Done on praying Fajr and Aishaa 👏\nIf you prayed this in Group, the reward is like you've done Qeyam Al Layil of the whole night", fallback: #"بارك الله فيك 👏\nإن كنت صليتم في جماعة, فكأنما قمت الليل كله"#)
  /// ما شاء الله! الله عليك! اتممت الأذكار كلها, ما شاء الله!
  public static let wellDoneYouManagedToDoAllTheZekr = L10n.tr("Localizables", "Well Done You Managed to do All the Zekr!", fallback: #"ما شاء الله! الله عليك! اتممت الأذكار كلها, ما شاء الله!"#)
  /// رقعة وتر
  public static let wetr = L10n.tr("Localizables", "Wetr", fallback: #"رقعة وتر"#)
  /// إذا قرأت ٧ ايات بعد صلاة العشاء, فقد كتبت من من قام هذه الليلة
  public static let wetrWhenDoneWith7VersesIsSameAsDoingQyamAlLayl = L10n.tr("Localizables", "Wetr when done with 7 Verses, is same as doing Qyam Al Layl", fallback: #"إذا قرأت ٧ ايات بعد صلاة العشاء, فقد كتبت من من قام هذه الليلة"#)
  /// حيث ستجد كيف فعلت خلال فترة زمنية (هي ثابتة عند 7 أيام حتي نحسنها)
  public static let whereYouWillFindHowDidYouDoDuringATimePeriodNowItsStaticTo7Days = L10n.tr("Localizables", "Where you will find how did you do during a time period (now its static to 7 days)", fallback: #"حيث ستجد كيف فعلت خلال فترة زمنية (هي ثابتة عند 7 أيام حتي نحسنها)"#)
  /// يا ليت كان هناك ما يكفي لملئ هذا الأسبوع بالأعمال الرائعة, سنفعلها هذا الأسبوع
  public static let wouldnTItBeAwesomeIfWeHadAWeekSWorthOfAwesomeDeedsToDisplayHereLetSNailItThisWeek = L10n.tr("Localizables", "Wouldn't it be awesome if we had a week's worth of awesome deeds to display here? let's nail it this week!", fallback: #"يا ليت كان هناك ما يكفي لملئ هذا الأسبوع بالأعمال الرائعة, سنفعلها هذا الأسبوع"#)
  /// يمكنك سحب النتيجة من الأعلى
  public static let youCanDragTheCalendarFromAbove = L10n.tr("Localizables", "You can drag the Calendar from above", fallback: #"يمكنك سحب النتيجة من الأعلى"#)
  /// لا يمكنك التغير
  public static let youCanNotChange = L10n.tr("Localizables", "You can not change...", fallback: #"لا يمكنك التغير"#)
  /// أنت لا تتذكر لماذا أنت هنا، أليس كذلك؟
  public static let youDonTRememberWhyYouReHereDoYou = L10n.tr("Localizables", "You don't remember why you're here, do you?", fallback: #"أنت لا تتذكر لماذا أنت هنا، أليس كذلك؟"#)
  /// ستظل دائما...
  public static let youWillAlwaysBe = L10n.tr("Localizables", "You will always be...", fallback: #"ستظل دائما..."#)
  /// أنت أفضل من هذا، من عدم تذكر سبب وجودك هنا.
  public static let youReBetterThanThisThanNotRememberingWhyYouReHere = L10n.tr("Localizables", "You're better than this, than not remembering why you're here.", fallback: #"أنت أفضل من هذا، من عدم تذكر سبب وجودك هنا."#)
  /// رفيقك الي چنة الأخري
  public static let yourCompanionToABetterAkhra = L10n.tr("Localizables", "Your companion to a better Akhra", fallback: #"رفيقك الي چنة الأخري"#)
  /// اصبحت الأن اقرب من الله
  public static let yourImanGrowFurther = L10n.tr("Localizables", "Your Iman Grow further!", fallback: #"اصبحت الأن اقرب من الله"#)
  /// نچدك
  public static let yourNajd = L10n.tr("Localizables", "Your Najd", fallback: #"نچدك"#)
  /// كلمة المرور الحالية
  public static let yourCurrentPassword = L10n.tr("Localizables", "your_current_password", fallback: #"كلمة المرور الحالية"#)
  /// همة أعلي!
  public static let yourself = L10n.tr("Localizables", "Yourself", fallback: #"همة أعلي!"#)
  public enum AndThatThingYouListenToIsNotYourFriendHeIsAnEnemyBut {
    /// وهذا "الشيء" الذي تستمع إليه، ليس صديقك، إنه عدو، لكن...
    /// إطمئن
    ///  لأنه ضعيف
    public static let restAssuredForHeSAWeakOne = L10n.tr("Localizables", "And that 'thing' you listen to, is not your friend, he is an enemy, but...\nRest assured,\n for he's a weak one.", fallback: #"وهذا "الشيء" الذي تستمع إليه، ليس صديقك، إنه عدو، لكن...\nإطمئن\n لأنه ضعيف"#)
  }
  public enum AndToAllOurPassedAwayClosedOnes {
    /// و لجميع اموات المسلمين.
    /// ❤️
    public static let _️ = L10n.tr("Localizables", "And to all our passed away closed ones.\n❤️", fallback: #"و لجميع اموات المسلمين.\n❤️"#)
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

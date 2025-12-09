
import Foundation
import SwiftUI

let HomeChallenges: [ChallengeCard] = [
    ChallengeCard(
        title: "قول جملة بثلاث بدايات مختلفة",
        description: """
                      اختر جملة واحدة وقلها بثلاث بدايات مختلفة. الهدف إنك تدرب نفسك على المرونة في بداية الكلام، لأن أصعب جزء غالبًا هو أول كلمة
                      """,
        conditions: """
    •    اختر جملة بسيطة مثل: “أبي أقول نقطة…”
    •    ابدأها بثلاث طرق، مثال:
    •    “أظن…”
    •    “في رأيي…”
    •    “أنا أشوف…”
    •    سجّل المحاولة أو اكتبها.

    """,
        difficultyImageName: "skull_level1"),
    
    
    ChallengeCard(
        title: "تنفّس 4-4-4",
        description: """
                      هذا تمرين تنفّس يساعد على إرخاء الحبال الصوتية وتقليل التوتر اللي يزيد التأتأة. بعد التمرين، قل جملة قصيرة بصوت هادئ ولاحظ الفرق.
                      """,
        conditions: """
    •    شهيق لمدة 4 ثواني.
    •    حبس نفس لمدة 4 ثواني.
    •    زفير لمدة 4 ثواني.
    •    بعدها قل جملة قصيرة مثل: “أنا أقدر أتكلم بهدوء.”
    •    كرّر التمرين ثلاث مرات.

    """,
        difficultyImageName: "skull_level2")
]


let OutsideChallenges: [ChallengeCard] = [
    ChallengeCard(
        title: " اطلب طلب جديد من مطعمك المعتاد",
        description: """
                      اذهب لمطعمك أو مقهاك المعتاد، واطلب شيئًا جديدًا ما قد جربته. الهدف كسر نمط الطلب الروتيني وزيادة جرأة بدء المحادثات.
                      """,
        conditions: """
    •    لازم يكون الطلب مختلف فعلاً (نوع جديد، حجم مختلف، بدون إضافات…الخ).
    •    اطلبه بثقة حتى لو حسيت بتردد.
    •    دوّن شعورك بعد التجربة.

    """,
        difficultyImageName: "skull_level1"),
    
    
    // old
    ChallengeCard(title: "اسأل عن الاتجاهات",
                  description: "تحدث مع شخص واسأله عن مكان قريب.",
                  conditions: """
- يجب أن تسأل شخصًا لا تعرفه
- اسأل عن مكان حقيقي قريب من موقعك
- كن مؤدبًا واشكره على المساعدة
""",
                  difficultyImageName: "skull_level2")
]

let JournalChallenges: [ChallengeCard] = [
    ChallengeCard(title: "اكتب 3 أشياء ممتن لها",
                  description: "دوّن 3 نقاط جميلة حدثت اليوم.",
                  conditions: """
- يجب أن تكون 3 أشياء مختلفة ومحددة
- اكتب جملة كاملة عن كل واحدة منها
- ركز على الأشياء الإيجابية الحقيقية
""",
                  difficultyImageName: "skull_level1"),
    ChallengeCard(title: "ضع هدف يومي",
                  description: "اكتب هدفًا واحدًا تريد تحقيقه اليوم.",
                  conditions: """
- يجب أن يكون هدفًا قابلًا للتحقيق خلال اليوم
- اكتب خطة بسيطة لتحقيقه
- حدد وقتًا محددًا للبدء
""",
                  difficultyImageName: "skull_level2")
]

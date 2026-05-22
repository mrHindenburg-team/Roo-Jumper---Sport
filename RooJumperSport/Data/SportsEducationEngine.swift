import Foundation

// Offline fallback education engine — returns structured sports-science answers
// when Foundation Models are unavailable or the free-tier limit is reached.
struct SportsEducationEngine {

    // MARK: - Public API

    func generateResponse(for query: String) -> String {
        let q = query.lowercased()
        return matchedResponse(for: q)
    }

    // MARK: - Pattern Matching

    private func matchedResponse(for q: String) -> String {
        if q.localizedStandardContains("jump higher") || q.localizedStandardContains("increase vertical") {
            return verticalJumpAnswer
        }
        if q.localizedStandardContains("plyometric") || q.localizedStandardContains("plyo") {
            return plyometricsAnswer
        }
        if q.localizedStandardContains("explosi") {
            return explosivenessAnswer
        }
        if q.localizedStandardContains("high jump") {
            return highJumpAnswer
        }
        if q.localizedStandardContains("long jump") {
            return longJumpAnswer
        }
        if q.localizedStandardContains("muscle") || q.localizedStandardContains("muscles") {
            return musclesAnswer
        }
        if q.localizedStandardContains("land") {
            return landingAnswer
        }
        if q.localizedStandardContains("basketball") {
            return basketballAnswer
        }
        if q.localizedStandardContains("volleyball") {
            return volleyballAnswer
        }
        if q.localizedStandardContains("parkour") {
            return parkourAnswer
        }
        if q.localizedStandardContains("recover") || q.localizedStandardContains("rest") {
            return recoveryAnswer
        }
        if q.localizedStandardContains("warm up") || q.localizedStandardContains("warmup") {
            return warmupAnswer
        }
        if q.localizedStandardContains("nutrition") || q.localizedStandardContains("diet") || q.localizedStandardContains("eat") {
            return nutritionAnswer
        }
        if q.localizedStandardContains("air") || q.localizedStandardContains("flight") || q.localizedStandardContains("body control") {
            return airControlAnswer
        }
        if q.localizedStandardContains("strength") || q.localizedStandardContains("squat") || q.localizedStandardContains("deadlift") {
            return strengthAnswer
        }
        if q.localizedStandardContains("speed") || q.localizedStandardContains("sprint") || q.localizedStandardContains("fast") {
            return speedAnswer
        }
        if q.localizedStandardContains("beginner") || q.localizedStandardContains("start") {
            return beginnerAnswer
        }
        if q.localizedStandardContains("injury") || q.localizedStandardContains("pain") || q.localizedStandardContains("safe") {
            return injuryPreventionAnswer
        }
        if q.localizedStandardContains("trampoline") {
            return trampolineAnswer
        }
        if q.localizedStandardContains("freerun") || q.localizedStandardContains("flip") {
            return freerunningAnswer
        }
        if q.localizedStandardContains("program") || q.localizedStandardContains("plan") || q.localizedStandardContains("schedule") {
            return programAnswer
        }
        if q.localizedStandardContains("biomechanic") || q.localizedStandardContains("physics") || q.localizedStandardContains("science") {
            return biomechanicsAnswer
        }
        return defaultAnswer
    }

    // MARK: - Answer Bank

    private let verticalJumpAnswer = """
    **Improving your vertical jump** requires training three interconnected systems:

    **1. Strength Foundation**
    Squats, Romanian deadlifts, hip thrusts, and calf raises build the raw force capacity your muscles need. Aim for 1.5–2× bodyweight squat strength before moving to advanced plyometrics.

    **2. Explosive Power (Plyometrics)**
    Box jumps, depth jumps, and squat jumps convert strength into speed-strength. The stretch-shortening cycle (SSC) stores elastic energy — plyometrics train you to use it efficiently.

    **3. Jumping Technique**
    ✦ Arm swing: generates 10–15% of jump height
    ✦ Triple extension: simultaneous ankle, knee, and hip extension
    ✦ Penultimate step: longer step lowers center of mass, loading the legs
    ✦ Keep ground contact short — long contacts bleed energy

    **Timeline:** Most athletes see 3–6 cm improvement in 8 weeks with consistent training, 2–3× per week. Elite gains require 6–12 months.

    _Your training journey starts now. Use the Training tab to access structured sessions._
    """

    private let plyometricsAnswer = """
    **Plyometric Training** exploits the stretch-shortening cycle (SSC) — the most powerful mechanism in human jumping.

    **How it works:**
    When your muscle-tendon unit is rapidly stretched (eccentric phase), elastic energy is stored like a spring. If the concentric contraction follows immediately, this energy is released, adding free power to your jump.

    **Three levels of plyometrics:**

    🟢 **Level 1 — Low Intensity**
    Jump rope, bodyweight squat jumps, shallow box jumps
    Focus: Landing mechanics, ankle stiffness

    🟡 **Level 2 — Moderate Intensity**
    Depth jumps (30–40 cm), bounding, hurdle hops
    Focus: Reducing ground contact time, reactive force

    🔴 **Level 3 — High Intensity**
    Depth jumps (60+ cm), single-leg reactive hops, overspeed jumps
    Focus: Maximum rate of force development

    **Golden Rule:** Quality > Quantity. Never train plyometrics fatigued. 24–48 hours recovery between sessions.
    """

    private let explosivenessAnswer = """
    **Athletic Explosiveness** is your ability to produce maximum force in minimum time — measured as Rate of Force Development (RFD).

    **What limits explosiveness:**
    • Neuromuscular activation speed
    • Motor unit recruitment efficiency
    • Tendon stiffness
    • Muscle fiber composition (Type IIx fast-twitch fibers)

    **How to train it:**
    1. **Heavy Strength Work** — Increases available force (max strength = ceiling for power)
    2. **Ballistic Movements** — Jump squats with 30% 1RM; Olympic lifting derivatives
    3. **Contrast Training** — Heavy set followed immediately by explosive movement (potentiation effect)
    4. **Sprint Starts** — Horizontal explosiveness transfers well to vertical
    5. **Intent** — Actively try to move as fast as possible, even with lighter loads

    **Science:** In the first 100 ms of a jump, only 30–50% of maximum force is reached. Athletes who improve this early force production see the biggest jump gains.
    """

    private let highJumpAnswer = """
    **High Jump — The Fosbury Flop** is one of the most biomechanically sophisticated skills in athletics.

    **The 5 Technical Phases:**

    1. **The Approach**
       8–10 strides in a J-shaped curve. The curve creates centrifugal force that tilts you inward, setting up the arch.

    2. **Penultimate Step**
       The second-to-last step is long and low — it lowers your center of mass and loads the elastic energy.

    3. **Plant and Drive**
       Plant foot points slightly away from the bar. Drive the opposite knee and both arms forcefully upward. The body naturally rotates backward.

    4. **Bar Clearance**
       Arch your back over the bar — your hips pass over at the last moment. Tuck chin to chest to get shoulders clear first.

    5. **Landing**
       Onto the upper back/neck. Land with control — look up, not sideways.

    **Key Science:** A jumper can clear a bar set above their centre of mass — the arch distributes body sections so each part passes under the bar's height even though the whole body is "above" it.
    """

    private let longJumpAnswer = """
    **Long Jump** requires converting maximum sprint speed into horizontal distance.

    **Technical Breakdown:**

    🏃 **The Approach Run** (16–22 strides)
    Build to maximum controlled speed. Consistency in stride count is essential — mark your approach at 3, 7, and 11 strides.

    👣 **Penultimate & Final Steps**
    Penultimate step = slightly longer (lowers hips)
    Final step = slightly shorter (raises hips back up)
    This creates the launch angle without braking.

    🚀 **Takeoff**
    • Flat-foot contact — not heel strike
    • Active "pawing" motion at the board
    • Punch the free knee high, swing arms forward
    • Target takeoff angle: 18–25°

    ✈️ **Flight Phase**
    Maintain a "running in the air" motion to preserve forward rotation.
    Hitch-kick technique: Two and a half stride cycles in the air.

    🛬 **Landing**
    Shoot feet forward at the last moment. Land with heels, sit through hips. Hands should reach past your feet.
    """

    private let musclesAnswer = """
    **Key Muscles for Jumping Performance:**

    🔴 **Primary Movers (Extensors)**
    • **Glutes** — hip extension power; biggest contributor to vertical force
    • **Quadriceps** — knee extension; absorbs landing impact
    • **Gastrocnemius/Soleus (Calves)** — ankle extension; stores elastic energy

    🟡 **Supporting Muscles**
    • **Hamstrings** — hip extension assist; decelerates knee extension safely
    • **Hip Flexors** — swing the free leg at takeoff; drive knee in high jumps
    • **Core (Transverse Abdominis, Obliques)** — transfers force between lower and upper body

    🟢 **Often Neglected**
    • **Tibialis Anterior** — controls landing mechanics; prevents excessive pronation
    • **Hip Abductors/External Rotators** — knee tracking; single-leg stability
    • **Intrinsic Foot Muscles** — the foundation of the chain

    **Training Principle:** The jumping chain works as a system. A weak link anywhere reduces the efficiency of the entire chain. Test single-leg movements to find yours.
    """

    private let landingAnswer = """
    **Safe Landing Mechanics** are as important as the jump itself — poor landings cause the majority of jumping-related injuries.

    **The Landing Sequence:**
    1. **Toes first**, then heel — never flat-foot or heel-strike
    2. **Knee bent** — ideally 60–90° to absorb impact
    3. **Hip flexion** — sit back slightly, not forward
    4. **Core engaged** — prevents spinal flexion under load
    5. **Quiet landing** — the quieter the landing, the better the force absorption

    **What to avoid:**
    ✕ Knee valgus (knees caving inward) — ACL risk
    ✕ Excessive forward trunk lean — puts stress on patellar tendon
    ✕ Landing with locked knees — transfers impact directly to joints

    **Progressive Landing Training:**
    1. Start: Drop from 30 cm box and hold landing for 2 seconds
    2. Intermediate: Continuous hops with quiet, controlled landings
    3. Advanced: Depth jumps with rapid, efficient landings

    _Studies show landing training reduces ACL injury risk by 50% in female athletes and 25% in male athletes._
    """

    private let basketballAnswer = """
    **Basketball Vertical Training** must develop both one-foot and two-foot takeoffs.

    **Two Types of Jumps:**

    🏀 **Two-Foot Jump** (post, power layup, rebound)
    → Box jumps, squat jumps, approach two-foot jumps
    → Focus: maximum force in a short ground contact

    🏀 **One-Foot Jump** (running layup, transition dunk)
    → Single-leg hops, bounding, running broad jumps
    → Focus: converting horizontal speed into vertical height

    **Basketball-Specific Considerations:**
    • Off-dribble explosiveness: Practice jumping from dribble position
    • Lateral explosiveness: Euro-step, post footwork, defensive slides
    • Consistent height in Q4: Train power endurance (10 jumps in 10 seconds)
    • Contact jumps: Practice landing in contact to build stability

    **Sample Weekly Structure:**
    Mon: Heavy lower + bilateral plyos
    Wed: Unilateral work + court explosive drills
    Fri: Reactive power + game-speed practice
    """

    private let volleyballAnswer = """
    **Volleyball Jumping** demands consistent explosive height combined with precise timing.

    **The 4-Step Approach (Right-handed attacker):**
    Step 1: Left foot (small)
    Step 2: Right foot (longer)
    Step 3: Left foot (penultimate — lower hips)
    Step 4: Right foot closes to left (plant and launch)

    **Key Technical Points:**
    • Approach speed = jump height. Don't slow down before jumping.
    • Arm swing: both arms back on penultimate step, then explosive swing forward-upward
    • Time your jump so you contact the ball at the highest point
    • Brake-and-go: the penultimate step brake creates elastic loading

    **Blocking Jumps:**
    • Different takeoff — vertical, close to net
    • Lead with hands — reach maximum height before the ball crosses
    • Split-step timing: move when setter's hands contact the ball

    **Training Focus:**
    Plyometric approach drills, arm-swing power training, and consistent jump timing exercises.
    """

    private let parkourAnswer = """
    **Parkour Foundation Movement**

    Parkour is about moving from A to B as efficiently and safely as possible using only your body. Every skill is built on a foundation of safe landings and controlled movement.

    **Core Skills to Learn First:**
    1. **Precision Landing** — Jump to a narrow surface and stick it, feet together
    2. **Safety Roll** — Distribute landing impact through a diagonal forward roll
    3. **Cat Leap** — Jump to a wall, catch with hands and feet on the surface
    4. **Stride Jump** — Running jump across a gap, land and continue moving
    5. **Kong Vault** — Hands-first vault over an obstacle

    **The Safety Rule:**
    Never attempt a movement at full scale unless you can do it perfectly at a smaller scale. Every jump done in parkour should feel "easy" — uncomfortable means unprepared.

    **Physical Preparation:**
    • Upper body: Pull-ups, dips, push-ups (you need to catch and control bodyweight)
    • Lower body: Single-leg squats, precision landing practice
    • Core: Plank variations, hanging core work
    • Flexibility: Hip flexors, shoulders, ankles

    _Train smart — parkour practitioners have remarkably low injury rates when trained progressively._
    """

    private let recoveryAnswer = """
    **Athletic Recovery** is where adaptation actually happens. Training creates the stimulus; recovery is the adaptation.

    **Recovery Methods by Priority:**

    🥇 **Sleep (Highest Impact)**
    7–9 hours. Growth hormone release during deep sleep is essential for tissue repair and strength gains. Sleep deprivation reduces force production by 10–15%.

    🥈 **Nutrition Timing**
    • 0–30 min post-training: 20–40g protein + carbohydrates
    • Leucine content matters most for muscle protein synthesis
    • Rehydrate: 1.5× the weight lost during training

    🥉 **Active Recovery**
    Low-intensity movement (walking, swimming) 20–30 min on off-days improves blood flow and reduces DOMS.

    **Supplementary Methods:**
    • Foam rolling + static stretching (post-training)
    • Cold water immersion (10–15 min at 10–15°C) reduces inflammation
    • Contrast therapy: alternating hot/cold

    **Warning Signs of Overtraining:**
    Decreased jump performance over 2 weeks, persistent fatigue, mood changes, elevated resting heart rate.
    """

    private let warmupAnswer = """
    **The Jump Athlete Warm-Up** (15–20 minutes)

    **Phase 1 — Tissue Prep (3–5 min)**
    Light jogging, skipping, or jump rope. Raises tissue temperature and begins lubricating joints.

    **Phase 2 — Mobility (5–7 min)**
    • Hip circles: 10 each direction
    • World's Greatest Stretch: 6 each side
    • Ankle rotations: 20 each ankle
    • Leg swings: 15 front-back, 15 side-to-side

    **Phase 3 — Dynamic Activation (4–5 min)**
    • Bodyweight squats: 2 × 10 (focus on full range, explosive up)
    • Glute bridges: 2 × 12
    • Mini-band lateral walks: 2 × 15 steps each direction
    • A-skips: 20 m × 2

    **Phase 4 — Potentiation (2–3 min)**
    • 3–4 submaximal jumps (building to 80–90% effort)
    • 1–2 maximal effort jumps to "wake up" the nervous system

    _Science: A well-designed warm-up improves jump performance by 3–7% compared to no warm-up._
    """

    private let nutritionAnswer = """
    **Sports Nutrition for Jump Athletes**

    **Macronutrient Priorities:**

    🍖 **Protein (1.6–2.2 g/kg bodyweight)**
    Essential for muscle repair and adaptation. Prioritize: chicken, fish, eggs, Greek yogurt, legumes.
    Distribute across 3–5 meals — muscle protein synthesis is maximized with 20–40g doses.

    🍚 **Carbohydrates (3–7 g/kg, activity-dependent)**
    Primary fuel for explosive training. Low carbs = reduced power output.
    Timing: largest portion before and after training.

    🥑 **Fats (0.8–1.2 g/kg)**
    Hormone production (testosterone critical for power), joint health, inflammation control.

    **Key Nutrients for Jumpers:**
    • **Creatine monohydrate**: Most evidence-backed supplement. 3–5g/day improves explosive power 5–15%
    • **Vitamin D**: Muscle function and bone density. Most athletes are deficient.
    • **Magnesium**: Involved in 300+ enzymatic reactions; supports recovery
    • **Omega-3s**: Reduce training inflammation, support neural function

    **Hydration:**
    Even 2% dehydration reduces power output measurably. Drink 35–40 ml/kg bodyweight per day.
    """

    private let airControlAnswer = """
    **Air Control & Body Awareness Mid-Flight**

    What happens after takeoff is determined by physics — but where your body parts are positioned can be trained.

    **The Physics of Flight:**
    Once airborne, your center of mass follows a fixed parabolic trajectory. You cannot change it. But you CAN change your body's orientation around that center.

    **Skills to Develop:**

    🎯 **Tuck Position**
    Knees to chest, compact shape. Used in: trampoline, parkour, safety landing prep.
    Train with: trampoline, pool jumping (safe impact), progressive tuck jumps

    🎯 **Layout Position**
    Body fully extended and rigid in the air. Used in: high jump clearance, long jump flight.
    Train with: foam pit dives, balance beam extensions

    🎯 **Blind Landing Training**
    Practice landing from a turn or after a visual obstruction. Forces proprioceptive reliance.
    Train with: half-turn jumps onto soft surface, eyes-closed balance work

    **Vestibular Training:**
    Spin on a chair and walk immediately. Balance on unstable surfaces. Head-movement coordination exercises. These train your brain to process spatial information faster.
    """

    private let strengthAnswer = """
    **Strength Training for Jumpers** — your power ceiling depends on your strength floor.

    **The Power Equation:**
    Power = Force × Velocity
    Strength training builds the Force component. Plyometrics build the Velocity component.

    **Priority Movements:**

    1. **Back Squat / Front Squat**
       Primary builder of leg power. Target: 1.5–2.0× bodyweight for intermediate jumpers.

    2. **Romanian Deadlift**
       Develops the hamstring and glute strength critical for hip extension at takeoff.

    3. **Hip Thrust**
       Isolates glute function in a position closer to the takeoff movement.

    4. **Single-Leg Squat / Bulgarian Split Squat**
       Addresses bilateral strength imbalances that reduce efficiency.

    5. **Weighted Calf Raises**
       The calves and Achilles are the elastic spring. Build their capacity.

    **Programming Principle:**
    Strength work should not fatigue you before your plyometric work. Option 1: Separate days. Option 2: Heavy strength first, plyos after, reduce plyometric volume.
    """

    private let speedAnswer = """
    **Speed & Sprint Power for Jump Athletes**

    Horizontal speed is directly linked to jumping performance in long jump, parkour, and approach-based athletic jumps.

    **Sprint Mechanics — What Actually Makes You Faster:**

    🔑 **Ground Contact Time**
    Elite sprinters spend 80–90 ms on the ground. Recreational athletes spend 140–180 ms. Plyometric training reduces this.

    🔑 **Horizontal Force Application**
    The direction you push matters most in acceleration. Push back — not down.

    🔑 **Stiffness**
    Stiffer leg = faster ground contact. Ankle and knee stiffness training through reactive hops.

    🔑 **Stride Frequency × Stride Length**
    Both matter. Don't sacrifice one for the other.

    **Training Methods:**
    • Sprint starts: 10 m × 6–8 reps with full recovery
    • Bounding: 30 m × 4–6 reps, focus on horizontal distance
    • Single-leg hops: ankle stiffness development
    • Hill sprints: builds horizontal force application

    **Recovery:** Sprint work is high CNS demand. 48 hours between maximal sprint sessions.
    """

    private let beginnerAnswer = """
    **Getting Started — Jump Training for Beginners**

    Welcome to your athletic journey. Every elite jumper started exactly here.

    **Before You Train:**
    ✓ Can you perform 10 bodyweight squats with proper form?
    ✓ Can you land softly on two feet from a 30 cm height?
    ✓ Is your ankle mobility good enough for a deep squat?
    If no: start with mobility and basic movement quality.

    **Week 1–4 Focus:**
    1. Master the bodyweight squat and single-leg balance
    2. Learn the landing pattern: soft, controlled, quiet
    3. Light jump rope (3 × 1 min) to develop ankle rhythm
    4. Basic bodyweight plyos: squat jumps, broad jumps (3 × 5 reps)

    **The Rule of 10:**
    Never increase volume by more than 10% per week. Tendons adapt slower than muscles. Most jump injuries happen when training load increases too fast.

    **Mindset:**
    Progress in jump training is measurable and motivating. Track your vertical every 4 weeks. Small improvements add up to massive athletic transformation.
    """

    private let injuryPreventionAnswer = """
    **Injury Prevention for Jump Athletes**

    The most dangerous injuries in jumping sports: ACL tears, patellar tendinopathy, ankle sprains, and stress fractures.

    **Prevention Strategies:**

    🛡️ **Landing Mechanics (Biggest Impact)**
    Train soft, bilateral landings. Never let the knee cave inward. Neuromuscular training reduces ACL injury rate by up to 50%.

    🛡️ **Progressive Overload**
    Gradually increase training load. Tendons need 3× longer to adapt than muscles.

    🛡️ **Single-Leg Stability**
    Single-leg balance, single-leg squats, lateral hip work. Asymmetries are injury risk factors.

    🛡️ **Patellar Tendon Protection**
    Avoid jumping when acutely tender. Heavy eccentric decline squats (30° decline) treat and prevent patellar tendinopathy effectively.

    🛡️ **Ankle Strength**
    Inversion sprains account for 40% of sport injuries. Train peroneal strength (banded eversion, single-leg balance on unstable surface).

    **Warning Signals:**
    Never train through sharp pain. Aching soreness = expected. Sharp, localized pain during movement = stop and assess.

    _Always consult a sports medicine professional for persistent pain._
    """

    private let trampolineAnswer = """
    **Trampoline — Building Air Time Mastery**

    Competitive trampoline requires height consistency, travel correction, and positional precision.

    **The Foundation: Straight Jumps**
    Before any tricks, master 10 consecutive straight jumps at consistent height without travelling more than 30 cm. This requires understanding "bed feel" — timing your push with the trampoline's rebound.

    **Positional Skills (Learn in Order):**
    1. **Straight Jump** — arms at sides, body rigid, toes pointed
    2. **Tuck Jump** — knees to chest at peak, open before descent
    3. **Pike Jump** — legs parallel to floor, hands to toes at peak
    4. **Straddle Jump** — legs wide, hands to toes

    **Travel Correction:**
    If you travel toward one end, use a gentle push in the opposite direction on your next bounce. Small corrections work better than large ones.

    **Safety Requirements:**
    Trampoline skills must be learned progressively, ideally with a qualified coach. Foam pit training is standard for learning new skills. Never train alone.

    _Competitive trampolinists train 10–20 hours per week and reach 8–10 m height above the bed._
    """

    private let freerunningAnswer = """
    **Freerunning — Creative Athletic Expression**

    Freerunning builds on parkour's efficiency and adds acrobatic creativity. The philosophy: movement is art.

    **Prerequisite Check Before Any Flips:**
    ✓ Consistent backward roll on flat ground
    ✓ Back walkover (demonstrates spinal mobility and awareness)
    ✓ Round-off (builds the rotation habit)
    ✓ Working gymnastics backflip on trampoline or into foam pit

    **Entry-Level Freerunning Elements:**
    • **Aerial Cartwheel** — no-hands cartwheel; first "trick" to learn safely
    • **Webster (Front Flip from One Foot)** — requires trampoline training first
    • **Side Flip** — rotates laterally; teach on incline first
    • **Gainers** — backflip from one foot; spectacular, dangerous if rushed

    **Critical Safety Rule:**
    Every flip skill is learned in a progression: trampoline → foam pit → crash mat on floor → real environment. Skipping steps creates catastrophic injury risk.

    **Physical Requirements:**
    Strong core, excellent spatial awareness, flexible hips and spine, and confidence in basic bodyweight strength (muscle-ups, handstands).
    """

    private let programAnswer = """
    **Designing Your Jump Training Program**

    **8-Week Beginner Program Structure:**

    🗓 **Days per week:** 3 (Mon, Wed, Fri)
    📈 **Weeks 1–4:** Strength foundation + low-intensity plyos
    📈 **Weeks 5–8:** Moderate plyos + sport-specific movements

    **Session Structure (60–75 min):**
    1. Warm-up (15 min)
    2. Plyometrics (15–20 min, early in session when fresh)
    3. Strength work (25–30 min)
    4. Mobility/recovery (10–15 min)

    **Volume Guidelines:**
    • Beginners: 60–100 plyometric foot contacts/session
    • Intermediate: 120–150 contacts/session
    • Advanced: 150–250+ contacts/session (only with experience)

    **Testing Protocol:**
    Test vertical jump, standing broad jump, and reaction time every 4 weeks. This gives you objective feedback and massive motivation when you see improvement.

    **Recovery:**
    Never do two maximal plyometric sessions in a row. CNS fatigue blunts explosive adaptation.

    _Your Progression Map in the app shows your personalized pathway based on current level._
    """

    private let biomechanicsAnswer = """
    **Sports Biomechanics of Jumping**

    **The Ground Reaction Force:**
    To jump, you push the ground down — the ground pushes you up (Newton's Third Law). Elite jumpers generate 3–5× bodyweight force in under 200 milliseconds.

    **Key Concepts:**

    📐 **Takeoff Angle**
    Optimal angle varies by event:
    • Vertical jump: 80–90° from horizontal
    • Long jump: 18–25° (constrained by approach speed)
    • Triple jump: 15–20°

    ⚡ **Rate of Force Development (RFD)**
    The speed at which force is applied. In jumps under 250 ms, RFD matters more than maximum force. This is why plyometrics are essential — they train RFD specifically.

    🔄 **Stretch-Shortening Cycle (SSC)**
    Pre-stretch (eccentric) → isometric → concentric.
    Tendons store elastic energy during the eccentric phase.
    Short amortization (isometric) phase = more energy returned.
    Long amortization = energy lost as heat.

    📏 **Center of Mass Trajectory**
    Once airborne, your CoM follows a parabola determined at takeoff. The only variable is your body position around the CoM.

    🧠 **Neuromuscular Efficiency**
    Motor unit recruitment, synchronization, and rate coding determine how close you get to your theoretical power maximum. These improve with training.
    """

    private let defaultAnswer = """
    **Roo Jumper AI Coach** is ready to help you with your athletic development.

    Here are some questions I can answer in depth:

    🏃 **Training**
    • "How do I jump higher?"
    • "What are the best plyometric exercises?"
    • "How do I start training as a beginner?"
    • "Design me a training program"

    🔬 **Science**
    • "How does the stretch-shortening cycle work?"
    • "What muscles are most important for jumping?"
    • "How does plyometric training improve explosiveness?"
    • "What is Rate of Force Development?"

    ⚽ **Sports-Specific**
    • "How do basketball players train their vertical?"
    • "How does the Fosbury Flop work in high jump?"
    • "What are the parkour basics?"
    • "How does volleyball approach jumping work?"

    🛡️ **Performance & Health**
    • "How do I land safely to prevent injuries?"
    • "What should I eat for explosive training?"
    • "How important is recovery?"

    Ask me anything about jumping, explosiveness, and athletic performance!
    """
}

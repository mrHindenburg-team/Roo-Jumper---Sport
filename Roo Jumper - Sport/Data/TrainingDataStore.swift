import Foundation

// Central source-of-truth for all static sports content built into the app.
enum TrainingDataStore {

    // MARK: - Sport Disciplines

    static let disciplines: [SportDiscipline] = [
        SportDiscipline(
            name: "Vertical Jump Training",
            subtitle: "Master your takeoff power",
            description: "A systematic program designed to maximize vertical leap through integrated strength, power, and technique development. The vertical jump is not a single action — it is the result of five sequentially coordinated events: approach, dip (countermovement), triple extension, arm swing, and peak flight position.\n\nThe countermovement phase pre-stretches the quadriceps and glutes, storing elastic energy that is released on takeoff. Training must target both this elastic system and raw concentric strength to develop a complete jumper.\n\nBeginners should prioritize landing mechanics, hip extension strength, and basic plyometric exposure. Intermediate athletes add reactive strength work (depth jumps, bounding). Advanced athletes focus on rate of force development — the ability to express strength in under 200 ms, which is the real limiter at elite levels.",
            iconName: "arrow.up.circle.fill",
            category: .training,
            difficulty: .beginner,
            keyMuscles: ["Quadriceps", "Glutes", "Calves", "Hip Flexors", "Core"],
            coreSkills: ["Triple Extension", "Arm Swing Timing", "Countermovement Depth", "Reactive Force", "Landing Mechanics", "Force Production Rate"],
            scienceFact: "Elite vertical jumpers generate ground reaction forces 3–5× their body weight in under 200 milliseconds. The fastest athletes reach peak force in as little as 80 ms — faster than the blink reflex."
        ),
        SportDiscipline(
            name: "Plyometrics",
            subtitle: "Explosive power training",
            description: "Science-backed plyometric progressions from foundational ankle stiffness exercises through advanced depth jumps, bounds, and reactive landings. Plyometrics work by training the stretch-shortening cycle (SSC) — the rapid sequence of eccentric loading followed by explosive concentric contraction.\n\nThe Achilles tendon stores up to 35 joules of elastic energy per step at full sprint speeds. Plyometric training increases tendon stiffness and the speed at which the SSC transitions from loading to release — this is what separates sprinters from joggers and elite jumpers from recreational athletes.\n\nPly training is divided into three levels:\n• Low intensity: ankle bounces, squat jumps, light box jumps\n• Medium intensity: depth jumps under 40 cm, bounding, tuck jumps\n• High intensity: depth jumps from 60–80 cm, hurdle hops, resisted bounds\n\nVolume must be managed carefully — the Achilles and patellar tendons adapt slower than muscle. More is not better; smarter loading is.",
            iconName: "bolt.fill",
            category: .training,
            difficulty: .intermediate,
            keyMuscles: ["Gastrocnemius", "Soleus", "Quadriceps", "Glutes", "Core", "Achilles Tendon"],
            coreSkills: ["Stretch-Shortening Cycle", "Ankle Stiffness Control", "Ground Contact Time", "Rate of Force Development", "Reactive Strength Index", "Tendon Load Management"],
            scienceFact: "The stretch-shortening cycle stores elastic energy in tendons, returning up to 93% as kinetic energy during rapid jumps. The Achilles tendon can store and release energy at a rate equivalent to a 500W motor — more powerful than most electric bicycles."
        ),
        SportDiscipline(
            name: "Long Jump",
            subtitle: "Speed, flight & landing",
            description: "Complete technical breakdown of the long jump from sprint approach through takeoff, flight position, and two-footed Hitch-kick landing.",
            iconName: "arrow.right.circle.fill",
            category: .trackField,
            difficulty: .intermediate,
            keyMuscles: ["Quadriceps", "Hip Flexors", "Glutes", "Hamstrings", "Core"],
            coreSkills: ["Sprint Mechanics", "Penultimate Step", "Flat-Foot Takeoff", "Hitch-Kick Technique"],
            scienceFact: "Mike Powell's world record of 8.95 m required a takeoff velocity of ~9.5 m/s at a 22° angle."
        ),
        SportDiscipline(
            name: "High Jump",
            subtitle: "The Fosbury revolution",
            description: "Master the Fosbury Flop — the most technically sophisticated jumping event in athletics. Dick Fosbury's 1968 Olympic gold medal performance changed jumping forever: by going over backwards, the athlete can clear a bar set above their center of mass because the body arches around the bar while the center of mass passes below it.\n\nThe high jump has five distinct technical phases, each requiring precision:\n\n1. Approach Run: 7–9 strides in a J-curved path. Begins straight, curves to create inward lean\n2. Penultimate Step: The second-to-last stride is long and low — this drops the hips to generate upward projection at takeoff\n3. Takeoff: Single-leg plant. The curved approach means the body has inward lean that the penultimate step converts to vertical force\n4. Bar Clearance: Back arches, hips push upward, legs trail. Head clears first, then shoulders, hips, and legs sequentially\n5. Landing: On the upper back and shoulders. The foam pit absorbs the impact at heights up to 2.40 m\n\nThe J-run is the most practiced element — world-class athletes drill their curve approach 40–80 times per session.",
            iconName: "arrow.up.right.circle.fill",
            category: .trackField,
            difficulty: .advanced,
            keyMuscles: ["Glutes", "Hamstrings", "Hip Flexors", "Core", "Shoulder Girdle", "Hip Abductors"],
            coreSkills: ["J-Run Approach", "Penultimate Step Mechanics", "Inward Lean Conversion", "Bar Clearance Arch", "Hip Lift Timing", "Back Landing"],
            scienceFact: "A 2.00 m clearance requires the athlete's centre of mass to actually pass below the bar — a physics trick made possible by the Fosbury arch. The world record of 2.45 m (Javier Sotomayor, 1993) has stood for over 30 years."
        ),
        SportDiscipline(
            name: "Basketball Jumping",
            subtitle: "Court explosiveness",
            description: "Basketball demands two completely different types of jumps — and elite players are masters of both. The one-foot takeoff (layup, post move, fast-break finish) uses a running approach to maximize horizontal momentum, converting it to vertical force through a rapid penultimate step plant. The two-foot takeoff (standing jump shot, rebound tip) is a pure concentric power expression from a stationary or slowing position.\n\nMost recreational players only train bilateral jumping, leaving significant one-foot performance on the table. This module covers:\n\n• Off-dribble launch mechanics: how to gather, load, and explode from live-ball movement\n• Running one-foot takeoff: approach angle, penultimate step, free-leg drive\n• Two-foot power jump: countermovement depth, triple extension timing, peak height\n• Body control in the air: spatial awareness for finishes around defenders\n• Soft landing protocols: reducing knee injury risk on high-frequency court jumping\n\nThe goal is a complete jumping toolkit that works from any court position, any movement context.",
            iconName: "basketball.fill",
            category: .courtSports,
            difficulty: .beginner,
            keyMuscles: ["Quadriceps", "Glutes", "Calves", "Hip Abductors", "Core", "Hamstrings"],
            coreSkills: ["One-Foot Running Takeoff", "Two-Foot Power Jump", "Off-Dribble Launch", "Aerial Body Control", "Soft Bilateral Landing", "Approach Angle Optimization"],
            scienceFact: "NBA players average 70+ explosive jump actions per game; elite players maintain 90% of their vertical peak even in the fourth quarter — a product of reactive strength training, not just maximum strength."
        ),
        SportDiscipline(
            name: "Volleyball Jumping",
            subtitle: "Attack & block power",
            description: "Volleyball-specific approach jump mechanics, block timing, reading the setter, arm swing sequencing, and landing protocols for injury prevention.",
            iconName: "volleyball.fill",
            category: .courtSports,
            difficulty: .intermediate,
            keyMuscles: ["Glutes", "Quadriceps", "Core", "Shoulders", "Calves"],
            coreSkills: ["4-Step Approach", "Penultimate Plant", "Arm Swing Timing", "Block Footwork"],
            scienceFact: "Elite volleyball attackers contact the ball 3.0–3.5 m above the floor, requiring approach run speeds of 4–5 m/s."
        ),
        SportDiscipline(
            name: "Parkour Basics",
            subtitle: "Urban movement foundations",
            description: "Safe introduction to parkour: precision landings, safety rolls, basic vaults, stride jumps, and fundamental body control for urban environments.",
            iconName: "figure.run",
            category: .urban,
            difficulty: .intermediate,
            keyMuscles: ["Full-Body Integration", "Core", "Shoulders", "Quads", "Calves"],
            coreSkills: ["Precision Landing", "Kong Vault", "Safety Roll", "Stride Jump", "Cat Leap"],
            scienceFact: "Precision landings dissipate landing forces over time through coordinated ankle-knee-hip flexion, reducing peak stress by 40%."
        ),
        SportDiscipline(
            name: "Athletic Explosiveness",
            subtitle: "Pure power development",
            description: "Maximum explosive power is governed by a different physiological system than maximum strength. An athlete can squat 200 kg and still be a mediocre jumper if their rate of force development (RFD) — the speed at which they can express force — is slow. This program targets RFD directly.\n\nThe training methods used here are the same ones employed by Olympic sprinters, high jumpers, and power lifters in the acceleration phase of their competition prep:\n\n• Olympic lifting derivatives: hang cleans, power cleans, jump shrugs — the fastest way to train triple extension under load\n• Accentuated eccentric loading: using 110–120% of concentric max during the lowering phase to build eccentric strength above the concentric ceiling\n• Contrast training: heavy strength set immediately followed by an explosive plyometric — induces post-activation potentiation (PAP)\n• Overspeed methods: band assistance, downhill bounds — training the nervous system to fire faster than unassisted max effort allows\n• CNS management: high intensity, low volume, full recovery — power is not built through fatigue",
            iconName: "flame.fill",
            category: .conditioning,
            difficulty: .advanced,
            keyMuscles: ["Full Posterior Chain", "Glutes", "Hamstrings", "Calves", "Core", "Traps"],
            coreSkills: ["Power Clean Derivative", "Jump Shrug", "Band-Assisted Jumps", "Accentuated Eccentric Loading", "Post-Activation Potentiation", "Contrast Training", "CNS Load Management"],
            scienceFact: "Rate of force development (RFD) — the amount of force produced in the first 100 ms of contraction — is the primary determinant of explosive athletic performance. Training can increase RFD by 30–50% independently of maximum strength gains."
        ),
        SportDiscipline(
            name: "Freerunning Foundations",
            subtitle: "Flow state movement",
            description: "Creative movement combining parkour efficiency with acrobatic expression. Covers aerial basics, wall runs, speed vaults, and introductory flips.",
            iconName: "figure.gymnastics",
            category: .urban,
            difficulty: .elite,
            keyMuscles: ["Full-Body", "Core", "Shoulders", "Hip Flexors", "Wrists"],
            coreSkills: ["Aerial Control", "Wall Run", "Sideflip Entry", "Speed Vault Flow", "Tuck Jump to Handstand"],
            scienceFact: "Freerunning requires proprioceptive processing 3–4× faster than everyday walking, training the cerebellum for rapid motor adaptation.",
            isPremium: true,
            premiumPack: .extremeMotionPack
        ),
        SportDiscipline(
            name: "Trampoline Discipline",
            subtitle: "Air time mastery",
            description: "Competitive trampoline skills: bed control, travel correction, tuck/pike/layout positions, height consistency, and intro to twist mechanics.",
            iconName: "figure.jumprope",
            category: .gymnastics,
            difficulty: .advanced,
            keyMuscles: ["Core", "Glutes", "Hip Flexors", "Shoulders", "Proprioceptors"],
            coreSkills: ["Bed Control", "Straight Jump", "Tuck Jump", "Pike Jump", "Half-Twist", "Travel Correction"],
            scienceFact: "Competitive trampolinists reach heights of 8–10 m above the trampoline bed; landing impact at these heights exceeds 10× body weight.",
            isPremium: true,
            premiumPack: .extremeMotionPack
        ),
        SportDiscipline(
            name: "Sprint Power",
            subtitle: "First-step explosion",
            description: "Acceleration mechanics, starting-position power, horizontal force application, and the biomechanics of maximum sprint speed relevant to all jumping sports.",
            iconName: "hare.fill",
            category: .trackField,
            difficulty: .advanced,
            keyMuscles: ["Glutes", "Hamstrings", "Hip Flexors", "Calves", "Core"],
            coreSkills: ["Block Start", "Drive Phase Mechanics", "Shin Angle", "Ground Contact Optimization"],
            scienceFact: "Horizontal force production in the first 10 m of a sprint is more predictive of 100 m time than maximum velocity.",
            isPremium: true,
            premiumPack: .extremeMotionPack
        ),
        SportDiscipline(
            name: "Air Awareness",
            subtitle: "Body control mid-flight",
            description: "Develop spatial awareness in the air: tuck positions, layout positions, blind landings, rotation stopping, and in-air orientation drills.",
            iconName: "wind",
            category: .conditioning,
            difficulty: .intermediate,
            keyMuscles: ["Core", "Hip Flexors", "Shoulders", "Vestibular System"],
            coreSkills: ["Tuck Position", "Layout", "In-Air Rotation Control", "Blind Landing", "Spotting"],
            scienceFact: "The vestibular system requires 80–120 ms to process orientation changes; training reduces this lag, improving mid-air adjustments."
        )
    ]

    // MARK: - Exercises

    static let exercises: [Exercise] = [
        // --- Plyometric ---
        Exercise(
            name: "Box Jumps",
            category: .plyometric,
            description: "Explosive jump onto a box, focusing on maximum effort and soft landing.",
            sets: 4, repsDisplay: "6 reps",
            restSeconds: 90,
            muscleGroups: ["Quads", "Glutes", "Calves"],
            coachingCues: [
                "Swing arms back during the dip",
                "Triple-extend (ankle, knee, hip) simultaneously",
                "Land softly — absorb impact through all three joints",
                "Step down — never drop off backwards"
            ],
            difficulty: .intermediate, xpReward: 75
        ),
        Exercise(
            name: "Depth Jumps",
            category: .plyometric,
            description: "Step off a box and immediately re-jump for maximum reactive power. Advanced reactive strength drill.",
            sets: 4, repsDisplay: "5 reps",
            restSeconds: 120,
            muscleGroups: ["Calves", "Quads", "Glutes", "Tendons"],
            coachingCues: [
                "Step off — do NOT jump off",
                "Minimize ground contact time",
                "Drive arms explosively upward",
                "Land and immediately jump — treat the ground like a hot surface"
            ],
            difficulty: .advanced, xpReward: 100
        ),
        Exercise(
            name: "Squat Jumps",
            category: .plyometric,
            description: "Bodyweight squat into maximum vertical jump. Great for developing concentric power.",
            sets: 4, repsDisplay: "8 reps",
            restSeconds: 75,
            muscleGroups: ["Quads", "Glutes", "Calves"],
            coachingCues: [
                "Descend to parallel — no lower",
                "Brief pause at bottom builds tension",
                "Drive through the full range and leave the ground",
                "Soft landing — hips back"
            ],
            difficulty: .beginner, xpReward: 50
        ),
        Exercise(
            name: "Broad Jumps",
            category: .plyometric,
            description: "Standing broad jump for horizontal power and takeoff angle development.",
            sets: 3, repsDisplay: "5 reps",
            restSeconds: 75,
            muscleGroups: ["Quads", "Glutes", "Hip Flexors"],
            coachingCues: [
                "Aggressive arm swing creates momentum",
                "45° takeoff angle is optimal",
                "Drive hips forward — don't sit back at takeoff",
                "Land balanced on two feet simultaneously"
            ],
            difficulty: .beginner, xpReward: 50
        ),
        Exercise(
            name: "Tuck Jumps",
            category: .plyometric,
            description: "Maximum height jump bringing knees to chest. Develops explosion and air-time coordination.",
            sets: 3, repsDisplay: "6 reps",
            restSeconds: 75,
            muscleGroups: ["Quads", "Glutes", "Hip Flexors", "Core"],
            coachingCues: [
                "Explode as high as possible first",
                "Pull knees to chest — don't bring chest to knees",
                "Maintain upright torso",
                "Stick the landing — quiet feet"
            ],
            difficulty: .intermediate, xpReward: 65
        ),
        Exercise(
            name: "Single-Leg Hops",
            category: .plyometric,
            description: "Repeated hops on one leg developing unilateral explosive power and ankle stiffness.",
            sets: 3, repsDisplay: "10 reps each leg",
            restSeconds: 60,
            muscleGroups: ["Calves", "Quads", "Glutes", "Ankle Stabilizers"],
            coachingCues: [
                "Maintain stiff ankle — don't roll through the foot",
                "Keep ground contact time minimal",
                "Arms in short, fast rhythm",
                "Slight forward lean — don't jump straight up"
            ],
            difficulty: .intermediate, xpReward: 65
        ),
        Exercise(
            name: "Bounding",
            category: .plyometric,
            description: "Alternating long strides maximizing ground coverage and horizontal force production.",
            sets: 4, repsDisplay: "20 m",
            restSeconds: 90,
            muscleGroups: ["Glutes", "Hamstrings", "Hip Flexors", "Calves"],
            coachingCues: [
                "Exaggerate your running stride",
                "Opposite arm and leg — powerful arm drive",
                "Spend time in the air — think 'float'",
                "Push the ground backward, not downward"
            ],
            difficulty: .intermediate, xpReward: 70
        ),
        Exercise(
            name: "Reactive Jumps (10/10)",
            category: .plyometric,
            description: "10 maximal jumps in 10 seconds. Tests reactive strength index and power endurance.",
            sets: 3, repsDisplay: "10 in 10 sec",
            restSeconds: 120,
            muscleGroups: ["Full Lower Body", "Core"],
            coachingCues: [
                "Every single rep is maximum effort",
                "No rest at the bottom — continuously reactive",
                "Count your jumps — track consistency",
                "Arms help. Don't forget them."
            ],
            difficulty: .advanced, xpReward: 90
        ),

        // --- Strength ---
        Exercise(
            name: "Bulgarian Split Squats",
            category: .strength,
            description: "Rear-foot elevated split squat targeting single-leg strength imbalances critical for jumping.",
            sets: 3, repsDisplay: "10 reps each leg",
            restSeconds: 90,
            muscleGroups: ["Quads", "Glutes", "Hip Flexors", "Balance"],
            coachingCues: [
                "Front foot far enough forward to keep shin vertical",
                "Rear foot high — toes relaxed on surface",
                "Descend until front thigh is parallel",
                "Drive up through front heel"
            ],
            difficulty: .intermediate, xpReward: 70
        ),
        Exercise(
            name: "Romanian Deadlifts",
            category: .strength,
            description: "Hip-hinge movement building posterior chain strength critical for explosive jumping.",
            sets: 4, repsDisplay: "8 reps",
            restSeconds: 90,
            muscleGroups: ["Hamstrings", "Glutes", "Lower Back", "Core"],
            coachingCues: [
                "Push hips back — not down",
                "Maintain a proud chest and neutral spine",
                "Feel the hamstring stretch — that's the cue to return",
                "Drive hips forward to stand — glutes squeeze at top"
            ],
            difficulty: .intermediate, xpReward: 70
        ),
        Exercise(
            name: "Hip Thrusts",
            category: .strength,
            description: "Glute-dominant hip extension isolating the primary mover in vertical jumping.",
            sets: 3, repsDisplay: "12 reps",
            restSeconds: 75,
            muscleGroups: ["Glutes", "Hamstrings", "Core"],
            coachingCues: [
                "Upper back rests on bench — not neck",
                "Drive through heels",
                "Posterior pelvic tilt at the top — squeeze hard",
                "Controlled descent — resist gravity"
            ],
            difficulty: .beginner, xpReward: 55
        ),
        Exercise(
            name: "Calf Raises (Weighted)",
            category: .strength,
            description: "High-rep calf hypertrophy work developing the elastic engine of jumping.",
            sets: 4, repsDisplay: "20 reps",
            restSeconds: 60,
            muscleGroups: ["Gastrocnemius", "Soleus", "Achilles Tendon"],
            coachingCues: [
                "Full range of motion — deep stretch to max height",
                "3-second eccentric (down), 1-second pause at bottom",
                "Explosive concentric (up)",
                "Single-leg variation is best for advanced athletes"
            ],
            difficulty: .beginner, xpReward: 45
        ),

        // --- Mobility ---
        Exercise(
            name: "Hip Flexor Mobility Flow",
            category: .mobility,
            description: "Dynamic hip flexor sequence improving takeoff angle and stride length.",
            sets: 2, repsDisplay: "8 reps each side",
            restSeconds: 30,
            durationSeconds: 300,
            muscleGroups: ["Hip Flexors", "Psoas", "TFL"],
            coachingCues: [
                "Enter lunge position gently",
                "Posterior pelvic tilt removes anterior lumbar curve",
                "Add thoracic rotation at end range",
                "Move rhythmically — mobility is motion"
            ],
            difficulty: .beginner, xpReward: 35
        ),
        Exercise(
            name: "Ankle Mobility Circles",
            category: .mobility,
            description: "Rotational ankle work improving dorsiflexion range essential for deep, powerful squats and landings.",
            sets: 2, repsDisplay: "20 circles each ankle",
            restSeconds: 0,
            durationSeconds: 180,
            muscleGroups: ["Ankle", "Achilles", "Tibialis Anterior"],
            coachingCues: [
                "Large, slow circles",
                "Load the ankle gently — don't just swing the foot",
                "Feel for end-range stiffness and linger there",
                "Progress to loaded calf raises to transfer mobility to strength"
            ],
            difficulty: .beginner, xpReward: 25
        ),
        Exercise(
            name: "World's Greatest Stretch",
            category: .mobility,
            description: "Combines hip flexor, thoracic spine, and hamstring mobility in a single flowing movement.",
            sets: 2, repsDisplay: "6 reps each side",
            restSeconds: 30,
            durationSeconds: 240,
            muscleGroups: ["Hip Flexors", "Thoracic Spine", "Hamstrings", "Groin"],
            coachingCues: [
                "Forward lunge → elbow to floor → rotate to sky",
                "Move slowly through each phase",
                "Breathe into restriction — don't force",
                "Progress speed as range improves"
            ],
            difficulty: .beginner, xpReward: 30
        ),

        // --- Coordination ---
        Exercise(
            name: "Jump Rope — Double-Under",
            category: .coordination,
            description: "Two rope passes per jump developing rhythm, timing, and explosive calf-ankle action.",
            sets: 4, repsDisplay: "15 reps",
            restSeconds: 60,
            muscleGroups: ["Calves", "Wrists", "Core", "Timing"],
            coachingCues: [
                "Single jump first to find the timing",
                "Efficient wrist flick — not full arm circles",
                "Quick, explosive jump — the rope does two passes while you're briefly airborne",
                "Eyes forward — not at the rope"
            ],
            difficulty: .intermediate, xpReward: 60
        ),
        Exercise(
            name: "Lateral Bounds",
            category: .coordination,
            description: "Single-leg lateral jumps developing frontal-plane stability and lateral explosive force.",
            sets: 3, repsDisplay: "8 reps each side",
            restSeconds: 60,
            muscleGroups: ["Glutes", "Adductors", "Calves", "Hip Abductors"],
            coachingCues: [
                "Single-leg launch → single-leg landing",
                "Stick the landing — 2-second hold",
                "Progress width over time",
                "Knee tracks over second toe — no valgus collapse"
            ],
            difficulty: .intermediate, xpReward: 65
        ),

        // --- Recovery ---
        Exercise(
            name: "Foam Roll — Posterior Chain",
            category: .recovery,
            description: "Targeted SMR (self-myofascial release) for glutes, hamstrings, and calves post-training.",
            sets: 1, repsDisplay: "60 sec per area",
            restSeconds: 0,
            durationSeconds: 600,
            muscleGroups: ["Glutes", "Hamstrings", "Calves", "IT Band"],
            coachingCues: [
                "Find a tender spot and pause for 30 seconds",
                "Slow down — don't just roll quickly",
                "Cross-fiber technique on stubborn areas",
                "Breathe through tension — stay relaxed"
            ],
            difficulty: .beginner, xpReward: 20
        ),
        Exercise(
            name: "Contract-Relax Hamstring Stretch",
            category: .recovery,
            description: "PNF stretching protocol scientifically proven to improve hamstring flexibility faster than static stretching.",
            sets: 3, repsDisplay: "6 reps each leg",
            restSeconds: 30,
            durationSeconds: 360,
            muscleGroups: ["Hamstrings", "Glutes"],
            coachingCues: [
                "Lift leg to comfortable stretch position",
                "Push against a partner or band for 6 seconds",
                "Relax completely — move into new range",
                "Repeat — expect 2–5° extra range per cycle"
            ],
            difficulty: .beginner, xpReward: 25
        ),

        // --- Technique ---
        Exercise(
            name: "Approach Run Drill (Long Jump)",
            category: .technique,
            description: "Marks calibration and rhythm development for consistent takeoff board contact in long jump.",
            sets: 6, repsDisplay: "1 full run",
            restSeconds: 120,
            muscleGroups: ["Hip Flexors", "Quads", "Calves", "Full Sprint Musculature"],
            coachingCues: [
                "Count strides — mark at 3, 7, and 11 steps",
                "Penultimate step long — lowers center of mass",
                "Final step short — generates upward projection",
                "Don't look at the board — feel it"
            ],
            difficulty: .advanced, xpReward: 85
        ),
        Exercise(
            name: "J-Run Pattern (High Jump)",
            category: .technique,
            description: "Curved approach run developing inward lean, centrifugal force, and optimal takeoff angle for the Fosbury Flop. The J-run is the defining technical element that separates recreational jumpers from elite high jumpers — it allows the body to convert horizontal momentum into vertical lift by exploiting centrifugal lean.",
            sets: 8, repsDisplay: "1 full approach",
            restSeconds: 90,
            muscleGroups: ["Hip Abductors", "Calves", "Glutes", "Core"],
            coachingCues: [
                "Curve starts 5 strides from takeoff",
                "Lean into the curve — body at 15–20° from vertical",
                "Penultimate step drops center of mass — long step, low hips",
                "Final step short and powerful — converts lean to vertical lift",
                "Plant foot pointed away from the bar — toes at 45°",
                "Drive the inside knee skyward at takeoff"
            ],
            difficulty: .advanced, isPremium: true, premiumPack: .eliteExplosivenessPack, xpReward: 90
        ),

        // --- Plyometric (additional) ---
        Exercise(
            name: "Hurdle Hops",
            category: .plyometric,
            description: "Continuous two-foot jumps over a series of mini-hurdles at 30–40 cm height. Trains rhythmic power output and the ability to maintain explosive stiffness across multiple contacts — directly transferring to repeated jump sports like basketball and volleyball.",
            sets: 4, repsDisplay: "6 hurdles",
            restSeconds: 90,
            muscleGroups: ["Calves", "Quads", "Glutes", "Achilles Tendon"],
            coachingCues: [
                "Land on the balls of both feet simultaneously",
                "Knees slightly bent on contact — not straight, not deeply bent",
                "Minimal ground contact — think of the floor as hot",
                "Arms pump in rhythm with each jump",
                "Keep eyes level — don't look down at hurdles"
            ],
            difficulty: .intermediate, xpReward: 80
        ),
        Exercise(
            name: "Ankle Bounce Drill",
            category: .plyometric,
            description: "Rapid bilateral ankle stiffness drill performed with nearly straight knees. Develops the soleus–Achilles spring mechanism responsible for elastic energy return during sprint acceleration and jumping takeoff. Often called 'pogo hops.'",
            sets: 4, repsDisplay: "20 reps",
            restSeconds: 60,
            muscleGroups: ["Soleus", "Achilles Tendon", "Tibialis Anterior", "Calves"],
            coachingCues: [
                "Knees almost fully extended throughout — this isolates ankles",
                "Very small range of motion — the power comes from speed, not size",
                "Think of legs as rigid springs — don't let them buckle",
                "Arms relaxed at sides or hands on hips",
                "Progress to single-leg variant once 20 reps feel effortless"
            ],
            difficulty: .beginner, xpReward: 45
        ),
        Exercise(
            name: "Triple-Jump Bounding",
            category: .plyometric,
            description: "Full triple-jump bounding sequence (hop–step–jump) developing sequential single-leg power, transition speed, and horizontal force application. Used by sprinters and track athletes to build explosive hip extension across linked contacts.",
            sets: 4, repsDisplay: "3-contact sequence",
            restSeconds: 120,
            muscleGroups: ["Glutes", "Hamstrings", "Hip Flexors", "Calves", "Quads"],
            coachingCues: [
                "Hop: same foot takeoff and landing — push the ground back",
                "Step: opposite foot landing — maintain forward lean",
                "Jump: two-foot takeoff — maximize height and distance",
                "Cycle the free leg fast to maintain momentum between contacts",
                "Land each contact on the ball of the foot, not the heel"
            ],
            difficulty: .advanced, xpReward: 95
        ),
        Exercise(
            name: "Seated Box Jumps",
            category: .plyometric,
            description: "Jump from a seated position on a bench, eliminating the countermovement phase. This isolates pure concentric leg power and is the single best test and trainer of starting strength. Used by elite strength coaches to identify and fix power-production weaknesses.",
            sets: 5, repsDisplay: "4 reps",
            restSeconds: 120,
            muscleGroups: ["Quads", "Glutes", "Hip Extensors", "Core"],
            coachingCues: [
                "Sit at 90° hip and knee angle — don't lean back",
                "Arms load back while seated, then swing explosively at go",
                "Drive through both feet simultaneously — no rocking or rocking momentum",
                "Full effort every rep — this exercise has no momentum assistance",
                "Increase box height to progress, never decrease rest"
            ],
            difficulty: .advanced, xpReward: 95
        ),
        Exercise(
            name: "Speed Skater Bounds",
            category: .plyometric,
            description: "Lateral explosive bounds mimicking a speed skater's pushing mechanics. Develops frontal-plane power, hip abductor strength, and single-leg landing control — essential for change-of-direction sports and unilateral explosive performance.",
            sets: 3, repsDisplay: "10 reps each side",
            restSeconds: 75,
            muscleGroups: ["Glutes", "Hip Abductors", "Quads", "Calves", "Ankle Stabilizers"],
            coachingCues: [
                "Push laterally off the standing leg — not downward",
                "Reach the swing leg far to the side to maximize width",
                "Land on a single foot and immediately stabilize",
                "Lean your torso slightly forward — like a speed skater",
                "Keep the landing knee tracking over the second toe"
            ],
            difficulty: .intermediate, xpReward: 70
        ),

        // --- Strength (additional) ---
        Exercise(
            name: "Hex Bar Deadlift",
            category: .strength,
            description: "Total lower-body pulling strength using a trap/hex bar. The neutral grip and center-of-mass loading make this the safest and most effective deadlift variant for jump athletes — it develops hip and knee extension simultaneously without the lumbar stress of a conventional bar.",
            sets: 4, repsDisplay: "5 reps",
            restSeconds: 120,
            muscleGroups: ["Glutes", "Hamstrings", "Quads", "Traps", "Core", "Spinal Erectors"],
            coachingCues: [
                "Hips above knees, chest above hips at setup",
                "Push the floor away — think leg press, not hip hinge",
                "Neutral spine throughout — lock it in before lifting",
                "Bar stays close to body — zero drift",
                "Full extension at top — glutes squeezed hard"
            ],
            difficulty: .intermediate, xpReward: 80
        ),
        Exercise(
            name: "Front Squat",
            category: .strength,
            description: "Barbell squat with the bar across the front deltoids. The forward lean penalty forces an upright torso and maximizes quadriceps recruitment — the primary muscle group for rapid knee extension during jump takeoff. More transferable to athletic jumping than the back squat.",
            sets: 4, repsDisplay: "6 reps",
            restSeconds: 120,
            muscleGroups: ["Quadriceps", "Glutes", "Core", "Upper Back", "Wrists"],
            coachingCues: [
                "Clean grip or crossed-arm position — elbows high throughout",
                "Initiate descent by breaking hips and knees simultaneously",
                "Keep torso vertical — falling forward means too much weight",
                "Drive elbows up as you ascend to prevent bar rollback",
                "Full depth — crease of hip below top of knee"
            ],
            difficulty: .advanced, xpReward: 85
        ),
        Exercise(
            name: "Nordic Hamstring Curl",
            category: .strength,
            description: "Eccentric-dominant hamstring exercise anchoring ankles and lowering the body under control. Proven in research to reduce hamstring strain injury by up to 51% in team sports. Builds the deceleration strength needed for safe landing mechanics and sprint performance.",
            sets: 3, repsDisplay: "5 reps (lower only)",
            restSeconds: 90,
            muscleGroups: ["Hamstrings", "Glutes", "Core"],
            coachingCues: [
                "Anchor feet under a heavy object or have a partner hold",
                "Body straight from knee to shoulder — maintain a plank position",
                "Lower as slowly as possible — fight gravity with hamstrings",
                "When you fail, catch on hands, push back up, repeat the lower",
                "Build to 8–10 slow lowering reps over 6–8 weeks"
            ],
            difficulty: .advanced, xpReward: 85
        ),
        Exercise(
            name: "Single-Leg Calf Raise",
            category: .strength,
            description: "Unilateral calf raise developing the soleus and gastrocnemius independently. Single-leg loading applies approximately 2× the stimulus of bilateral raises and addresses side-to-side strength imbalances that often cause Achilles tendon issues and asymmetric takeoffs.",
            sets: 3, repsDisplay: "15 reps each leg",
            restSeconds: 60,
            muscleGroups: ["Gastrocnemius", "Soleus", "Achilles Tendon", "Tibialis Anterior"],
            coachingCues: [
                "Stand on step edge with heel hanging off — full range of motion",
                "3-second eccentric (lower), 1-second pause at bottom",
                "Explosive concentric (rise) — feel the push from arch to toe",
                "Hold weight in opposite hand for progressive overload",
                "Bent-knee variant (seated equivalent) targets soleus more"
            ],
            difficulty: .intermediate, xpReward: 55
        ),
        Exercise(
            name: "Resistance Band Glute Bridge",
            category: .strength,
            description: "Hip thrust variant with a looped resistance band above the knees, simultaneously training hip abduction and glute max in terminal extension. Activates gluteus medius and minimus — muscles that are chronically weak in most athletes and critical for knee stability.",
            sets: 3, repsDisplay: "15 reps",
            restSeconds: 60,
            muscleGroups: ["Glutes", "Hip Abductors", "Hamstrings", "Core"],
            coachingCues: [
                "Band just above the knees — keep constant outward tension",
                "Drive knees outward against the band throughout the movement",
                "Posterior pelvic tilt at the top — don't hyperextend the lumbar",
                "Pause 2 seconds at the top — feel the glute max contraction",
                "Progress to single-leg version when this feels easy"
            ],
            difficulty: .beginner, xpReward: 50
        ),

        // --- Mobility (additional) ---
        Exercise(
            name: "Thoracic Rotation Drill",
            category: .mobility,
            description: "Targeted upper-back mobility work in a side-lying position, isolating thoracic rotation from lumbar motion. Jump athletes need thoracic mobility to allow full arm-swing range — restricted T-spine is one of the most common limiters of jump height that goes uncorrected.",
            sets: 2, repsDisplay: "10 reps each side",
            restSeconds: 30,
            durationSeconds: 240,
            muscleGroups: ["Thoracic Spine", "Rhomboids", "Intercostals", "Serratus Anterior"],
            coachingCues: [
                "Side-lying position with knees stacked at 90°",
                "Bottom hand presses knees down to prevent lumbar compensation",
                "Top arm sweeps across the floor, following with your eyes",
                "Breathe out as you rotate — creates space between ribs",
                "Don't force it — reach end range and breathe into it"
            ],
            difficulty: .beginner, xpReward: 30
        ),
        Exercise(
            name: "Hip 90/90 Transitions",
            category: .mobility,
            description: "Active hip mobility drill moving through internal and external rotation in a 90/90 position on the floor. Improves hip flexion range, external rotation, and the transition speed between positions — all directly relevant to landing mechanics, stride length, and jump approach.",
            sets: 2, repsDisplay: "8 transitions each side",
            restSeconds: 30,
            durationSeconds: 300,
            muscleGroups: ["Hip External Rotators", "Hip Flexors", "Glutes", "Adductors"],
            coachingCues: [
                "Both knees at 90° — one in front, one to the side",
                "Tall spine — don't collapse the torso to reach range",
                "Transition smoothly — don't flop, control the rotation",
                "Work the back shin down to the floor over time",
                "Add a forward fold over the front leg for extra hip flexor stretch"
            ],
            difficulty: .beginner, xpReward: 30
        ),

        // --- Coordination (additional) ---
        Exercise(
            name: "5-10-5 Cone Drill",
            category: .coordination,
            description: "Shuttle run covering 5 yards right, 10 yards left, and 5 yards right. The most-used NFL Combine drill for measuring lateral change-of-direction speed. Develops deceleration mechanics, hip loading at direction change, and first-step explosion — transferable to all court sports.",
            sets: 6, repsDisplay: "1 full drill",
            restSeconds: 90,
            muscleGroups: ["Glutes", "Adductors", "Quads", "Calves", "Hip Flexors"],
            coachingCues: [
                "Low athletic stance — don't be upright at the start",
                "Plant the outside foot hard on the direction change",
                "Drive the knee across body — not upward — to change direction",
                "Lean into the new direction aggressively",
                "Time yourself — track improvement week over week"
            ],
            difficulty: .intermediate, xpReward: 70
        ),
        Exercise(
            name: "Jump Rope — Single-Leg",
            category: .coordination,
            description: "Unilateral jump rope work performed entirely on one leg. Dramatically more demanding than bilateral rope work — develops single-leg ankle stiffness, calve endurance, and rhythm that directly trains the takeoff leg in sports like long jump, triple jump, and basketball.",
            sets: 3, repsDisplay: "30 sec each leg",
            restSeconds: 60,
            durationSeconds: 180,
            muscleGroups: ["Calves", "Ankle Stabilizers", "Hip Stabilizers", "Core"],
            coachingCues: [
                "Start bilateral, transition to single-leg without stopping",
                "Slight knee bend — not locked straight",
                "Hop height minimal — conserve energy through stiffness",
                "Arms drive the rope rhythm — don't let the rope drive the arms",
                "Track consecutive reps — aim for 30 unbroken"
            ],
            difficulty: .intermediate, xpReward: 65
        ),

        // --- Reaction (additional) ---
        Exercise(
            name: "Signal Jump Start",
            category: .reaction,
            description: "Partner-based drill: the athlete stands in a loaded position and jumps maximally the moment the partner gives a visual signal (hand drop, light flash, or arm movement). Trains the neural pathway from visual stimulus to maximal motor output — critical for blocking in volleyball and rebounding in basketball.",
            sets: 5, repsDisplay: "6 signals",
            restSeconds: 60,
            muscleGroups: ["Full Lower Body", "Core", "Visual-Motor System"],
            coachingCues: [
                "Pre-load position: slight squat, weight on balls of feet",
                "Eyes on the signal — not on where you want to jump",
                "React — don't anticipate. Trust your nervous system.",
                "Measure ground contact time — faster is better over weeks",
                "Vary signal delay (0.5–3s) to prevent anticipation patterns"
            ],
            difficulty: .intermediate, xpReward: 70
        ),
        Exercise(
            name: "Drop Ball Catch",
            category: .reaction,
            description: "Partner holds a tennis ball at shoulder height and drops it without warning. The athlete must catch it before the second bounce. Develops hand-eye reaction speed and the neural pre-activation timing needed for explosive jump starts. Elite athletes can progress to single-hand catches.",
            sets: 4, repsDisplay: "10 drops",
            restSeconds: 45,
            muscleGroups: ["Visual-Motor System", "Hand-Eye Coordination", "Reactive Nervous System"],
            coachingCues: [
                "Start with hands at hip level — must reach down, not just open fingers",
                "Focus on the ball at all times — peripheral vision will cue the drop",
                "Progress: partner varies drop height, hand, and timing",
                "Add a jump before catching to increase difficulty",
                "Track consecutive catches per set as your performance metric"
            ],
            difficulty: .beginner, xpReward: 50
        ),

        // --- Technique (additional) ---
        Exercise(
            name: "Penultimate Step Drill",
            category: .technique,
            description: "Isolated drilling of the second-to-last step in any approach jump. The penultimate step is the most important stride in the long jump, high jump, and volleyball approach — it lowers the center of mass and generates the upward projection angle. Poor penultimate technique is the single most common cause of failed height conversion in jump athletes.",
            sets: 8, repsDisplay: "3-step sequence",
            restSeconds: 60,
            muscleGroups: ["Hip Extensors", "Calves", "Core", "Quads"],
            coachingCues: [
                "Walk approach first: mark exactly where your penultimate foot lands",
                "Penultimate step is longer than normal stride — settle your hips",
                "Final step is shorter and faster — converts momentum to height",
                "Hips should feel like they drop, then spring upward",
                "Practice with eyes closed to develop proprioceptive feel for timing"
            ],
            difficulty: .intermediate, xpReward: 65
        ),
        Exercise(
            name: "Arm Swing Sequencing",
            category: .technique,
            description: "Isolated drill training the precise timing and force of the arm swing in bilateral vertical jumping. Research shows that a well-timed double-arm swing adds 10–15% to jump height in trained athletes. Most athletes swing too early or too slow, losing free energy.",
            sets: 4, repsDisplay: "10 reps",
            restSeconds: 45,
            muscleGroups: ["Shoulders", "Lats", "Core", "Hip Flexors"],
            coachingCues: [
                "Arms sweep back below hips during the dip — load fully",
                "Timing: arms begin upward drive slightly before the legs push",
                "Drive elbows past shoulder height — maximum vertical momentum",
                "Wrists flip upward at the top — squeezes every last centimetre",
                "Practice sitting on a box: jump using only arm swing to feel the contribution"
            ],
            difficulty: .beginner, xpReward: 45
        ),

        // --- Premium Exercises (Elite Explosiveness Pack) ---
        Exercise(
            name: "Altitude Drop to Jump Shrug",
            category: .plyometric,
            description: "Step from a 60–80 cm box, absorb the landing in a quarter-squat, and immediately perform an explosive jump shrug — a sub-maximal Olympic weightlifting derivative. Develops the rate of force development (RFD) that separates elite jumpers from good jumpers. This is the same movement-type used in power clean and hang clean programs.",
            sets: 5, repsDisplay: "3 reps",
            restSeconds: 120,
            muscleGroups: ["Traps", "Glutes", "Calves", "Hamstrings", "Full Posterior Chain"],
            coachingCues: [
                "Step off — absorb in quarter-squat, not full squat",
                "Contact time target: under 300 ms before the shrug",
                "Explode upward: triple extension + shrug + heel raise simultaneously",
                "Think 'jump to ceiling' not 'pull the bar' — keep it athletic",
                "Reset fully between reps — full CNS output each time"
            ],
            difficulty: .elite, isPremium: true, premiumPack: .eliteExplosivenessPack, xpReward: 120
        ),
        Exercise(
            name: "Band-Assisted Overspeed Jumps",
            category: .plyometric,
            description: "Overhead resistance band creates upward assistance, allowing the athlete to move through the jump pattern 15–20% faster than unassisted maximal effort. Overspeed training overloads the neuromuscular system above its normal ceiling — after removing the band, the CNS retains the faster motor patterns. Requires a pullup bar or anchored overhead attachment.",
            sets: 4, repsDisplay: "6 reps",
            restSeconds: 120,
            muscleGroups: ["Full Lower Body", "Core", "Nervous System"],
            coachingCues: [
                "Use a band providing 10–20% of bodyweight assistance (lighter is better)",
                "Jump with full intent — the band helps, your effort must be 100%",
                "Land and immediately jump — band reloads for you",
                "Alternate: 3 band-assisted → 3 unassisted — feel the contrast",
                "Track jump height with and without band to measure neurological carryover"
            ],
            difficulty: .elite, isPremium: true, premiumPack: .eliteExplosivenessPack, xpReward: 120
        ),
    ]

    // MARK: - Achievements

    static let achievements: [Achievement] = [
        Achievement(
            name: "First Jump",
            description: "Complete your first training session.",
            iconName: "figure.jumprope",
            category: .milestone,
            xpReward: 100
        ),
        Achievement(
            name: "On Fire",
            description: "Maintain a 3-day training streak.",
            iconName: "flame.fill",
            category: .consistency,
            xpReward: 150
        ),
        Achievement(
            name: "Weekly Warrior",
            description: "Train 5 days in a single week.",
            iconName: "calendar.badge.checkmark",
            category: .consistency,
            xpReward: 250
        ),
        Achievement(
            name: "Plyometric Initiate",
            description: "Complete 10 plyometric exercises.",
            iconName: "bolt.fill",
            category: .mastery,
            xpReward: 200
        ),
        Achievement(
            name: "Discipline Explorer",
            description: "Open 5 different sport discipline modules.",
            iconName: "map.fill",
            category: .exploration,
            xpReward: 175
        ),
        Achievement(
            name: "AI Student",
            description: "Ask the AI coach 10 questions.",
            iconName: "brain.head.profile",
            category: .aiCoach,
            xpReward: 200
        ),
        Achievement(
            name: "Jump Scientist",
            description: "Read 10 sports-science facts.",
            iconName: "atom",
            category: .mastery,
            xpReward: 150
        ),
        Achievement(
            name: "Elite Initiator",
            description: "Reach Level 5.",
            iconName: "star.fill",
            category: .milestone,
            xpReward: 500
        ),
        Achievement(
            name: "Depth Jump Master",
            description: "Complete 20 depth jump sets.",
            iconName: "arrow.down.to.line",
            category: .mastery,
            xpReward: 300
        ),
        Achievement(
            name: "Unstoppable",
            description: "Maintain a 14-day training streak.",
            iconName: "shield.fill",
            category: .consistency,
            xpReward: 600
        ),
        Achievement(
            name: "Evolution Stage 2",
            description: "Reach Evolution Stage 2: Jump Apprentice.",
            iconName: "figure.run",
            category: .milestone,
            xpReward: 400
        ),
        Achievement(
            name: "Evolution Stage 4",
            description: "Reach Evolution Stage 4: Athletic Specialist.",
            iconName: "figure.gymnastics",
            category: .milestone,
            xpReward: 800
        )
    ]

    // MARK: - Jump Evolution Stages

    struct EvolutionStage {
        let index: Int
        let title: String
        let subtitle: String
        let description: String
        let xpRequired: Int
        let iconName: String
        let unlockedDisciplineIndices: [Int]
    }

    static let evolutionStages: [EvolutionStage] = [
        EvolutionStage(
            index: 0,
            title: "Ground Zero",
            subtitle: "Where every legend starts",
            description: "You are at the beginning of your jump journey. Focus on foundational movement, basic coordination, and understanding how your body generates force.",
            xpRequired: 0,
            iconName: "figure.walk",
            unlockedDisciplineIndices: [0, 2, 4]
        ),
        EvolutionStage(
            index: 1,
            title: "Jump Apprentice",
            subtitle: "Developing explosive potential",
            description: "Your movement foundation is set. Begin systematic plyometric training, master landing mechanics, and start developing the elastic energy system.",
            xpRequired: 500,
            iconName: "figure.run",
            unlockedDisciplineIndices: [0, 1, 2, 4, 5]
        ),
        EvolutionStage(
            index: 2,
            title: "Explosive Cadet",
            subtitle: "Power meets precision",
            description: "Power is growing. Time to combine strength, speed, and technical precision. Advanced plyometrics and sport-specific movement patterns unlock here.",
            xpRequired: 1500,
            iconName: "bolt.fill",
            unlockedDisciplineIndices: [0, 1, 2, 3, 4, 5, 6, 11]
        ),
        EvolutionStage(
            index: 3,
            title: "Athletic Specialist",
            subtitle: "Mastering your discipline",
            description: "You have reached a significant level of athletic development. Advanced techniques, complex movement patterns, and specialist disciplines become accessible.",
            xpRequired: 3500,
            iconName: "figure.gymnastics",
            unlockedDisciplineIndices: [0, 1, 2, 3, 4, 5, 6, 7, 11]
        ),
        EvolutionStage(
            index: 4,
            title: "Elite Performer",
            subtitle: "The summit of athletic evolution",
            description: "Operating at the elite level. Your training combines all energy systems, maximal force production, and refined movement expression. All disciplines are open.",
            xpRequired: 7000,
            iconName: "star.fill",
            unlockedDisciplineIndices: Array(0..<12)
        )
    ]

    // MARK: - Sample Metrics (seed data)

    static let sampleMetrics: [JumpMetric] = [
        JumpMetric(type: .verticalJump,      value: 42.0),
        JumpMetric(type: .standingBroadJump, value: 195.0),
        JumpMetric(type: .reactionTime,      value: 248.0),
        JumpMetric(type: .explosiveness,     value: 63.0),
        JumpMetric(type: .airTime,           value: 0.58),
        JumpMetric(type: .consistencyScore,  value: 74.0)
    ]
}

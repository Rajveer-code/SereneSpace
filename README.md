<div align="center">

<h1>🌿 SereneSpace</h1>

<p><strong>An anonymous mental wellness platform built for students who aren't ready to ask for help out loud</strong></p>

<a href="https://serenespace-e5ev.onrender.com/">
  <img src="https://img.shields.io/badge/🚀_Live_Demo-Visit_App-6B73FF?style=for-the-badge" alt="Live Demo">
</a>

<br/><br/>

<img src="https://img.shields.io/badge/Python-3.10-3776AB?style=flat-square&logo=python&logoColor=white" alt="Python">
<img src="https://img.shields.io/badge/Flask-3.1-000000?style=flat-square&logo=flask&logoColor=white" alt="Flask">
<img src="https://img.shields.io/badge/Frontend-HTML_CSS_JS-F7DF1E?style=flat-square&logo=javascript&logoColor=black" alt="Frontend">
<img src="https://img.shields.io/badge/Deployed_on-Render-46E3B7?style=flat-square&logo=render&logoColor=white" alt="Render">
<img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License">

<br/><br/>

<img src="https://img.shields.io/badge/SIH_2025-Selected_(50_of_250_Teams)-764ba2?style=flat-square" alt="SIH 2025">
<img src="https://img.shields.io/badge/Problem_ID-SIH25092-667eea?style=flat-square" alt="Problem Statement ID">
<img src="https://img.shields.io/badge/Theme-MedTech_/_Health_Tech-9BF0E1?style=flat-square" alt="Theme">

</div>

---

## Overview

SereneSpace is a web application built to close the gap between a student in distress and the support they need. The core premise is simple: no account, no login, no judgment. A student can open the app, check in with how they're feeling, and immediately reach tools, peer communities, or a professional — all without identifying themselves.

Mental health infrastructure at Indian colleges exists in theory. In practice, most students never use it. The stigma around seeking help, the fear of being seen walking into a counselor's office, and the inaccessibility of resources after hours mean most students silently manage distress alone. SereneSpace was built to address that reality directly.

> 🌐 **[Try the live application here →](https://serenespace-e5ev.onrender.com/)**

---

## The Problem

The issue isn't the absence of mental health resources at universities — it's the absence of **accessible, private, and immediate** ones.

A student dealing with exam pressure, loneliness, or academic failure faces a system that asks them to:

- Identify themselves
- Make an appointment days in advance
- Walk into an office during working hours
- Explain their situation to a stranger in person

For most students, that chain of steps is too much. They never take the first one. Problems that were manageable early become serious over time — and by the time they do reach a counselor, they're often already in crisis.

---

## What We Built

SereneSpace removes the friction entirely. A student visits the platform, picks a mood from a simple check-in screen, and lands on a dashboard personalized to how they're feeling right now. From there, they can:

- Use self-help tools: breathing exercises, a drawing board, games, and journaling
- Take a structured wellness assessment and get tiered recommendations
- Talk to an AI companion trained on mental health coping strategies
- Join anonymous peer forums organized around shared experiences
- Connect with a real counselor through chat, call, or video — when they're ready
- Reach emergency helplines instantly, with zero login required

On the institutional side, an **admin dashboard** gives college counselors aggregated, anonymized insight into campus wellness trends — enabling proactive outreach rather than waiting for a crisis to surface.

---

## Key Features

| Feature | Description |
|---|---|
| 🔒 **Anonymous Access** | Full platform access without any account — session-based identity only |
| 😌 **Mood Check-in** | Five emotional states captured at entry, driving the entire personalized flow |
| 📋 **Wellness Assessment** | PHQ-9 style 10-question self-evaluation with automatic scoring and recommendations |
| 🤖 **AI Companion** | Keyword-aware chat with mental health responses; crisis escalation built in |
| 🎮 **Activity Hub** | Canvas drawing board, breathing exercise timer, memory game, guided journaling |
| 🌐 **Multilingual Support** | Language selector with English, Hindi, and Urdu in the AI companion |
| 🫂 **Peer Community** | Anonymous moderated group forums organized by theme (exam stress, sleep, motivation) |
| 👩‍⚕️ **Professional Pathways** | Direct routes to live chat support, scheduled calls, and video counseling |
| 🚨 **Emergency Page** | Always accessible — no session required; national helplines with click-to-call |
| 🛡️ **Admin Dashboard** | Chart.js visualizations of mood trends, usage data, and crisis frequency |

---

## System Architecture

The application uses a straightforward server-rendered architecture with Flask at the center.
```
Browser
   │
   ▼
Flask Routes (application.py)
   │
   ├──► Session Store (Flask signed cookies)
   │         │
   │         ▼
   │    [mood] ──► [dashboard] ──► [assessment / activities / chat / community / counseling]
   │
   └──► Admin Route ──► [admin_dashboard] (separate session guard)
            │
            ▼
       Chart.js Visualizations
```

**How the user flow works:**

1. Student lands on `welcome.html` → clicks "Get Started"
2. Mood check-in page captures emotional state via a `POST` request → stored in Flask session
3. `session['user'] = 'Anonymous'` is set, unlocking all protected routes without any identity
4. Dashboard renders dynamically using stored mood and any prior assessment data
5. Assessment responses are submitted as JSON, scored server-side, stored in session
6. Results page reads from session — no database round-trip needed
7. Emergency page is intentionally excluded from all session guards so it's always reachable

**Key design decision:** The entire current implementation is stateless by design — no database, all state in Flask sessions. This made deployment fast and the codebase portable, at the cost of persistence across sessions (a deliberate trade-off for the prototype stage).

---

## Tech Stack

**Backend**
- Python 3.10
- Flask 3.1
- Flask-SocketIO 5.5 — real-time community chat
- Gunicorn — production WSGI server

**Frontend**
- HTML5, CSS3, Vanilla JavaScript
- Jinja2 templating
- Chart.js — admin dashboard visualizations
- Font Awesome 6 — iconography
- Google Fonts (Inter, Poppins)

**Deployment**
- **Render** (live) — [serenespace-e5ev.onrender.com](https://serenespace-e5ev.onrender.com/)
- AWS Elastic Beanstalk-compatible (`application.py` naming convention followed)

---

## Implementation Highlights

**Anonymous session management**  
The platform tracks mood, assessment results, and journey state without any registration. Flask's signed cookie sessions handle this entirely. Setting `session['user'] = 'Anonymous'` on the mood check-in page serves as the session passport for every downstream route — clean, zero-friction, and privacy-preserving.

**Multi-step assessment with client-side scoring**  
The wellness assessment is a single-page multi-step form driven by vanilla JS. Each question renders in place, the progress bar updates on every navigation step, and the final PHQ-9 style score is computed client-side before being sent to the server as JSON. Results are categorized into three tiers (low / moderate / high concern) with matched recommendation sets.

**Breathing exercise phase engine**  
The breathing exercise supports two patterns (4-7-8 and box breathing) through a JS phase-sequencer that drives both the CSS circle expand/contract animation and the instruction label simultaneously. Keeping both in sync across different pattern durations required programmatically resetting and restarting the CSS animation on each phase transition rather than relying on a single looping keyframe — otherwise the visual and the text would drift out of sync after the first cycle.

**Crisis escalation in AI chat**  
The AI companion scans incoming messages against a set of crisis keywords. On detection, it immediately surfaces emergency contact options and prompts the user toward the emergency page — prioritizing safety over conversational flow. This is intentionally simple and fast; the goal is redirection, not engagement.

**HTML5 Canvas drawing board**  
The activity hub includes a freehand drawing board built on the Canvas API. Mouse and touch event listeners track pointer movement, and brush color and size are adjustable in real time. It was included specifically as a non-verbal outlet — there's consistent evidence that unstructured creative activity helps regulate stress responses.

---

## SIH 2025 Context

This project was submitted to **Smart India Hackathon 2025** as the official entry from **Team The Peace Pals**.

- **Problem Statement:** SIH25092 — Development of a Digital Mental Health and Psychological Support System for Students in Higher Education
- **Theme:** MedTech / BioTech / Health Tech

At the college-level screening round, approximately **250 teams submitted proposals**. After evaluation on problem understanding, solution design, and technical viability — which included a written submission and a live presentation and Q&A round with judges — our team was among the **50 teams selected to advance**.

---

## Results

What the system currently produces:

- A personalized resource dashboard from a single mood input, with no sign-up required
- A tiered wellness report after assessment with matched coping strategies
- A real-time conversation log from the AI companion with built-in crisis escalation
- A full activity session — breathing, drawing, journaling, or games — with completion tracking
- For administrators: mood distribution charts, feature engagement breakdowns, and crisis frequency metrics over time

---

## Future Scope

**Optional pseudonymous accounts**  
The anonymous model is right for first contact. Voluntary pseudonymous accounts would allow mood and assessment trends to be tracked over time — surfacing students whose wellbeing has been gradually declining over weeks, not just those in acute crisis.

**Fine-tuned language model for the AI companion**  
The current keyword-matching system works but has obvious limits. Replacing it with a small model fine-tuned on mental health counseling dialogue would make responses substantially more contextual and useful, especially for nuanced or indirect expressions of distress.

**University scheduling API integration**  
The counseling page currently shows static availability data. Connecting to a university's scheduling system via API would make the booking flow real — same-day slots, calendar sync, confirmation messages.

**Full UI localization for regional Indian languages**  
The AI companion already has Hindi and Urdu language stubs. Extending full UI localization to cover the top 6 Indian languages would significantly improve accessibility for first-generation college students and students from non-English-medium backgrounds.

**Progressive Web App with opt-in check-in reminders**  
A lightweight PWA wrapper would enable push notifications — gentle, optional prompts for students who haven't checked in for several days, enabling early-stage outreach before a difficult week becomes a serious problem.

---

## Getting Started

**Prerequisites:** Python 3.8+, pip
```bash
# Clone the repository
git clone https://github.com/your-username/SereneSpace.git
cd SereneSpace

# Create and activate a virtual environment
python3 -m venv venv
source venv/bin/activate       # macOS / Linux
venv\Scripts\activate          # Windows

# Install dependencies
pip install -r requirements.txt

# Run the application
python application.py
```

Open `http://127.0.0.1:5000` in your browser.

**Admin access:** navigate to `/login`
```
Username: admin
Password: 123
```

---

## Project Structure
```
SereneSpace/
│
├── application.py              # All Flask routes and application logic
├── requirements.txt            # Python dependencies
│
├── static/
│   └── style.css               # Global design system — variables, components, layout
│
└── templates/
    ├── welcome.html             # Landing page and entry point
    ├── login.html               # Admin-only authentication
    ├── mood_checkin.html        # Anonymous entry — mood selection
    ├── dashboard.html           # Personalized hub built from session mood data
    ├── assessment.html          # Multi-step wellness self-assessment
    ├── assessment_results.html  # Scored results with tiered recommendations
    ├── activity_gamespage.html  # Activity hub — games, canvas drawing, journaling
    ├── breathing_exercise.html  # Guided breathing with animated phase timer
    ├── ai_chat.html             # AI companion with crisis escalation
    ├── community.html           # Anonymous peer forums and group chat
    ├── counseling.html          # Professional support pathways
    ├── emergency.html           # Crisis page — always accessible, no session required
    └── admin_dashboard.html     # Institutional analytics and wellness overview
```

---

## License

Distributed under the MIT License.

---

<div align="center">

Mental health support fails students not because institutions don't care, but because the systems weren't designed around how students actually behave when they're struggling. SereneSpace started from that observation. The goal was to make the first step toward help require as little courage as possible.

It's a working prototype. There's meaningful engineering still to do. But the core idea is right.

<br/>

**[🌐 View the live application](https://serenespace-e5ev.onrender.com/)** · Built for SIH 2025 by Team The Peace Pals

</div>

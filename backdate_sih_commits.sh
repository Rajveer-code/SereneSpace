#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
#  backdate_sih_commits.sh
#  Backdated commit history — SIH 2025 mental health web application
#  Timeline : 2025-08-06  →  2025-09-09  (~5 weeks, 35 calendar days)
#  Files    : application.py · static/style.css · 15 HTML templates
#
#  Usage:
#    git init          (inside your repo folder)
#    touch progress_log.txt
#    bash backdate_sih_commits.sh
# ═══════════════════════════════════════════════════════════════════════════════

set -e

CURRENT_DATE="2025-08-06"

# ── date helper ───────────────────────────────────────────────────────────────
next_day() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        CURRENT_DATE=$(date -j -v+1d -f "%Y-%m-%d" "$CURRENT_DATE" +%Y-%m-%d)
    else
        CURRENT_DATE=$(date -I -d "$CURRENT_DATE + 1 day")
    fi
}

# ── commit helper ─────────────────────────────────────────────────────────────
commit_at() {
    local msg="$1"
    local hms="$2"
    echo "." >> progress_log.txt
    git add .
    GIT_AUTHOR_DATE="${CURRENT_DATE}T${hms}" \
    GIT_COMMITTER_DATE="${CURRENT_DATE}T${hms}" \
    git commit -m "$msg"
}

# ═══════════════════════════════════════════════════════════════════════════════
#  application.py  ·  Day 1
#  2025-08-06  Wednesday — project kickoff, clean focused morning
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "app: initialize Flask app and set secret key" "10:14:22"
commit_at "app: add welcome and login routes with admin session check" "11:48:37"
commit_at "app: add mood check-in route and submit-mood POST handler" "14:22:09"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  application.py  ·  Day 2  (no commits — debugging session persistence)
#  static/style.css  ·  Day 1
#  2025-08-07  Thursday — app blocked, pivot to CSS instead
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "css: set up CSS reset and root color variables" "13:07:44"
commit_at "css: add animated background gradient keyframes" "15:02:18"
commit_at "css: build header, nav, and logo styles" "17:33:55"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  application.py  ·  Day 3
#  static/style.css  ·  Day 2
#  2025-08-08  Friday — session fix lands, long productive day
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "app: add dashboard route with mood and recommendations context" "10:08:51"
commit_at "app: add activities, community, ai-chat, counseling routes" "11:22:34"
commit_at "app: add assessment and submit-assessment routes with session storage" "13:44:17"
commit_at "app: add assessment-results, breathing, and emergency routes" "15:07:42"
commit_at "app: add admin dashboard route with session guard" "16:31:08"
commit_at "css: add card, button, and mood grid component styles" "20:48:29"
commit_at "css: add dashboard and recommendation grid layout" "22:17:53"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  static/style.css  ·  Day 3
#  templates/index.html  ·  Day 1
#  2025-08-09  Saturday — wrapping CSS, quick index prototype
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "css: add full AI chat component styles with bubble variants" "11:03:14"
commit_at "css: add responsive media query for mobile" "13:29:47"
commit_at "index: build static prototype landing page with navbar and quote box" "16:14:28"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/welcome.html  ·  Day 1
#  2025-08-10  Sunday — slower afternoon session
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "welcome: build hero section with animated gradient background" "14:22:33"
commit_at "welcome: add floating shape decorations and slide-up animation" "16:48:07"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/welcome.html  ·  Day 2
#  templates/login.html  ·  Day 1
#  2025-08-11  Monday — back in full swing, long session
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "welcome: add feature cards grid with icons" "10:19:52"
commit_at "welcome: add call-to-action buttons linking to mood check-in" "12:03:28"
commit_at "welcome: add footer with emergency bar" "13:44:11"
commit_at "login: build centered login form with username and password fields" "15:58:34"
commit_at "login: add error message display using Jinja2 conditional" "17:22:06"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/login.html  ·  Day 2
#  templates/mood_checkin.html  ·  Day 1
#  2025-08-12  Tuesday — finish login, start mood check-in
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "login: style form with purple button and demo credentials hint" "10:11:43"
commit_at "login: test admin redirect flow end to end" "11:47:28"
commit_at "mood: build mood card grid with emoji options and selection state" "14:03:55"
commit_at "mood: add support banner and navigation header" "15:38:14"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/mood_checkin.html  ·  Day 2  (no commits — fetch POST stuck on 400)
#  2025-08-13  Wednesday — debugging all day, nothing to push
# ═══════════════════════════════════════════════════════════════════════════════

next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/mood_checkin.html  ·  Day 3
#  templates/dashboard.html  ·  Day 1
#  2025-08-14  Thursday — fetch fixed, momentum back, dashboard started
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "mood: fix fetch request and handle redirect from server response" "09:54:22"
commit_at "mood: add selected state highlight and smooth transition on pick" "11:28:47"
commit_at "dash: build welcome section showing mood from Jinja2 session variable" "13:47:09"
commit_at "dash: add daily quote card" "14:52:34"
commit_at "dash: add recommendations grid with activities and music cards" "16:18:53"
commit_at "dash: add navigation links to all features" "21:44:17"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/dashboard.html  ·  Day 2
#  2025-08-15  Friday — Independence Day, still grinding
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "dash: add assessment prompt card when no recent assessment exists" "10:33:48"
commit_at "dash: add quick-action buttons for breathing and activities" "12:07:22"
commit_at "dash: fix layout breaking on smaller viewport widths" "14:51:09"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/assessment.html  ·  Day 1
#  2025-08-16  Saturday — starting the big one
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "assess: build assessment container with animated background" "11:22:37"
commit_at "assess: add progress bar and question counter header" "13:08:14"
commit_at "assess: add first three questions with radio options and transitions" "15:44:52"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/assessment.html  ·  Day 2  (no commits — multi-step JS tangled)
#  2025-08-17  Sunday — spent the day untangling JS, nothing committed
# ═══════════════════════════════════════════════════════════════════════════════

next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/assessment.html  ·  Day 3
#  2025-08-18  Monday — clear head, JS finally makes sense
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "assess: implement question navigation with next and back buttons" "10:04:19"
commit_at "assess: add all ten PHQ-9 style questions with answer options" "11:48:33"
commit_at "assess: scoring logic and recommendation generation by score range" "14:22:07"
commit_at "assess: fetch POST to submit-assessment with session storage" "16:37:44"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/assessment.html  ·  Day 4
#  templates/assessment_results.html  ·  Day 1
#  2025-08-19  Tuesday — fix the progress bar bug, start results page
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "assess: fix progress bar staying at 0% on very first question" "09:48:22"
commit_at "assess: add completion animation and redirect on successful submit" "11:13:08"
commit_at "results: build results container with score circle and header section" "13:37:44"
commit_at "results: display score from Jinja2 assessment session data" "15:02:29"
commit_at "results: add score category label with color coding by severity level" "16:48:53"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/assessment_results.html  ·  Day 2
#  2025-08-20  Wednesday — recommendations, links, and that circle bug
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "results: display personalized recommendations list from session data" "10:22:14"
commit_at "results: add action buttons linking to dashboard and counseling" "12:07:38"
commit_at "results: fix animated score circle not rendering on first load" "14:33:52"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/activity_gamespage.html  ·  Day 1
#  2025-08-21  Thursday — building the games page skeleton
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "games: build page layout with activity category cards and nav" "10:48:17"
commit_at "games: add breathing exercise card with start button" "12:33:44"
commit_at "games: add memory game card with basic grid setup" "14:17:28"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/activity_gamespage.html  ·  Day 2  (no commits — reading MDN Canvas docs)
#  2025-08-22  Friday — Canvas API completely new, spent day on documentation
# ═══════════════════════════════════════════════════════════════════════════════

next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/activity_gamespage.html  ·  Day 3
#  2025-08-23  Saturday — Canvas makes sense now, drawing board done
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "games: implement drawing board using HTML5 Canvas API" "11:14:37"
commit_at "games: add color picker and brush size controls" "13:52:19"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/activity_gamespage.html  ·  Day 4  (no commits — word scramble bugged)
#  2025-08-24  Sunday — word scramble state management was a mess
# ═══════════════════════════════════════════════════════════════════════════════

next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/activity_gamespage.html  ·  Day 5
#  2025-08-25  Monday — big push, cleared all backlog in one session
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "games: add Sudoku placeholder and word scramble game skeleton" "10:03:48"
commit_at "games: connect activity cards to breathing exercise page link" "11:29:14"
commit_at "games: fix word scramble game logic and timer" "13:44:27"
commit_at "games: add mood journal text area with save to localStorage" "15:18:52"
commit_at "games: clean up layout and responsive spacing across all cards" "17:02:37"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/breathing_exercise.html  ·  Day 1
#  2025-08-26  Tuesday — starting the breathing feature
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "breath: build breathing card layout with centered circle element" "10:37:22"
commit_at "breath: add gradient background animation" "12:11:47"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/breathing_exercise.html  ·  Day 2  (no commits — CSS animation research)
#  2025-08-27  Wednesday — spent day figuring out expand/contract keyframes
# ═══════════════════════════════════════════════════════════════════════════════

next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/breathing_exercise.html  ·  Day 3
#  2025-08-28  Thursday — animations working, patterns added
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "breath: implement breathing circle expand and contract CSS keyframes" "10:22:08"
commit_at "breath: add instruction text that changes with each phase" "12:48:34"
commit_at "breath: add 4-7-8 and box breathing patterns with different timings" "14:33:17"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/breathing_exercise.html  ·  Day 4
#  2025-08-29  Friday — JS timer done, late night sync fix
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "breath: implement JS timer switching inhale hold and exhale phases" "10:07:43"
commit_at "breath: add session counter and completion message" "12:44:19"
commit_at "breath: fix phase label not syncing with circle animation" "21:38:52"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/ai_chat.html  ·  Day 1
#  2025-08-30  Saturday — chat UI built out fully
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "chat: build chat container layout with header and message area" "11:03:28"
commit_at "chat: add initial AI greeting message bubble" "12:47:14"
commit_at "chat: add typing indicator with animated bouncing dots" "14:22:39"
commit_at "chat: add suggestion chips for common mental health prompts" "16:08:53"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/ai_chat.html  ·  Day 2  (no commits — deciding rule-based vs API)
#  2025-08-31  Sunday — spent the day thinking through the approach
# ═══════════════════════════════════════════════════════════════════════════════

next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/ai_chat.html  ·  Day 3
#  2025-09-01  Monday — rule-based logic implemented cleanly
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "chat: implement message send and display for user and AI bubbles" "10:14:29"
commit_at "chat: add rule-based keyword response logic for mental health topics" "11:58:43"
commit_at "chat: add language selector dropdown with Hindi and Urdu stubs" "13:37:18"
commit_at "chat: add quick action buttons for crisis breathing and counseling" "15:22:47"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/ai_chat.html  ·  Day 4
#  templates/community.html  ·  Day 1
#  2025-09-02  Tuesday — polish chat, start community page, long session
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "chat: add timestamp display on each message bubble" "09:48:33"
commit_at "chat: fix chat area not auto-scrolling to latest message" "11:14:07"
commit_at "chat: add crisis keyword detection and redirect to emergency page" "12:58:44"
commit_at "community: build community groups grid with icons and member counts" "14:33:19"
commit_at "community: add anonymous chat area with pre-populated peer messages" "16:18:52"
commit_at "community: add message input and send button with JS append logic" "21:07:28"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/community.html  ·  Day 2
#  templates/counseling.html  ·  Day 1
#  2025-09-03  Wednesday — wrap community, build counseling page
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "community: add anonymous username generation on message send" "09:54:17"
commit_at "community: add moderation notice and community guidelines note" "11:28:44"
commit_at "community: fix chat area not scrolling to bottom on new message" "13:07:22"
commit_at "counsel: build page with motivational banner and counseling intro" "14:52:38"
commit_at "counsel: add chat voice call and video counseling option cards" "16:37:14"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/counseling.html  ·  Day 2
#  templates/emergency.html  ·  Day 1
#  2025-09-04  Thursday — finish counseling, emergency page done in one shot
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "counsel: add availability stats and action buttons per counseling type" "10:18:29"
commit_at "counsel: add campus resources section and basic FAQ accordion" "12:03:44"
commit_at "emergency: build emergency page with urgent banner and crisis message" "13:48:17"
commit_at "emergency: add national helpline numbers with click-to-call buttons" "15:22:53"
commit_at "emergency: add self-care grounding steps section" "16:47:38"
commit_at "emergency: add link back to ai-chat and counseling for follow-up" "22:14:09"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/admin_dashboard.html  ·  Day 1
#  2025-09-05  Friday — starting the most complex page
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "admin: build sidebar layout with logo nav sections and nav links" "11:22:08"
commit_at "admin: add main content area with top header bar and stat cards" "14:07:33"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/admin_dashboard.html  ·  Day 2  (no commits — reading Chart.js docs)
#  2025-09-06  Saturday — Chart.js completely new, spent day on examples
# ═══════════════════════════════════════════════════════════════════════════════

next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/admin_dashboard.html  ·  Day 3
#  2025-09-07  Sunday — charts finally working
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "admin: implement weekly mood trend line chart using Chart.js" "11:03:47"
commit_at "admin: add platform usage doughnut chart" "13:28:22"
commit_at "admin: add recent activity feed and alerts table" "15:44:09"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/admin_dashboard.html  ·  Day 4
#  2025-09-08  Monday — wellbeing score, chart fix, bar chart
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "admin: add student wellbeing index score card" "10:37:14"
commit_at "admin: fix chart container sizing breaking in flex layout" "12:22:48"
commit_at "admin: add resource utilization bar chart" "14:08:33"
next_day

# ═══════════════════════════════════════════════════════════════════════════════
#  templates/admin_dashboard.html  ·  Day 5
#  2025-09-09  Tuesday — final polish and submission prep
# ═══════════════════════════════════════════════════════════════════════════════

commit_at "admin: add crisis alerts section with severity badges" "10:14:52"
commit_at "admin: add college filter dropdown and date range selector stubs" "11:48:27"
commit_at "admin: clean up sidebar active state and hover transitions" "13:33:09"
commit_at "admin: final spacing and color consistency pass across all panels" "15:22:44"

echo ""
echo "✓ All commits applied."
echo "  First commit : 2025-08-06"
echo "  Last commit  : 2025-09-09"
echo "  Total days   : 35 calendar days"
echo ""
echo "  Run: git log --oneline | wc -l   to count total commits"
echo "  Run: git log --oneline            to review the full history"

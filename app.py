from flask import Flask, render_template, request, redirect, url_for, session
import os

app = Flask(__name__)
# A secret key is needed for session management
app.config['SECRET_KEY'] = os.urandom(24) 

## --- Site Entry and Authentication ---

# The first page users will see
@app.route('/')
def welcome():
    return render_template('welcome.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    # This is an admin login as per the login.html file
    error = None
    if request.method == 'POST':
        # UPDATED PASSWORD CHECK
        if request.form.get('username') == 'admin' and request.form.get('password') == 'password123':
            session['admin_user'] = request.form.get('username')
            return redirect(url_for('admin_dashboard'))
        else:
            error = 'Invalid credentials. Please try again.'
    return render_template('login.html', error=error)

# The anonymous user flow starts here
@app.route('/mood-checkin')
def mood_checkin():
    # Set a session for anonymous users to track their journey
    if 'user' not in session:
        session['user'] = 'Anonymous'
    return render_template('mood_checkin.html')

# A route to handle the mood submission from the check-in page
@app.route('/submit-mood', methods=['POST'])
def submit_mood():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    
    data = request.get_json()
    mood = data.get('mood')
    if mood:
        session['mood'] = mood # Store mood in the session
        return {'success': True, 'redirect': url_for('dashboard')}
    return {'success': False, 'error': 'No mood provided'}

## --- Main User-Facing Routes ---

@app.route('/dashboard')
def dashboard():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    
    mood = session.get('mood', 'okay')
    daily_quote = "The best way to predict the future is to create it."
    recommendations = {
        'activities': ['2-Minute Breathing', 'Quick Journaling', 'Listen to a Calming Song'],
        'music': ['Rain Sounds', 'Ocean Waves', 'Soft Instrumental']
    }
    return render_template('dashboard.html', mood=mood, daily_quote=daily_quote, recommendations=recommendations)

@app.route('/activities')
def activities():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('activity_gamespage.html')

@app.route('/community')
def community():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('community.html')

@app.route('/ai-chat')
def ai_chat():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('ai_chat.html')

@app.route('/counseling')
def counseling():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('counseling.html')

@app.route('/emergency')
def emergency():
    # Emergency page should be accessible even if not logged in
    return render_template('emergency.html')

@app.route('/breathing-exercise')
def breathing_exercise():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('breathing_exercise.html')

## --- Admin Routes ---

@app.route('/admin')
def admin_dashboard():
    # Protect this route by checking if an admin is in the session
    if 'admin_user' not in session:
        return redirect(url_for('login'))
    return render_template('admin_dashboard.html')

if __name__ == '__main__':
    app.run(debug=True)
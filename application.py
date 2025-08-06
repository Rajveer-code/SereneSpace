from flask import Flask, render_template, request, redirect, url_for, session, jsonify
import os
from datetime import datetime

# The variable is now named 'application' to match what AWS Elastic Beanstalk expects.
application = Flask(__name__)
# A secret key is needed for session management
application.config['SECRET_KEY'] = os.urandom(24) 

## --- Site Entry and Authentication ---

# The first page users will see
@application.route('/')
def welcome():
    return render_template('welcome.html')

@application.route('/login', methods=['GET', 'POST'])
def login():
    # This is an admin login as per the login.html file
    error = None
    if request.method == 'POST':
        # UPDATED PASSWORD CHECK
        if request.form.get('username') == 'admin' and request.form.get('password') == '123':
            session['admin_user'] = request.form.get('username')
            return redirect(url_for('admin_dashboard'))
        else:
            error = 'Invalid credentials. Please try again.'
    return render_template('login.html', error=error)

# The anonymous user flow starts here
@application.route('/mood-checkin')
def mood_checkin():
    # Set a session for anonymous users to track their journey
    if 'user' not in session:
        session['user'] = 'Anonymous'
    return render_template('mood_checkin.html')

# A route to handle the mood submission from the check-in page
@application.route('/submit-mood', methods=['POST'])
def submit_mood():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    
    data = request.get_json()
    mood = data.get('mood')
    if mood:
        session['mood'] = mood # Store mood in the session
        return {'success': True, 'redirect': url_for('dashboard')}
    return {'success': False, 'error': 'No mood provided'}

## --- NEW: Assessment Routes ---

@application.route('/assessment')
def assessment():
    # Set up anonymous session if not already set
    if 'user' not in session:
        session['user'] = 'Anonymous'
    
    # Check if user has taken assessment recently (optional)
    last_assessment = session.get('last_assessment_date')
    if last_assessment:
        # You can add logic here to check if enough time has passed
        pass
    
    return render_template('assessment.html')

@application.route('/submit-assessment', methods=['POST'])
def submit_assessment():
    if 'user' not in session:
        return jsonify({'success': False, 'error': 'Session expired'}), 400
    
    data = request.get_json()
    
    # Store assessment data in session (in production, use a database)
    assessment_data = {
        'responses': data.get('responses', {}),
        'score': data.get('score', 0),
        'date': datetime.now().isoformat(),
        'recommendations': data.get('recommendations', [])
    }
    
    # Store in session
    session['last_assessment'] = assessment_data
    session['last_assessment_date'] = datetime.now().isoformat()
    
    return jsonify({
        'success': True, 
        'redirect': url_for('assessment_results'),
        'message': 'Assessment completed successfully'
    })

@application.route('/assessment-results')
def assessment_results():
    if 'user' not in session or 'last_assessment' not in session:
        return redirect(url_for('assessment'))
    
    assessment_data = session.get('last_assessment')
    return render_template('assessment_results.html', assessment=assessment_data)

## --- Main User-Facing Routes ---

@application.route('/dashboard')
def dashboard():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    
    mood = session.get('mood', 'okay')
    daily_quote = "The best way to predict the future is to create it."
    recommendations = {
        'activities': ['2-Minute Breathing', 'Quick Journaling', 'Listen to a Calming Song'],
        'music': ['Rain Sounds', 'Ocean Waves', 'Soft Instrumental']
    }
    
    # Include assessment data if available
    last_assessment = session.get('last_assessment')
    
    return render_template('dashboard.html', 
                           mood=mood, 
                           daily_quote=daily_quote, 
                           recommendations=recommendations,
                           last_assessment=last_assessment)

@application.route('/activities')
def activities():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('activity_gamespage.html')

@application.route('/community')
def community():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('community.html')

@application.route('/ai-chat')
def ai_chat():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('ai_chat.html')

@application.route('/counseling')
def counseling():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('counseling.html')

@application.route('/emergency')
def emergency():
    # Emergency page should be accessible even if not logged in
    return render_template('emergency.html')

@application.route('/breathing-exercise')
def breathing_exercise():
    if 'user' not in session:
        return redirect(url_for('mood_checkin'))
    return render_template('breathing_exercise.html')

## --- Admin Routes ---

@application.route('/admin')
def admin_dashboard():
    # Protect this route by checking if an admin is in the session
    if 'admin_user' not in session:
        return redirect(url_for('login'))
    return render_template('admin_dashboard.html')

if __name__ == '__main__':
    application.run(debug=True)
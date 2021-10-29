from flask import Flask, render_template, request
import logging

app = Flask(__name__)
@app.route('/')
def forumpost():
 return render_template('forum.html')

@app.route('/forumpost', methods=['GET', 'POST'])
def postcheck():
    if request.method == 'POST':
        if type(request.form['forumtext']) == str:
            logging.warning(f"ACCEPTED forum post: {request.form['forumtext']}")
            return render_template('accepted.html', response=request.form['forumtext'])
    elif request.method == 'GET':
        return 'cannot handle GET request'
    else:
        return 'Bad Method!'
 
if __name__ == '__main__':
 app.run(debug=True,host='0.0.0.0')


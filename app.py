from flask import Flask, render_template, request
import subprocess

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        user_input = request.form["user_input"]
        # Execute the program and get the output (example for C program)
        try:
            # Create a temporary file with user input (if necessary for your use case)
            with open("input.txt", "w") as f:
                f.write(user_input)
                
            # Run your compiled C program or any command you want
            output = subprocess.check_output(["./banglacompfinal", "input.txt"], stderr=subprocess.STDOUT)
            output = output.decode("utf-8")
        except subprocess.CalledProcessError as e:
            output = f"Error: {e.output.decode('utf-8')}"
        return render_template("index.html", output=output, user_input=user_input)
    return render_template("index.html", output=None)

if __name__ == "__main__":
    app.run(debug=True)
from flask import Flask, render_template, request
import subprocess

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        user_input = request.form["user_input"]
        # Execute the program and get the output (example for C program)
        try:
            # Create a temporary file with user input (if necessary for your use case)
            with open("input.txt", "w") as f:
                f.write(user_input)
                
            # Run your compiled C program or any command you want
            output = subprocess.check_output(["./banglacompfinal", "input.txt"], stderr=subprocess.STDOUT)
            output = output.decode("utf-8")
        except subprocess.CalledProcessError as e:
            output = f"Error: {e.output.decode('utf-8')}"
        return render_template("index.html", output=output, user_input=user_input)
    return render_template("index.html", output=None)

if __name__ == "__main__":
    app.run(debug=True)

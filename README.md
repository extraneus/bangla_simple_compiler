
---

# Bangla Compiler Project

## Overview
This project implements a **Bangla-based compiler** that allows users to write and execute simple programs in the Bangla language. The compiler supports basic constructs such as variable assignments, conditional statements (`jodi`), and output statements (`liko`). It is built using **Flex** for lexical analysis and **Bison** for parsing.

The project also includes a **Flask-based web interface**, enabling users to compile and run Bangla code directly from a browser.

---

## Features
- **Bangla Language Support**: Write programs using Bangla keywords like `liko`, `jodi`, etc.
- **Basic Arithmetic**: Perform addition, subtraction, multiplication, and division.
- **Conditional Statements**: Use `jodi` for conditional execution.
- **Web Interface**: Compile and run Bangla code through a Flask-based web application.
- **Error Handling**: Provides meaningful error messages for syntax and runtime issues.

---

## Project Structure
The project consists of the following key files:
- `main.l`: Flex file for lexical analysis.
- `main.y`: Bison file for parsing and semantic actions.
- `app.py`: Flask application for the web interface.
- `templates/index.html`: HTML template for the web interface.
- `text.txt`: Example input file for testing the compiler.
- `banglacompfinal`: Compiled executable of the Bangla compiler.

---

## Setup Instructions

### Prerequisites
Before running the project, ensure you have the following installed:
1. **Flex**: For lexical analysis.
   ```bash
   sudo apt install flex
   ```
2. **Bison**: For parsing.
   ```bash
   sudo apt install bison
   ```
3. **GCC**: For compiling the generated C code.
   ```bash
   sudo apt install build-essential
   ```
4. **Python 3**: For running the Flask app.
   ```bash
   sudo apt install python3 python3-pip
   pip install flask
   ```

### Steps to Run the Compiler Locally
1. Clone the repository:
   ```bash
   git clone https://github.com/username/repository-name.git
   cd repository-name
   ```
2. Generate the lexer and parser:
   ```bash
   flex main.l
   bison -d main.y
   ```
3. Compile the generated C files:
   ```bash
   gcc lex.yy.c main.tab.c -o banglacompfinal
   ```
4. Run the compiler with an input file:
   ```bash
   ./banglacompfinal text.txt
   ```

### Steps to Run the Web Interface
1. Start the Flask server:
   ```bash
   python3 app.py
   ```
2. Open your browser and navigate to `http://127.0.0.1:5000/`.
3. Enter Bangla code in the editor and click "Compile" to see the output.

---

## Example Input
Here’s an example Bangla program (`text.txt`) to test the compiler:

```text
x = 10;
y = 20;

jodi (x < y) {
    liko("x is less than y");
}
```

### Expected Output
```text
Output: x is less than y
Parsing complete.
```

---

## Contributing
Contributions are welcome! If you’d like to improve this project, feel free to:
- Add new features (e.g., loops, arrays).
- Fix bugs or improve error handling.
- Enhance the web interface.

To contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

---

## License
This project is open source.

---

## Contact
For questions or feedback, feel free to reach out:
- Email: kolincoakash13@example.com
- GitHub: [Your GitHub Profile](https://github.com/extraneus)

---

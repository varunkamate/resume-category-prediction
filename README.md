# resume-category-prediction

🔍 Step 1: Extracting & Reviewing the Project
Let me first check what’s inside the ZIP file…
(Processing the contents now…)

Here’s what I found in the project folder:

📂 Project Structure:
python
Copy code
resume_ml_project/
├── Resume Screening with Python (2).ipynb   # Main Jupyter notebook
├── UpdatedResumeDataSet.xls                # Dataset (resume info)
├── app.py                                  # Flask app (for deployment)
├── tfidf.pkl                               # Saved TF-IDF vectorizer
├── clf.pkl                                 # Trained ML model
├── encoder.pkl                             # Label encoder

🧠 GitHub-Ready Visual Description (README)
You can use this as your GitHub README.md:

🧾 Resume Screening ML Project
🚀 A machine learning application that automatically classifies resumes based on job categories using NLP techniques and TF-IDF vectorization. The project also includes a Flask web app for interactive usage.

📌 Features
Cleans and processes raw resume data (from .xls)

Transforms text using TF-IDF vectorization

Trains a classification model to identify relevant job domain

Deploys a web interface for testing resumes online

📊 Visual Pipeline
mermaid
Copy code
graph TD;
    A[Input Resume Dataset] --> B[Text Preprocessing]
    B --> C[TF-IDF Vectorization]
    C --> D[Label Encoding]
    D --> E[Model Training (Classifier)]
    E --> F[Save Models (PKL files)]
    F --> G[Flask Web App Interface]
📁 Files Included
File	Description
Resume Screening with Python (2).ipynb	Main notebook for EDA + model building
UpdatedResumeDataSet.xls	Resume text + category labels
clf.pkl	Trained classifier (e.g. SVC)
tfidf.pkl	Fitted TF-IDF vectorizer
encoder.pkl	Encodes job categories
app.py	Web application script using Flask

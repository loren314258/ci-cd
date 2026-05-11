# שלב 1: שימוש ב-Base Image של Python 3.10 כפי שנדרש במשימה
FROM python:3.10-slim

# שלב 2: הגדרת תיקיית העבודה בתוך הקונטיינר
WORKDIR /app

# שלב 3: העתקת קובץ הדרישות והתקנתן
# אנחנו עושים את זה לפני העתקת הקוד כדי לנצל את ה-Cache של Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# שלב 4: העתקת קוד המקור לתוך הקונטיינר
# זה מחליף את הצורך ב-Volume עבור הקוד, כפי שביקשו ממך
COPY . .

# שלב 5: חשיפת הפורט עליו רצה האפליקציה (5000)
EXPOSE 5000

# שלב 6: הגדרת משתני סביבה (דיפולטיביים, ניתן לדרוס אותם ב-Docker Compose או ב-AWS)
ENV FLASK_APP=app.py
ENV DB_HOST=mysql
ENV DB_USER=root
ENV DB_PASSWORD=password
ENV DB_NAME=app_db

# שלב 7: פקודת ההרצה של האפליקציה
CMD ["python", "app.py"]
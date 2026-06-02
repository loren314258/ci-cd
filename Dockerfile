FROM python:3.10-slim

WORKDIR /app

# שימוש ב-Cache להתקנת תלויות
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# תיקון 1: העתקה סלקטיבית של קוד המקור בלבד
COPY app.py .

# תיקון 3: יצירת משתמש חסום ומעבר אליו בשביל אבטחה
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# תיקון 2: מחיקת ה-ENV הקשיחים עם הסיסמאות! (יוזרקו מבחוץ בזמן הריצה)

EXPOSE 5000

# תיקון 4: מעבר ל-ENTRYPOINT
ENTRYPOINT ["python", "app.py"]
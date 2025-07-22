use course_feedback;

db.feedback.createIndex({ student_id: 1 });
db.feedback.createIndex({ course_id: 1 });

SELECT 
    Students.student_id,
    Students.student_name,
    Courses.course_name,
    Courses.fees
FROM Students
Right JOIN Courses
ON Students.course_id = Courses.course_id;
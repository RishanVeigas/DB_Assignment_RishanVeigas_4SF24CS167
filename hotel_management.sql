create database if not exists HostelManagement;
use HostelManagement;

CREATE TABLE if not exists students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
) ;
CREATE TABLE if not exists student_phones (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    phone_number VARCHAR(15),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE
) ;

CREATE TABLE if not exists hostels (
    hostel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE if not exists rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_id INT,
    room_number VARCHAR(10),
    capacity INT NOT NULL,
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id)
        ON DELETE CASCADE
);

CREATE TABLE if not exists room_allocations (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    room_id INT,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
        ON DELETE CASCADE
);

CREATE TABLE if not exists wardens (
    warden_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
) ;

CREATE TABLE  if not exists hostel_wardens (
    hostel_id INT,
    warden_id INT,
    PRIMARY KEY (hostel_id, warden_id),
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id)
        ON DELETE CASCADE,
    FOREIGN KEY (warden_id) REFERENCES wardens(warden_id)
        ON DELETE CASCADE
) ;

CREATE TABLE if not exists maintenance_staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
) ;

CREATE TABLE if not exists complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,student_id INT,staff_id INT,
    description TEXT,status VARCHAR(50),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,FOREIGN KEY (student_id) REFERENCES students(student_id)
    ON DELETE CASCADE,FOREIGN KEY (staff_id) REFERENCES maintenance_staff(staff_id)
    ON DELETE SET NULL
) ;

INSERT INTO students (student_id, name, email) VALUES
(1, 'Rishan Veigas', 'rishan.veigas@gmail.com'),
(2, 'tanish poojary', 'tanish.reddy@gmail.com'),
(3, 'Aditya Yadav', 'aditya.yadav@gmail.com'),
(4, 'vikas ', 'vikas.mehta@gmail.com'),
(5, 'Ishaan Patel', 'ishaan.patel@gmail.com'),
(6, 'Rohan Das', 'rohan.das@gmail.com'),
(7, 'Karthik Iyer', 'karthik.iyer@gmail.com'),
(8, 'Rahul Verma', 'rahul.verma@gmail.com'),
(9, 'Siddharth Jain', 'siddharth.jain@gmail.com'),
(10, 'Dev Malhotra', 'dev.malhotra@gmail.com');

INSERT INTO student_phones (phone_id, student_id, phone_number) VALUES
(1, 1, '9876543210'),
(2, 1, '9123456780'),
(3, 2, '9988776655'),
(4, 3, '9876501234'),
(5, 4, '9765432109'),
(6, 5, '9654321098'),
(7, 6, '9543210987'),
(8, 7, '9432109876'),
(9, 8, '9321098765'),
(10, 9, '9210987654'),
(11, 10, '9109876543');

INSERT INTO hostels (hostel_id, name) VALUES
(1, 'Block A'),
(2, 'Block B'),
(3, 'Block C');

INSERT INTO rooms (room_id, hostel_id, room_number, capacity) VALUES
(1, 1, 'A101', 2),
(2, 1, 'A102', 3),
(3, 2, 'B201', 2),
(4, 2, 'B202', 2),
(5, 3, 'C301', 3);

INSERT INTO room_allocations (allocation_id, student_id, room_id, assigned_at) VALUES
(1, 1, 1, NOW()),
(2, 2, 1, NOW()),
(3, 3, 2, NOW()),
(4, 4, 2, NOW()),
(5, 5, 2, NOW()),
(6, 6, 3, NOW()),
(7, 7, 3, NOW()),
(8, 8, 4, NOW()),
(9, 9, 4, NOW()),
(10, 10, 5, NOW());

INSERT INTO wardens (warden_id, name) VALUES
(1, 'Mr. Suresh Kumar'),
(2, 'Mrs. Anita Rao'),
(3, 'Mr. Prakash Shetty');

INSERT INTO hostel_wardens (hostel_id, warden_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3);

INSERT INTO maintenance_staff (staff_id, name) VALUES
(1, 'Ramesh Electrician'),
(2, 'Mahesh Plumber'),
(3, 'Sanjay Carpenter');

INSERT INTO complaints (complaint_id, student_id, staff_id, description, status, created_at, resolved_at) VALUES
(1, 1, 1, 'Fan not working', 'Resolved', NOW(), NOW()),
(2, 2, 2, 'Water leakage in bathroom', 'Pending', NOW(), NULL),
(3, 3, 3, 'Broken chair', 'Resolved', NOW(), NOW()),
(4, 4, 1, 'Light not working', 'In Progress', NOW(), NULL),
(5, 5, 2, 'Clogged drain', 'Resolved', NOW(), NOW()),
(6, 6, 3, 'Table damaged', 'Pending', NOW(), NULL),
(7, 7, 1, 'Switch board issue', 'Resolved', NOW(), NOW());


SELECT h.name AS hostel, r.room_number, COUNT(ra.student_id) AS occupants
FROM rooms r
JOIN hostels h ON r.hostel_id = h.hostel_id
LEFT JOIN room_allocations ra ON r.room_id = ra.room_id
GROUP BY r.room_id;


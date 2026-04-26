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
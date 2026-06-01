CREATE DATABASE IF NOT EXISTS pasting_ddb;
USE pasting_ddb;

-- =====================================
-- MASTER TABLES
-- =====================================

CREATE TABLE user_role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_role_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    mid_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NOT NULL,
    user_role_id INT,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (user_role_id) REFERENCES user_role(id)
);

CREATE TABLE operators (
    id INT AUTO_INCREMENT PRIMARY KEY,
    users_id INT NOT NULL UNIQUE,

    FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE pasting_prod_line (
    id INT AUTO_INCREMENT PRIMARY KEY,
    line_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE time_shift (
    id INT AUTO_INCREMENT PRIMARY KEY,
    shift_name VARCHAR(100) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE plate_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE plate_specification (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate_name VARCHAR(100) NOT NULL,


    weight_usl DECIMAL(10,2),
    weight_target DECIMAL(10,2),
    weight_lsl DECIMAL(10,2),

    thick_usl DECIMAL(10,2),
    thick_target DECIMAL(10,2),
    thick_lsl DECIMAL(10,2),

    mc_lsl DECIMAL(10,2),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE,

    
);

CREATE TABLE run_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    run_type_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE plate_rack (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate_rack_no VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE curing_booth (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cb_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE plate_quality_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- =====================================
-- PLATE MC LOG
-- =====================================

CREATE TABLE plate_mc_log (
    id INT AUTO_INCREMENT PRIMARY KEY,

    pasting_line_id INT NOT NULL,
    operator_id INT NOT NULL,
    time_shift_id INT NOT NULL,
    plate_type_id INT NOT NULL,
    plate_specification_id INT NOT NULL,
    run_type_id INT NOT NULL,
    plate_rack_id INT NOT NULL,
    curing_booth_id INT NOT NULL,

    mc_date_log DATE,
    mc_time_log TIME,
    mc_result DECIMAL(10,2),

    plate_status_id INT NOT NULL,
    mc_remarks VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (pasting_line_id) REFERENCES pasting_prod_line(id),
    FOREIGN KEY (operator_id) REFERENCES operators(id),
    FOREIGN KEY (time_shift_id) REFERENCES time_shift(id),
    FOREIGN KEY (plate_type_id) REFERENCES plate_type(id),
    FOREIGN KEY (plate_specification_id) REFERENCES plate_specification(id),
    FOREIGN KEY (run_type_id) REFERENCES run_type(id),
    FOREIGN KEY (plate_rack_id) REFERENCES plate_rack(id),
    FOREIGN KEY (curing_booth_id) REFERENCES curing_booth(id),
    FOREIGN KEY (plate_status_id) REFERENCES plate_quality_status(id)
);

-- =====================================
-- PLATE THICKNESS LOG
-- =====================================

CREATE TABLE plate_thickness_log (
    id INT AUTO_INCREMENT PRIMARY KEY,

    pasting_line_id INT NOT NULL,
    operator_id INT NOT NULL,
    time_shift_id INT NOT NULL,
    plate_type_id INT NOT NULL,
    plate_specification_id INT NOT NULL,
    run_type_id INT NOT NULL,

    thick_date_log DATE,
    thick_time_log TIME,

    op_c1 DECIMAL(10,2),
    op_c2 DECIMAL(10,2),
    op_c3 DECIMAL(10,2),
    op_c4 DECIMAL(10,2),

    nop_c1 DECIMAL(10,2),
    nop_c2 DECIMAL(10,2),
    nop_c3 DECIMAL(10,2),
    nop_c4 DECIMAL(10,2),

    plate_status_id INT NOT NULL,
    thickness_remarks VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (pasting_line_id) REFERENCES pasting_prod_line(id),
    FOREIGN KEY (operator_id) REFERENCES operators(id),
    FOREIGN KEY (time_shift_id) REFERENCES time_shift(id),
    FOREIGN KEY (plate_type_id) REFERENCES plate_type(id),
    FOREIGN KEY (plate_specification_id) REFERENCES plate_specification(id),
    FOREIGN KEY (run_type_id) REFERENCES run_type(id),
    FOREIGN KEY (plate_status_id) REFERENCES plate_quality_status(id)
);

-- =====================================
-- PLATE WEIGHT LOG
-- =====================================

CREATE TABLE plate_weight_log (
    id INT AUTO_INCREMENT PRIMARY KEY,

    pasting_line_id INT NOT NULL,
    operator_id INT NOT NULL,
    time_shift_id INT NOT NULL,
    plate_type_id INT NOT NULL,
    plate_specification_id INT NOT NULL,
    run_type_id INT NOT NULL,

    weight_date_log DATE,
    weight_time_log TIME,

    op_w1 DECIMAL(10,2),
    op_w2 DECIMAL(10,2),
    op_w3 DECIMAL(10,2),
    op_w4 DECIMAL(10,2),
    nop_w1 DECIMAL(10,2),
    nop_w2 DECIMAL(10,2),
    nop_w3 DECIMAL(10,2),
    nop_w4 DECIMAL(10,2),

    plate_status_id INT NOT NULL,
    weight_remarks VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    is_active BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (pasting_line_id) REFERENCES pasting_prod_line(id),
    FOREIGN KEY (operator_id) REFERENCES operators(id),
    FOREIGN KEY (time_shift_id) REFERENCES time_shift(id),
    FOREIGN KEY (plate_type_id) REFERENCES plate_type(id),
    FOREIGN KEY (plate_specification_id) REFERENCES plate_specification(id),
    FOREIGN KEY (run_type_id) REFERENCES run_type(id),
    FOREIGN KEY (plate_status_id) REFERENCES plate_quality_status(id)
);
-- =====================================
-- USERS TABLE ENHANCEMENTS
-- =====================================

ALTER TABLE users
ADD COLUMN email_verified_at TIMESTAMP NULL AFTER password,
ADD COLUMN last_login_at TIMESTAMP NULL AFTER email_verified_at,
ADD COLUMN remember_token VARCHAR(100) NULL AFTER last_login_at,
ADD COLUMN deleted_at TIMESTAMP NULL AFTER is_active;

-- =====================================
-- EMAIL OTP VERIFICATION
-- =====================================

CREATE TABLE email_otp (
    id INT AUTO_INCREMENT PRIMARY KEY,

    email VARCHAR(150) NOT NULL,

    otp_hash VARCHAR(255) NOT NULL,

    expires_at TIMESTAMP NOT NULL,

    used_at TIMESTAMP NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- =====================================
-- LOGIN ATTEMPTS
-- =====================================

CREATE TABLE login_attempts (
    id INT AUTO_INCREMENT PRIMARY KEY,

    email VARCHAR(150) NOT NULL,

    ip_address VARCHAR(45) NULL,

    attempt_count INT DEFAULT 1,

    locked_until TIMESTAMP NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




-- =====================================
-- DEFAULT USER ROLES
-- =====================================

INSERT INTO user_role (user_role_name)
VALUES
('Admin'),
('Operator');

-- =====================================
-- DEFAULT QUALITY STATUS
-- =====================================

INSERT INTO plate_quality_status (status_name)
VALUES
('Pass'),
('Fail');

-- =====================================
-- DEFAULT RUN TYPES
-- =====================================

INSERT INTO run_type (run_type_name)
VALUES
('Startup'),
('Normal');
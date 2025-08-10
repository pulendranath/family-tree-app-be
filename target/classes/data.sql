-- Admin User
INSERT INTO users (id, username, password, role, relation) VALUES
(1, 'admin', '$2a$10$Dow1S5TeVuwSm2AkP01pfeDcWz6SEf8K5ckf2jaCMbdP2eUzHyb.q', 'ROLE_ADMIN', 'None');

-- Regular Users
INSERT INTO users (id, username, password, role, relation) VALUES
(2, 'alice', '8Js9RlHXkyProZXbzssYCw==', 'ROLE_USER', 'daughter of admin'),
(3, 'bob', '8Js9RlHXkyProZXbzssYCw==', 'ROLE_USER', 'son of admin'),
(4, 'charlie', '8Js9RlHXkyProZXbzssYCw==', 'ROLE_USER', 'son of bob');





-- 2. Users Table
CREATE TABLE users (

    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
    dob DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. User-Roles Mapping (Many-to-Many)
CREATE TABLE user_roles (
    user_id BIGINT,
    role_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- 4. Relation Types Table
CREATE TABLE relations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 5. Family Relationship Mapping
CREATE TABLE user_relations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,         -- Self
    related_user_id BIGINT NOT NULL, -- Father, Mother, etc.
    relation_id INT NOT NULL,        -- From relations table
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (related_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (relation_id) REFERENCES relations(id) ON DELETE CASCADE
);





INSERT INTO relations (name) VALUES
-- Direct Family
('FATHER'),
('MOTHER'),
('SON'),
('DAUGHTER'),
('BROTHER'),
('SISTER'),

-- Extended Family
('GRANDFATHER'),
('GRANDMOTHER'),
('GREAT GRANDFATHER'),
('GREAT GRANDMOTHER'),
('UNCLE'),
('AUNT'),
('NEPHEW'),
('NIECE'),
('COUSIN'),

-- In-Laws
('FATHER-IN-LAW'),
('MOTHER-IN-LAW'),
('SON-IN-LAW'),
('DAUGHTER-IN-LAW'),
('BROTHER-IN-LAW'),
('SISTER-IN-LAW'),

-- Spouse
('HUSBAND'),
('WIFE'),

-- Miscellaneous
('STEPFATHER'),
('STEPMOTHER'),
('STEPBROTHER'),
('STEPSISTER'),
('GODFATHER'),
('GODMOTHER'),
('ADOPTED SON'),
('ADOPTED DAUGHTER'),
('GUARDIAN'),
('WARD');

INSERT INTO roles (name) VALUES
('ROLE_ADMIN'),
('ROLE_USER'),
('ROLE_MANAGER'),
('ROLE_GUEST');


-- Insert Admin User (BCrypt-hashed password for "admin123")
INSERT INTO users (username, password, full_name, gender, dob)
VALUES ('Pulendranath', '$2a$10$geMu8KzxNY0QHNLUDKj7iu3fye.R4xgS/XFYRpgWZo8A1Pe.JUgxS', 'Mule Pulendranath', 'MALE', '1983-08-15');

select * from relation_1.users;
-- Map user to ROLE_ADMIN
-- Assuming the inserted user has ID = 1, and ROLE_ADMIN has ID = 1
INSERT INTO user_roles (user_id, role_id) VALUES (1, 1);

-- 1. Roles Table
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Users Table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    -- Authentication
    password VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,

    -- Personal Info
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
    dob DATE,
    dod DATE,

    -- Address Info
    address1 VARCHAR(255),
    address2 VARCHAR(255),
    address3 VARCHAR(255),
    village VARCHAR(100),
    state VARCHAR(100),
    district VARCHAR(100),
    nationality VARCHAR(100),
    pincode INT,

    -- Contact Info
    mobile_number VARCHAR(15) DEFAULT '0',
    alt_mobile_number VARCHAR(15),
    home_phone VARCHAR(15) DEFAULT '0',
    aadhar BIGINT,

    -- Other
    note TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_email ON users(email);
CREATE INDEX idx_aadhar ON users(aadhar);
CREATE INDEX idx_mobile ON users(mobile_number);


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

-- ALTER TABLE user_relations
-- DROP FOREIGN KEY FK7dgdiym68syavv3f3hekevhx5,
-- ADD CONSTRAINT fk_relation_id FOREIGN KEY (relation_id) REFERENCES relations(id);


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
INSERT INTO users (

    password,
    email,
    first_name,
    last_name,

    gender,
    dob,
    dod,
    address1,
    address2,
    address3,
    village,
    state,
    district,
    nationality,
    pincode,
    mobile_number,
    alt_mobile_number,
    home_phone,
    aadhar,
    note
) VALUES (

    '$2a$10$geMu8KzxNY0QHNLUDKj7iu3fye.R4xgS/XFYRpgWZo8A1Pe.JUgxS',
     'abcd@gmail.com',
    'Mule',
    'ramdas',

    'MALE',
    '1959-01-29',
    NULL,
    'teachers colony',
    NULL,
    NULL,
    'wanaparthy',
    'Telangana',
    'wanaparthy',
    'India',
    509103,
    '9966754791',
    '0',
    NULL,
    1234567891011,
    NULL
);



INSERT INTO user_roles (user_id, role_id) VALUES (1, 1);


--  1. Get Parents of an Ancestor

SELECT
    u.id AS child_id,
    u.first_name AS child_name,
    parent.id AS parent_id,
    parent.first_name AS parent_name,
    r.name AS relation
FROM user_relations ur
JOIN users u ON u.id = ur.user_id
JOIN users parent ON parent.id = ur.related_user_id
JOIN relations r ON r.id = ur.relation_id
WHERE ur.user_id = :ancestorId;



-- 2. Get Children of an Ancestor

SELECT
    parent.id AS parent_id,
    parent.first_name AS parent_name,
    u.id AS child_id,
    u.first_name AS child_name,
    r.name AS relation
FROM user_relations ur
JOIN users u ON u.id = ur.user_id
JOIN users parent ON parent.id = ur.related_user_id
JOIN relations r ON r.id = ur.relation_id
WHERE ur.related_user_id = :ancestorId;







-- All Ancestors (Parents, Grandparents, etc.)

WITH RECURSIVE ancestors AS (
    SELECT ur.related_user_id AS ancestor_id, ur.user_id AS child_id, r.name AS relation, 1 AS level
    FROM user_relations ur
    JOIN relations r ON ur.relation_id = r.id
    WHERE ur.user_id = :userId

    UNION ALL

    SELECT ur2.related_user_id, ur2.user_id, r.name, a.level + 1
    FROM user_relations ur2
    JOIN relations r ON ur2.relation_id = r.id
    JOIN ancestors a ON ur2.user_id = a.ancestor_id
)
SELECT u.*, a.relation, a.level
FROM ancestors a
JOIN users u ON u.id = a.ancestor_id;

ALTER TABLE users
ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


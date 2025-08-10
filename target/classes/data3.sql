-- 1. Roles Table
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Users Table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
    dob DATE,
    dod DATE,
    address1 VARCHAR(255),
    address2 VARCHAR(255),
    address3 VARCHAR(255),
    village VARCHAR(100),
    state VARCHAR(100),
    district VARCHAR(100),
    nationality VARCHAR(100),
    pincode INT,
    mobile_number VARCHAR(15) DEFAULT '0',
    alt_mobile_number VARCHAR(15),
    home_phone VARCHAR(15) DEFAULT '0',
    aadhar BIGINT,
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
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

CREATE INDEX idx_related_user_id ON user_relations(related_user_id);
CREATE INDEX idx_relation_id ON user_relations(relation_id);

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
)
VALUES (
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'muleadmin@gmail.com',
    'Mule',
    'admin',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

INSERT INTO user_roles (user_id, role_id) VALUES ((select id from users where email ='muleadmin@gmail.com') , (select id from roles where name='ROLE_ADMIN') );
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'rootfather@gmail.com',
    'Mule',
    'rootfather',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlamuthyalu@gmail.com',
    'Mojarla',
    'Muthyalu',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachandramma@gmail.com',
    'Mojarla',
    'Chandramma/Chennamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlathimmayya@gmail.com',
    'Mojarla',
    'thimmayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapeddabalayya@gmail.com',
    'Mojarla',
    'pedda balayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlaramanna@gmail.com',
    'Mojarla',
    'ramanna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlalaxmaiah@gmail.com',
    'Mojarla',
    'laxmanna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachinnabalayya@gmail.com',
    'Mojarla',
    'chinna balayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapeddabalamma@gmail.com',
    'Mojarla',
    'pedda balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlakistamma@gmail.com',
    'Mojarla',
    'kistamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlavallamma@gmail.com',
    'Mojarla',
    'vallamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlajammulamma@gmail.com',
    'Mojarla',
    'jammulamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapeddakistaiah@gmail.com',
    'Mojarla',
    'pedda kistaiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabuddanna@gmail.com',
    'Mojarla',
    'buddanna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabakkamma@gmail.com',
    'Mojarla',
    'bakkamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlaramulamma@gmail.com',
    'Mojarla',
    'ramulamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlalachchamma@gmail.com',
    'Mojarla',
    'lachchamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachandraiahpb@gmail.com',
    'Mojarla',
    'chandraiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapentaiahpb@gmail.com',
    'Mojarla',
    'pentaiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlamutyalammapb@gmail.com',
    'Mojarla',
    'mutyalamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapentammapb@gmail.com',
    'Mojarla',
    'pentamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabalammarna@gmail.com',
    'Mojarla',
    'balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabalammapb@gmail.com',
    'Mojarla',
    'balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlathimmanna@gmail.com',
    'Mojarla',
    'thimmanna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabalayyatmna@gmail.com',
    'Mojarla',
    'balayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachilukammatmna@gmail.com',
    'Mojarla',
    'chilukamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarladevammatmna@gmail.com',
    'Mojarla',
    'devamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlagoddammatmna@gmail.com',
    'Mojarla',
    'goddamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapentammatmna@gmail.com',
    'Mojarla',
    'pentamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlashankarammatmna@gmail.com',
    'Mojarla',
    'shankaramma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlavallammatmna@gmail.com',
    'Mojarla',
    'vallamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulebalammatmna@gmail.com',
    'Mule',
    'balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabalammalxmna@gmail.com',
    'Mojarla',
    'balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlaayyammalxmna@gmail.com',
    'Mojarla',
    'ayyanna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlaayyannalxmna@gmail.com',
    'Mojarla',
    'ayyanna',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachennammacbl@gmail.com',
    'mojarla',
    'chennamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlacgopannacbl@gmail.com',
    'mojarla',
    'gopanna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachennayyacbl@gmail.com',
    'mojarla',
    'chennayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapeddabalammacbl@gmail.com',
    'mojarla',
    'pedda balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachinnabalammacbl@gmail.com',
    'mojarla',
    'chinna balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlacgopannacbl@gmail.com',
    'mojarla',
    'gopanna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettichandrayyapblm@gmail.com',
    'Jetti',
    'chandrayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettichinnagalennapblm@gmail.com',
    'Jetti',
    'chinna galenna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettipeddagalennapblm@gmail.com',
    'Jetti',
    'pedda galenna',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettibichammapblm@gmail.com',
    'Jetti',
    'Bichamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettibichayyaksm@gmail.com',
    'Jetti',
    'bichayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettimadhapuramkistayyaksm@gmail.com',
    'Jetti',
    'madhapuram kistayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulechandraiahvlm@gmail.com',
    'mule',
    'chandraiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulemaddiletipolicehvlm@gmail.com',
    'mule',
    'police maddileti',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulemkurmaiahvlm@gmail.com',
    'mule',
    'kurmaiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulemlaxmivlm@gmail.com',
    'mule',
    'laxmi',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulemlachammavlm@gmail.com',
    'mule',
    'lachamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);


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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulekuruvammavlm@gmail.com',
    'mule',
    'kuruvamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlaadivammapksta@gmail.com',
    'mojarla',
    'adivamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlakurumayyapksta@gmail.com',
    'mojarla',
    'kurumayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachennayyapksta@gmail.com',
    'mojarla',
    'chennayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachennammapksta@gmail.com',
    'mojarla',
    'chennamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

-- 1.2 buddanna

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlawifebuddannabdna@gmail.com',
    'mojarla',
    'Wife name not found',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabalaswamybdna@gmail.com',
    'mojarla',
    'balaswamy',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapeddabalayyabdna@gmail.com',
    'mojarla',
    'pedda balayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachinnabalayyabdna@gmail.com',
    'mojarla',
    'chinna balayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlkrishnaiahbdna@gmail.com',
    'mojarla',
    'krishnaiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlakalavathibdna@gmail.com',
    'mojarla',
    'kalavathi',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlaneelavathibdna@gmail.com',
    'mojarla',
    'neelavathi',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

-- 1.3 bakkamma

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettitakkasilabkma@gmail.com',
    'jetti',
    'takksila',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettipeddamaddiletibkma@gmail.com',
    'jetti',
    'pedda maddileti',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettichinnamaddiletibkma@gmail.com',
    'jetti',
    'chinna maddileti',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettilaxmidevammabkma@gmail.com',
    'jetti',
    'laxmi devamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettilaxmibkma@gmail.com',
    'jetti',
    'laxmi',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettitakkasilabkma@gmail.com'),
(select id from users where email='mojarlabakkamma@gmail.com'),
(select id from relations where name ='HUSBAND'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettipeddamaddiletibkma@gmail.com'),
(select id from users where email='jettitakkasilabkma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettichinnamaddiletibkma@gmail.com'),
(select id from users where email='jettitakkasilabkma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettilaxmidevammabkma@gmail.com'),
(select id from users where email='jettitakkasilabkma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettilaxmibkma@gmail.com'),
(select id from users where email='jettitakkasilabkma@gmail.com'),
(select id from relations where name ='FATHER'));



-- 1.4 ramulamma
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mulekistaiahrmlma@gmail.com',
    'jetti',
    'kistaiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mulekistaiahrmlma@gmail.com'),
(select id from users where email='mojarlaramulamma@gmail.com'),
(select id from relations where name ='HUSBAND'));

-- 1.5 lachamma
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettikistaiahlchma@gmail.com',
    'jetti',
    'kistaiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettichennammalchma@gmail.com',
    'jetti',
    'chennamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettikurumayyalchma@gmail.com',
    'jetti',
    'kurumayya',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettimaddiletilchma@gmail.com',
    'jetti',
    'maddileti',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettichandraiahlchma@gmail.com',
    'jetti',
    'chandraiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettikeshavululchma@gmail.com',
    'jetti',
    'keshavulu',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'jettibikshapathilchma@gmail.com',
    'jetti',
    'bikshapathi',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettikistaiahlchma@gmail.com'),
(select id from users where email='mojarlalachchamma@gmail.com'),
(select id from relations where name ='HUSBAND'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettichennammalchma@gmail.com'),
(select id from users where email='jettikistaiahlchma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettikurumayyalchma@gmail.com'),
(select id from users where email='jettikistaiahlchma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettimaddiletilchma@gmail.com'),
(select id from users where email='jettikistaiahlchma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettichandraiahlchma@gmail.com'),
(select id from users where email='jettikistaiahlchma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettikeshavululchma@gmail.com'),
(select id from users where email='jettikistaiahlchma@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettibikshapathilchma@gmail.com'),
(select id from users where email='jettikistaiahlchma@gmail.com'),
(select id from relations where name ='FATHER'));

-- 2.1 pedda balayya

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlanarsammapbch@gmail.com',
    'mojarla',
    'narsamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);


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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlavenkataiahpbch@gmail.com',
    'mojarla',
    'venkataiah',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);

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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabalarajupbch@gmail.com',
    'mojarla',
    'balaraju',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlamogalalipbch@gmail.com',
    'mojarla',
    'mogalali',
    'MALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapeddachennammapbch@gmail.com',
    'mojarla',
    'pedda chennamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlachinnachennammapbch@gmail.com',
    'mojarla',
    'chinna chennamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlapadmapbch@gmail.com',
    'mojarla',
    'padma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
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
    '$2a$10$cGItJR8Qqw8V1BCUKRYxS.CXxln3kKtDqLJoUZo24mmjE548G9FVu',
     'mojarlabalammapbch@gmail.com',
    'mojarla',
    'balamma',
    'FEMALE',
    '1800-01-01',
    NULL,
    'kollapur',
    NULL,
    NULL,
    'Kollapur',
    'Telangana',
    'Kollapur',
    'India',
    509001,
    '0000000000',
    '0',
    NULL,
    000000000000,
    NULL
);
INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlanarsammapbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='WIFE'));



INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlavenkataiahpbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlabalarajupbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlamogalalipbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapeddachennammapbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachinnachennammapbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapadmapbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlabalammapbch@gmail.com'),
(select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from relations where name ='FATHER'));

-- 2.pentaiah family
 -- wife
 -- krishna etc
















-- 0.mutyalu
INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from users where email='mojarlachandramma@gmail.com'),
 (select id from relations where name ='WIFE'));

 INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlathimmayya@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapeddabalayya@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaramanna@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlalaxmanna@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachinnabalayya@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapeddabalamma@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));

   INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlakistamma@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));

   INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlavallamma@gmail.com'),
 (select id from users where email='mojarlamuthyalu@gmail.com'),
 (select id from relations where name ='FATHER'));




-- 1.mojarla     thimmayya family
INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlathimmayya@gmail.com'),
 (select id from users where email='mojarlajammulamma@gmail.com'),
 (select id from relations where name ='WIFE'));



  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapeddakistaiah@gmail.com'),
 (select id from users where email='mojarlathimmayya@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
 ((select id from users where email='mojarlabuddanna@gmail.com'),
  (select id from users where email='mojarlathimmayya@gmail.com'),
  (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlabakkamma@gmail.com'),
 (select id from users where email='mojarlathimmayya@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaramulamma@gmail.com'),
 (select id from users where email='mojarlathimmayya@gmail.com'),
 (select id from relations where name ='FATHER'));

  INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlalachchamma@gmail.com'),
 (select id from users where email='mojarlathimmayya@gmail.com'),
 (select id from relations where name ='FATHER'));

-- 2.mojarla peddabalayya family

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapeddabalayya@gmail.com'),
(select id from users where email='mojarlabalammapb@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachandraiahpb@gmail.com'),
(select id from users where email='mojarlapeddabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapentaiahpb@gmail.com'),
(select id from users where email='mojarlapeddabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlamutyalammapb@gmail.com'),
(select id from users where email='mojarlapeddabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapentammapb@gmail.com'),
(select id from users where email='mojarlapeddabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

-- 3.mojarla ramanna family

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaramanna@gmail.com'),
(select id from users where email='mojarlabalammarna@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaramanna@gmail.com'),
(select id from users where email='mulebalammatmna@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlathimmanna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlabalayyatmna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachilukammatmna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarladevammatmna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlagoddammatmna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapentammatmna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlashankarammatmna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlavallammatmna@gmail.com'),
(select id from users where email='mojarlaramanna@gmail.com'),
(select id from relations where name ='FATHER'));

-- 4.laxmanna family

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlalaxmanna@gmail.com'),
(select id from users where email='mojarlabalammalxmna@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaayyammalxmna@gmail.com'),
(select id from users where email='mojarlalaxmanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaayyannalxmna@gmail.com'),
(select id from users where email='mojarlalaxmanna@gmail.com'),
(select id from relations where name ='FATHER'));

-- 5.chinna balayya
INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachennammacbl@gmail.com'),
(select id from users where email='mojarlachinnabalayya@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlacgopannacbl@gmail.com'),
(select id from users where email='mojarlachinnabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachennayyacbl@gmail.com'),
(select id from users where email='mojarlachinnabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapeddabalammacbl@gmail.com'),
(select id from users where email='mojarlachinnabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachinnabalammacbl@gmail.com'),
(select id from users where email='mojarlachinnabalayya@gmail.com'),
(select id from relations where name ='FATHER'));

-- 6.pedda balamma

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettichandrayyapblm@gmail.com'),
(select id from users where email='mojarlapeddabalamma@gmail.com'),
(select id from relations where name ='HUSBAND'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettichinnagalennapblm@gmail.com'),
(select id from users where email='jettichandrayyapblm@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettipeddagalennapblm@gmail.com'),
(select id from users where email='jettichandrayyapblm@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettibichammapblm@gmail.com'),
(select id from users where email='jettichandrayyapblm@gmail.com'),
(select id from relations where name ='FATHER'));


-- 7. kistamma

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettibichayyaksm@gmail.com'),
(select id from users where email='mojarlakistamma@gmail.com'),
(select id from relations where name ='HUSBAND'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='jettimadhapuramkistayyaksm@gmail.com'),
(select id from users where email='jettibichayyaksm@gmail.com'),
(select id from relations where name ='FATHER'));

-- 8.vallamma

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mulechandraiahvlm@gmail.com'),
(select id from users where email='mojarlavallamma@gmail.com'),
(select id from relations where name ='HUSBAND'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mulemaddiletipolicehvlm@gmail.com'),
(select id from users where email='jettibichayyaksm@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mulemkurmaiahvlm@gmail.com'),
(select id from users where email='mulechandraiahvlm@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mulemlaxmivlm@gmail.com'),
(select id from users where email='mulechandraiahvlm@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mulemlachammavlm@gmail.com'),
(select id from users where email='mulechandraiahvlm@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mulekuruvammavlm@gmail.com'),
(select id from users where email='mulechandraiahvlm@gmail.com'),
(select id from relations where name ='FATHER'));

-- 1.1 pedda kistayya
INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaadivammapksta@gmail.com'),
(select id from users where email='mojarlapeddakistaiah@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlakurumayyapksta@gmail.com'),
(select id from users where email='mojarlapeddakistaiah@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachennayyapksta@gmail.com'),
(select id from users where email='mojarlapeddakistaiah@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachennammapksta@gmail.com'),
(select id from users where email='mojarlapeddakistaiah@gmail.com'),
(select id from relations where name ='FATHER'));

-- 1.2 buddanna

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlawifebuddannabdna@gmail.com'),
(select id from users where email='mojarlabuddanna@gmail.com'),
(select id from relations where name ='WIFE'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlabalaswamybdna@gmail.com'),
(select id from users where email='mojarlabuddanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlapeddabalayyabdna@gmail.com'),
(select id from users where email='mojarlabuddanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlachinnabalayyabdna@gmail.com'),
(select id from users where email='mojarlabuddanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlkrishnaiahbdna@gmail.com'),
(select id from users where email='mojarlabuddanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlakalavathibdna@gmail.com'),
(select id from users where email='mojarlabuddanna@gmail.com'),
(select id from relations where name ='FATHER'));

INSERT INTO user_relations (user_id, related_user_id, relation_id) VALUES
((select id from users where email='mojarlaneelavathibdna@gmail.com'),
(select id from users where email='mojarlabuddanna@gmail.com'),
(select id from relations where name ='FATHER'));





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


-- Insert missing reverse spouse records
INSERT INTO user_relations (user_id, related_user_id, relation_id)
SELECT
  ur1.related_user_id AS user_id,
  ur1.user_id AS related_user_id,
  CASE
    WHEN ur1.relation_id = 22 THEN 23  -- HUSBAND → WIFE
    WHEN ur1.relation_id = 23 THEN 22  -- WIFE → HUSBAND
  END AS relation_id
FROM user_relations ur1
LEFT JOIN user_relations ur2
  ON ur2.user_id = ur1.related_user_id
  AND ur2.related_user_id = ur1.user_id
  AND (
    (ur1.relation_id = 22 AND ur2.relation_id = 23) OR
    (ur1.relation_id = 23 AND ur2.relation_id = 22)
  )
WHERE ur1.relation_id IN (22, 23)
  AND ur2.id IS NULL;

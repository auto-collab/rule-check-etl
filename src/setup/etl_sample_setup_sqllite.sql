-- Create the landing table
CREATE TABLE landing (
    id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create the staging table
CREATE TABLE staging (
    id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    created_at DATETIME,
    is_valid INTEGER,
    transformed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create the production table
CREATE TABLE prod (
    id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    created_at DATETIME,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

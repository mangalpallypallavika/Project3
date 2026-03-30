CREATE EXTENSION IF NOT EXISTS google_ml_integration CASCADE;
CREATE EXTENSION IF NOT EXISTS vector;

-- Books Table (The "Profile" you search for)
CREATE TABLE books (
    book_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seller_id UUID,
    seller_name TEXT,
    seller_phone TEXT,
    title TEXT,
    bio TEXT,
    subject TEXT,
    image_url TEXT,
    book_vector VECTOR(768),
    condition TEXT DEFAULT 'good',
    price NUMERIC(6,2),
    status TEXT DEFAULT 'available',
    created_at TIMESTAMP DEFAULT NOW()
);

-- Requests Table (The Interaction)
CREATE TABLE requests (
    request_id SERIAL PRIMARY KEY,
    buyer_id UUID,
    book_id UUID REFERENCES books(book_id),
    action TEXT CHECK (action IN ('skip', 'claim')),
    is_matched BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

GRANT EXECUTE ON FUNCTION embedding TO postgres;

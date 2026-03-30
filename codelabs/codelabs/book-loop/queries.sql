-- Register Gemini 3 Flash model
CALL google_ml.create_model(
    model_id => 'gemini-3-flash-preview',
    model_request_url => 'https://aiplatform.googleapis.com/v1/projects/<<YOUR_PROJECT_ID>>/locations/global/publishers/google/models/gemini-3-flash-preview:generateContent',
    model_qualified_name => 'gemini-3-flash-preview',
    model_provider => 'google',
    model_type => 'llm',
    model_auth_type => 'alloydb_service_agent_iam'
);

-- Insert a book with auto-generated embedding
INSERT INTO books (seller_name, seller_phone, title, bio, subject, image_url, price, book_vector)
VALUES (
    'Pallavika', '9876543210',
    'Python Crash Course',
    'Barely highlighted. Survived one semester. Ready for yours.',
    'Programming',
    'https://storage.googleapis.com/bookloop-images/python-crash-course.jpg',
    199.00,
    embedding('text-embedding-005', 'Python Crash Course Barely highlighted. Survived one semester. Ready for yours.')::vector
);

-- YOUR CUSTOM NATURAL LANGUAGE QUERY
-- "Show me affordable data science books in good condition"
SELECT book_id, title, bio, subject, price, condition, image_url,
       1 - (book_vector <=> embedding('text-embedding-005',
           'affordable data science books in good condition')::vector) AS score
FROM books
WHERE status = 'available'
  AND book_vector IS NOT NULL
  AND ai.if(
        prompt => 'Does this book description: "' || bio || '" match the request: "affordable data science books in good condition" at least 60%?',
        model_id => 'gemini-3-flash-preview'
      )
ORDER BY score DESC
LIMIT 5;

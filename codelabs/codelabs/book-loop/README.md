# BookLoop — AI-Powered Campus Book Exchange

> Querying a student textbook exchange to match buyers with available books using natural language and in-database AI.

Built with AlloyDB for PostgreSQL + Gemini 3 Flash.

## Use Case
Students list used textbooks. Other students find them using natural language like:
"Show me affordable data science books in good condition"

## Tech Stack
- AlloyDB for PostgreSQL (pgvector + google_ml_integration)
- Gemini 3 Flash (in-database AI reasoning)
- Google Cloud Run
- Flask (Python backend)

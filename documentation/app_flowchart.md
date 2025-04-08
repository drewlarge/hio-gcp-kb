flowchart TD
    A[Landing Page] --> B[Sign Up and Login]
    B --> C[Dashboard]
    C --> D[User Query]
    D --> E[API Gateway]
    E --> F[Cloud Functions]
    F --> G[Vertex AI]
    G --> H[Display Answer]
    C --> I[Document Upload]
    I --> J[Cloud Storage]
    J --> K[Document AI]
    J --> L[Cloud Vision]
    K --> M[Display Processed Document]
    L --> M
    C --> N[Chatbot Interface]
    N --> O[Dialogflow CX]
    O --> E
    C --> P[Settings and Account Management]
    H --> Q[Error Handling]
    M --> Q
    Q --> R[Show Retry Option]
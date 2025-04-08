# Real Estate Knowledge Base - Project Requirements Document

## 1. Project Overview

This project is about building a comprehensive real estate knowledge base hosted in Google Cloud Platform (GCP) that leverages AI/ML tools to power a custom large language model (LLM). This LLM will be central to the system, offering detailed, context-rich insights into real estate data that users (home buyers, investors, and real estate professionals) can access via chatbots, web apps, and mobile apps. By integrating multiple Google Cloud services, such as Vertex AI, Document AI, and Cloud Vision, the system not only processes and organizes a diverse array of real estate information but also continuously learns and adapts to user queries and data updates.

The system is being built to address the challenge of quickly accessing and analyzing a vast amount of real estate data—from property listings to legal documents and transaction histories—in a secure, efficient, and user-friendly manner. The key success criteria are excellent performance with low response times, scalability to handle growing data volumes, robust security for sensitive information, and seamless integration across various platforms using GCP services, Supabase, and advanced AI models. An intuitive user interface on both web (Next.js) and mobile (Flutter) platforms, along with powerful chatbot support via Dialogflow CX, will ensure high levels of usability and engagement.

## 2. In-Scope vs. Out-of-Scope

### In-Scope

*   **Data Management:** Utilizing Supabase for structured data management and Cloud Storage for file/document storage.
*   **AI/ML Integration:** Developing and deploying a custom LLM with Vertex AI, integrating Document AI for extracting data from documents, and using Cloud Vision for image analysis.
*   **API & Backend:** Building a backend using Cloud Functions, Cloud Run, and API Gateway to expose and manage REST API endpoints for web, mobile, and chatbot interactions.
*   **User Platforms:** Creating a responsive web application using Next.js and a cross-platform mobile app using Flutter.
*   **Chatbot Integration:** Implementing an intelligent chatbot powered by Dialogflow CX with interaction capabilities via REST APIs connecting to other GCP services.
*   **Security & Access Control:** Enforcing role-based access using Google Cloud IAM along with Supabase’s Row-Level Security, encryption in transit and at rest.
*   **Daily Data Updates:** Supporting a mix of automated daily data ingestion and manual uploads for data that doesn’t have routine updates.

### Out-of-Scope

*   **Advanced Analytics & Reporting Tools:** Deep analytics dashboards or customized advanced reporting features will be considered in future phases.
*   **Non-Real Estate Data Sources:** Integration with non-real estate related data or third-party services outside the specified scope.
*   **Third-Party Marketing Integrations:** Any external marketing tools or CRM systems are not part of this initial development.
*   **Extensive Customization for Different User Interfaces:** While a clean and modern design is required, highly customized or niche UI features for each role will be deferred to later updates.

## 3. User Flow

A new user will begin by accessing the application on either the web or mobile platform. They will be greeted with a simple login or sign-up screen, where identity verification and role assignment (first-time home buyer, real estate investor, professional, or administrative user) take place. Once logged in, the user lands on a personalized dashboard that displays data relevant to their role; for example, property listings for buyers, investment analytics for investors, and comprehensive tools for professionals.

After accessing the dashboard, the user can interact with the system in one of two main ways. They may choose to query the custom LLM by entering questions or search terms, which are sent through secure REST API calls to Cloud Functions interfacing with Vertex AI. Alternatively, if they need to process documents, they can upload files directly via the app; these files are then stored in Cloud Storage and processed using Document AI and Cloud Vision. Results are either displayed on the dashboard or fed into real-time chatbot interactions powered by Dialogflow CX, ensuring a smooth and informative journey throughout the system.

## 4. Core Features (Bullet Points)

*   **User Authentication and Role Management**

    *   Login/sign-up process with role-based access control (first-time home buyers, investors, professionals, administrative users).
    *   Integration with Google Cloud IAM and Supabase Row-Level Security.

*   **Data Management and Organization**

    *   Structured data storage using Supabase.
    *   File and document storage using Cloud Storage.
    *   Categorization of data into Listings, Legal Documents, Property Images, Transaction Histories, and Area Statistics.

*   **AI and Machine Learning Integration**

    *   Custom LLM developed and deployed with Vertex AI to process natural language queries.
    *   Use of Document AI for extracting structured data from uploaded documents.
    *   Integration of Cloud Vision for analyzing real estate images.

*   **Backend API Services**

    *   REST API endpoints managed via API Gateway.
    *   Business logic and processing through Cloud Functions and Cloud Run to handle API calls, model interactions, and data processing.

*   **Frontend Interfaces**

    *   Responsive web application built with Next.js.
    *   Cross-platform mobile application developed with Flutter.
    *   Clean, modern design with a color palette and typography that communicates trust and professionalism.

*   **Chatbot Integration**

    *   Intelligent chatbot powered by Dialogflow CX to interact with users.
    *   Chatbot that routes inquiries to backend services and leverages APIs like Vision API, BigQuery ML, and Palm API for enhanced responses.

*   **Automated Data Ingestion & Manual Updates**

    *   Automated daily data ingestion processes combined with manual file/document uploads for non-standard updates.

## 5. Tech Stack & Tools

*   **Frontend:**

    *   Next.js for web application development.
    *   Flutter for cross-platform mobile app development.

*   **Backend & API:**

    *   Cloud Functions and Cloud Run for serverless computing and managing business logic.
    *   API Gateway to expose and manage REST API endpoints.

*   **Data Management:**

    *   Supabase for managing structured data and enforcing secure access policies.
    *   Cloud Storage for handling large volumes of documents and images.

*   **AI/ML Components:**

    *   Vertex AI for developing and deploying a custom large language model (LLM).
    *   Document AI for processing real estate documents.
    *   Cloud Vision for image recognition and analysis.
    *   Vision API, BigQuery ML, and Palm API for future advanced chatbot and data analysis features.
    *   Gemini 2.5 Pro to assist with complex AI-powered coding decisions and problem solving, powered by the Cursor IDE integration.

*   **Chatbot:**

    *   Dialogflow CX for natural language understanding and managing conversational interactions.

## 6. Non-Functional Requirements

*   **Performance:**

    *   Ensure minimal API response times using caching strategies and efficient routing via API Gateway.
    *   Optimize frontend rendering with techniques like server-side rendering and static site generation (Next.js) for fast load times.

*   **Scalability:**

    *   Leverage GCP auto-scaling (Cloud Run and Cloud Functions) to handle fluctuating workloads.
    *   Data systems (Supabase and Cloud Storage) must support growing datasets and high query volumes.

*   **Reliability:**

    *   High availability through redundant deployments across multiple regions.
    *   Use of failover strategies and load balancing to manage peak traffic.

*   **Security:**

    *   Enforce secure authentication with Google Cloud IAM and Supabase’s security features.
    *   Encrypt data in transit (using TLS) and at rest.
    *   Compliance with legal data protection standards (e.g., GDPR) through regular security audits.

*   **Usability:**

    *   Intuitive user interfaces that follow modern UI/UX trends.
    *   Consistent design across web and mobile platforms, ensuring accessibility and ease of use for all roles.

## 7. Constraints & Assumptions

*   The project depends on the availability and proper configuration of various GCP services (Vertex AI, Cloud Functions, Cloud Run, etc.) and third-party tools (Supabase, Dialogflow CX).
*   Assumes a daily update cycle for real estate data combined with manual intervention for specialized documents.
*   The system will be built with current scalable and secure cloud technologies; however, future innovations may require additional integration efforts.
*   It is assumed that the provided color scheme and typography guidelines (colors: Blue - 12156e, Green - 0d9f4c, Orange - d4560a, Grey - 999999, White - 000000, Black - ffffff; fonts: Roboto for body text, Roboto Condensed for headers) will be adhered to by design teams.
*   Dependence on Dialogflow CX for real-time chatbot integration requires stable API communication and a fallback mechanism if any service disruption occurs.

## 8. Known Issues & Potential Pitfalls

*   **API Rate Limits & Latency:** With multiple services (API Gateway, Cloud Functions, Vertex AI) interacting, there is a potential risk of hitting API rate limits or experiencing latency. Mitigation can be through caching, load balancing, and proper scaling configurations.
*   **Integration Complexity:** Coordinating data flows between several services (Supabase, Cloud Storage, Document AI, Cloud Vision, and Dialogflow CX) may introduce complexities. Clear API contracts and regular integration testing can help reduce integration errors.
*   **Data Security and Compliance:** Handling sensitive real estate data requires continuous security assessments. Regular audits and adherence to compliance requirements (like GDPR) are crucial.
*   **Resource Management:** The auto-scaling features on Cloud Run and Cloud Functions must be properly configured to avoid unnecessary costs or resource wastage, especially during low-usage periods.
*   **Dependency on GCP Services:** Any changes or deprecations in GCP services could affect system performance. Keeping abreast of the latest updates from GCP and planning for alternative backups is recommended.
*   **Document Processing Variability:** Unstructured document inputs might not always parse cleanly with Document AI or Cloud Vision. Incorporating error handling and allowing for manual review can help mitigate inaccuracies.

This document provides a comprehensive, unambiguous reference for the AI model, forming the backbone of all subsequent technical documents and implementation plans.

# Implementation plan

This plan outlines the step-by-step instructions for building a real estate knowledge base in GCP, leveraging AI/ML services and integrating multiple frontends (Next.js and Flutter) with a robust backend. The instructions below have been derived from project requirements and technical details.

## Phase 1: Environment Setup

1.  **Prevalidation**: Check if the current directory is already initialized as a project (e.g., look for `.git` or key project files) before proceeding. *(Project Requirements: Project Initialization)*

2.  **Node.js Installation**: Verify that Node.js v20.2.1 is installed by running `node -v`. If not, install Node.js v20.2.1. *(Tech Stack: Core Tools)

3.  **Cursor Metrics File Creation**: Since we are using Cursor IDE, create a `cursor_metrics.md` file at the project root. *(Cursor Integration Guidelines)*

4.  **Creating Cursor Configuration Directory**: Check for a `.cursor` directory in the project root. If it doesn’t exist, create it. *(Cursor Integration Guidelines)*

5.  **Configure MCP for Supabase**: Inside the `.cursor` directory, check for a file named `mcp.json`. If it does not exist, create it and open the file. *(Cursor Integration Guidelines)*

6.  **Add Environment-Specific MCP Configurations**:

    *   For **macOS**, add:

7.  `{ "mcpServers": { "supabase": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-postgres", "<connection-string>"] } } }`

    *   For **Windows**, add:

8.  `{ "mcpServers": { "supabase": { "command": "cmd", "args": ["/c", "npx", "-y", "@modelcontextprotocol/server-postgres", "<connection-string>"] } } }`

9.  *(Cursor Integration Guidelines, Tech Stack: Supabase)*

10. **Provide Connection String Link**: Display the following link to the user so they can obtain the Supabase connection string: [Supabase MCP Guide](https://supabase.com/docs/guides/getting-started/mcp#connect-to-supabase-using-mcp).

11. **Update MCP Configuration**: Once the connection string is provided by the user, replace `<connection-string>` in the configuration file with the actual string. *(Cursor Integration Guidelines)*

12. **Confirmation**: Navigate within the Cursor IDE to Settings → MCP and verify that the server status is active (green indicator). *(Cursor Integration Guidelines)*

## Phase 2: Frontend Development

*We have two frontends: Next.js (web app) and Flutter (mobile app).*

1.  **Prevalidation**: Confirm that no existing Next.js or Flutter project conflicts exist in the project directory.
2.  **Next.js Project Setup**: Initialize a Next.js project using Next.js 14 (Note: Next.js 14 is recommended for better compatibility with AI-driven coding tools):

`npx create-next-app@14 my-next-app `*(Tech Stack: Next.js)*

1.  **UI Setup for Web App**: In the Next.js project, create a global stylesheet (e.g., `/styles/globals.css`) and apply the UI design guidelines with the following color palette:

    *   Blue: #12156e
    *   Green: #0d9f4c
    *   Orange: #d4560a
    *   Grey: #999999
    *   White: #ffffff
    *   Black: #000000 Also, set Roboto as the body font and Roboto Condensed for headers. *(UI/UX Design)*

2.  **Routing and Layout**: Create a master layout component (`/components/Layout.js`) and configure basic routes, such as homepage (`pages/index.js`) and a sample query page (`pages/query.js`). *(Project Goal, Key Workflows)*

3.  **API Integration Setup**: In the Next.js app, add an API service file (e.g., `/utils/api.js`) to handle REST calls to the backend endpoints provided by API Gateway. *(Key Workflows: Querying the LLM)*

4.  **Flutter Project Setup**: In a separate folder (e.g., `/mobile`), initialize a Flutter project for the mobile app:

`flutter create real_estate_mobile `*(Tech Stack: Flutter)*

1.  **Mobile UI Design**: Configure the Flutter project’s theme (in `lib/theme.dart`) using the same color palette and fonts as defined for the web app. *(UI/UX Design)*
2.  **API Integration in Flutter**: Create a Dart service class (e.g., `lib/services/api_service.dart`) that calls the same REST endpoints as the web app via API Gateway. *(Key Workflows: Querying the LLM)*
3.  **Validation**: Run the Next.js dev server (`npm run dev` in `my-next-app`) and launch the Flutter app in an emulator (`flutter run` in the `/mobile` directory) to verify that both UIs appear with the correct design and routing.

## Phase 3: Backend Development

*The backend will use GCP services including Cloud Functions, Cloud Run, and Supabase for data management.*

1.  **Prevalidation**: Ensure that no conflicting backend projects exist in the repository before initializing new services.

2.  **GCP Project Setup**: Log into GCP and select/create the appropriate project for this real estate knowledge base. *(Tech Stack: GCP Services)*

3.  **Cloud Functions for Querying LLM**: Create a Cloud Function repository (e.g., `/backend/cloud-functions/llm-query`) that exposes a RESTful API endpoint to receive queries from the frontends. *(Key Workflows: Querying the LLM)*

4.  **Vertex AI Integration**: Within the Cloud Function, implement the integration with Vertex AI LLM to process user queries and return responses. *(Tech Stack: Vertex AI)*

5.  **Document Processing Endpoint**: In another Cloud Function directory (e.g., `/backend/cloud-functions/doc-processing`), create an endpoint to handle file uploads and process documents using Document AI and Cloud Vision. *(Key Workflows: Document Processing)*

6.  **Supabase Data Management**: Define the PostgreSQL schema for Supabase with the following tables and relations:

    *   Property Listings
    *   Transaction Records
    *   Zoning Information
    *   Legal Documents
    *   Property Images
    *   Client/Contractor Information *(Data and Document Management)*

7.  **Migration Script**: Write a migration script (e.g., `/backend/migrations/create_tables.sql`) to create these tables in Supabase via the MCP server. *(Tech Stack: Supabase, Backend)*

8.  **Security Configuration**: Configure Supabase Row-Level Security (RLS) by adding security policies in the appropriate SQL file (e.g., `/backend/migrations/rls_policies.sql`). *(Security and Data Privacy)*

9.  **API Gateway Routing**: Configure an API Gateway in GCP that directs incoming REST API calls to the appropriate Cloud Functions endpoints. *(Backend & API: API Gateway)*

10. **Validation**: Use tools like Postman or curl to test the Cloud Functions endpoints (e.g., `curl -X POST <api-endpoint>/llm-query`) and confirm that they return the expected responses.

## Phase 4: Integration

1.  **Connect Frontend to Backend**: In both the Next.js and Flutter projects, integrate REST API calls to connect with the Cloud Functions endpoints via the API Gateway. *(Key Workflows: Querying the LLM)*
2.  **Chatbot Integration**: Configure Dialogflow CX to forward user queries to the Cloud Functions endpoints. Create a mapping in Dialogflow CX to ensure NLP inputs are routed correctly to Vertex AI LLM through the backend services. *(Chatbot Integration)*
3.  **Error Handling and Failover**: Implement robust error handling in both Cloud Functions and frontend API service layers to manage rate limit issues and server errors. *(Important Considerations)*
4.  **Validation**: Perform an end-to-end test where a sample query from the Next.js app is processed by the Cloud Function, and the result is displayed in the UI. Similarly, verify that Dialogflow CX correctly handles and responds to queries.

## Phase 5: Deployment

1.  **Cloud Functions Deployment**: Deploy the Cloud Functions (LLM query and document processing) to GCP Cloud Functions. Use deployment scripts and configuration files stored in `/backend/deploy/`.
2.  **Cloud Run Services**: If needed, deploy additional services (e.g., long-running processes) to Cloud Run. Ensure you specify auto-scaling parameters. *(Performance, Scalability, and Reliability)*
3.  **API Gateway Configuration**: Finalize the API Gateway setup to ensure all REST endpoints are publicly accessible (with proper security rules). *(Backend & API: API Gateway)*
4.  **Frontend Deployment (Next.js)**: Deploy the Next.js web app either on Vercel or using GCP hosting services. Ensure the deployment uses Next.js 14 as specified. *(Frontend: Next.js)*
5.  **Mobile App Deployment**: Prepare production builds for the Flutter mobile app and distribute them via appropriate channels (Google Play Store, Apple App Store). *(Frontend: Flutter)*
6.  **GCP Cloud Storage Setup**: Configure Cloud Storage buckets for storing documents and images. Define proper IAM policies and encryption (both in transit and at rest). *(Data Management: Cloud Storage)*
7.  **Validation**: Run end-to-end tests using tools such as Cypress (for web) and integration tests on mobile to ensure responses from the deployed endpoints are correct and latency is within acceptable limits.

## Additional Considerations

1.  **Monitoring and Logging**: Setup monitoring for Cloud Functions, Cloud Run, and API Gateway using Google Cloud’s operations suite. Ensure logs are collected and rate limit events are flagged. *(Performance, Scalability, and Reliability)*
2.  **Security Audits**: Schedule regular audits to review IAM roles, RLS policies in Supabase, and encryption settings across services. *(Security and Data Privacy)*
3.  **Documentation and Training**: Document all endpoints, integration flows, and configuration steps. Ensure team members are familiar with using Cursor IDE and GCP services. *(Project Goal, Data and Document Management)*

This completes the high-level step-by-step implementation plan for the project. Each step has been carefully aligned with the provided project requirements, tech stack, UI/UX design, and integration details.

// Use the environment variable defined in Vercel (or .env.local for development)
const API_GATEWAY_BASE_URL = process.env.NEXT_PUBLIC_API_GATEWAY_URL;

/**
 * Submits a query to the backend LLM via the API Gateway.
 */
export async function submitQuery(query: string): Promise<any> {
  if (!API_GATEWAY_BASE_URL) {
    throw new Error("API Gateway URL is not configured. Set NEXT_PUBLIC_API_GATEWAY_URL environment variable.");
  }

  // Construct the full endpoint URL
  // Our OpenAPI spec defines the path as /query
  const endpoint = `${API_GATEWAY_BASE_URL}/query`;

  console.log(`Submitting query to backend: ${query} at ${endpoint}`);

  try {
    const response = await fetch(endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ query }),
    });

    if (!response.ok) {
      // Attempt to read error details from the response body
      let errorBody = 'Unknown error';
      try {
        errorBody = await response.text();
      } catch (parseError) {
        // Ignore if the body cannot be parsed
      }
      console.error(`API request failed: ${response.status} ${response.statusText}`, errorBody);
      throw new Error(`API request failed with status ${response.status}: ${errorBody}`);
    }

    const data = await response.json();
    console.log("Received response from backend:", data);
    return data;

  } catch (error) {
    console.error("Error submitting query:", error);
    // Re-throw the error to be handled by the caller (e.g., UI)
    throw error;
  }
}

// TODO: Add functions for other API endpoints (e.g., document upload) 
-- Supabase Migration Script: Enable RLS and Add Basic Policies
-- Version: 1

-- IMPORTANT: Review and customize these policies based on your application's needs.
-- These are basic examples.

-- 1. Enable RLS for each table
ALTER TABLE property_listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE transaction_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE zoning_information ENABLE ROW LEVEL SECURITY;
ALTER TABLE legal_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE property_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE client_contractor_information ENABLE ROW LEVEL SECURITY;

-- 2. Define Policies (Examples)

-- Example: property_listings
-- Policy: Allow public read access for everyone.
CREATE POLICY "Allow public read access on property_listings" ON property_listings
    FOR SELECT
    USING (true);

-- Policy: Allow authenticated users to insert their own listings (adjust based on user roles/linking).
-- This assumes you have a way to link listings to users, e.g., a user_id column.
-- CREATE POLICY "Allow authenticated insert on property_listings" ON property_listings
--     FOR INSERT
--     WITH CHECK (auth.role() = 'authenticated'); -- Add user linking check, e.g., AND user_id = auth.uid()

-- Policy: Allow users to update/delete their own listings (requires user linking).
-- CREATE POLICY "Allow owner update on property_listings" ON property_listings
--     FOR UPDATE
--     USING (auth.uid() = user_id) -- Replace user_id with your actual linking column
--     WITH CHECK (auth.uid() = user_id);
-- CREATE POLICY "Allow owner delete on property_listings" ON property_listings
--     FOR DELETE
--     USING (auth.uid() = user_id); -- Replace user_id with your actual linking column

-- Example: legal_documents
-- Policy: Allow authenticated users to read all documents (adjust as needed for sensitivity).
CREATE POLICY "Allow authenticated read access on legal_documents" ON legal_documents
    FOR SELECT
    USING (auth.role() = 'authenticated');

-- Policy: Allow authenticated users to insert documents.
CREATE POLICY "Allow authenticated insert on legal_documents" ON legal_documents
    FOR INSERT
    WITH CHECK (auth.role() = 'authenticated');

-- Example: client_contractor_information
-- Policy: Disallow public read access (only authenticated users).
CREATE POLICY "Allow authenticated read access on client_contractor_info" ON client_contractor_information
    FOR SELECT
    USING (auth.role() = 'authenticated');

-- Policy: Allow authenticated users to insert contacts.
CREATE POLICY "Allow authenticated insert on client_contractor_info" ON client_contractor_information
    FOR INSERT
    WITH CHECK (auth.role() = 'authenticated');

-- Add similar policies for other tables (transaction_records, zoning_information, property_images)
-- considering who should be able to SELECT, INSERT, UPDATE, DELETE data.
-- Start with restrictive policies (e.g., only authenticated access) and open up as needed.

-- Default DENY: If no policy matches for a given operation, the action is denied.
-- Ensure you have policies covering all intended access patterns.

-- You might want separate policies for different roles (e.g., 'admin', 'agent', 'public').

PRINT 'RLS enabled and basic policies applied. REVIEW AND CUSTOMIZE!'; 
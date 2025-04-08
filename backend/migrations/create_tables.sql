-- Supabase Migration Script: Create Initial Tables
-- Version: 1

-- Enable UUID generation if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table: property_listings
CREATE TABLE IF NOT EXISTS property_listings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    address TEXT NOT NULL,
    city TEXT,
    state TEXT,
    zip_code VARCHAR(10),
    price NUMERIC(12, 2),
    bedrooms SMALLINT,
    bathrooms DECIMAL(3, 1),
    square_feet INTEGER,
    description TEXT,
    listing_url TEXT UNIQUE,
    status VARCHAR(50) DEFAULT 'active', -- e.g., active, pending, sold, inactive
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE property_listings IS 'Stores information about real estate property listings.';

-- Table: transaction_records
CREATE TABLE IF NOT EXISTS transaction_records (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID REFERENCES property_listings(id) ON DELETE SET NULL,
    sale_date DATE,
    sale_price NUMERIC(12, 2),
    buyer_name TEXT,
    seller_name TEXT,
    agent_name TEXT,
    transaction_type VARCHAR(50), -- e.g., sale, lease
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE transaction_records IS 'Records of property sales or lease transactions.';

-- Table: zoning_information
CREATE TABLE IF NOT EXISTS zoning_information (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID REFERENCES property_listings(id) ON DELETE CASCADE, -- Link to property if applicable
    parcel_number TEXT UNIQUE, -- Or link directly to property
    zone_code VARCHAR(50) NOT NULL,
    description TEXT,
    allowed_uses TEXT[],
    restrictions TEXT,
    source_document_url TEXT,
    checked_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE zoning_information IS 'Stores zoning codes and related details for properties or areas.';

-- Table: legal_documents
CREATE TABLE IF NOT EXISTS legal_documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID REFERENCES property_listings(id) ON DELETE SET NULL, -- Optional link to a specific property
    transaction_id UUID REFERENCES transaction_records(id) ON DELETE SET NULL, -- Optional link to a transaction
    document_type VARCHAR(100) NOT NULL, -- e.g., Deed, Title Report, Lease Agreement, HOA Rules
    document_title TEXT,
    storage_path TEXT NOT NULL UNIQUE, -- Path in Cloud Storage (e.g., gs://bucket/docs/doc_id.pdf)
    upload_date DATE DEFAULT CURRENT_DATE,
    extracted_text TEXT, -- Populated by Document AI/Vision function
    metadata JSONB, -- Store extracted entities or other metadata
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE legal_documents IS 'Metadata and storage links for legal documents related to properties or transactions.';

-- Table: property_images
CREATE TABLE IF NOT EXISTS property_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL REFERENCES property_listings(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL UNIQUE, -- Public URL or signed URL
    storage_path TEXT NOT NULL UNIQUE, -- Path in Cloud Storage (e.g., gs://bucket/images/img_id.jpg)
    description TEXT,
    tags TEXT[],
    is_primary BOOLEAN DEFAULT FALSE,
    upload_date DATE DEFAULT CURRENT_DATE,
    vision_data JSONB, -- Store data from Cloud Vision (labels, text)
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE property_images IS 'Stores images associated with properties, including storage paths and vision analysis data.';

-- Table: client_contractor_information
CREATE TABLE IF NOT EXISTS client_contractor_information (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., Client, Contractor, Agent, Inspector
    company_name TEXT,
    phone_number VARCHAR(20),
    email TEXT UNIQUE,
    address TEXT,
    specialty TEXT, -- For contractors/agents
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE client_contractor_information IS 'Stores contact and other information about clients, contractors, and other relevant parties.';

-- Add indexes for frequently queried columns
CREATE INDEX IF NOT EXISTS idx_property_listings_city_status ON property_listings(city, status);
CREATE INDEX IF NOT EXISTS idx_transaction_records_property_id ON transaction_records(property_id);
CREATE INDEX IF NOT EXISTS idx_zoning_information_property_id ON zoning_information(property_id);
CREATE INDEX IF NOT EXISTS idx_legal_documents_property_id ON legal_documents(property_id);
CREATE INDEX IF NOT EXISTS idx_legal_documents_transaction_id ON legal_documents(transaction_id);
CREATE INDEX IF NOT EXISTS idx_property_images_property_id ON property_images(property_id);
CREATE INDEX IF NOT EXISTS idx_client_contractor_information_type ON client_contractor_information(type);

-- Trigger function to update 'updated_at' columns
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply the trigger to tables with an updated_at column
CREATE TRIGGER update_property_listings_updated_at BEFORE UPDATE
ON property_listings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_transaction_records_updated_at BEFORE UPDATE
ON transaction_records FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_zoning_information_updated_at BEFORE UPDATE
ON zoning_information FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_legal_documents_updated_at BEFORE UPDATE
ON legal_documents FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_property_images_updated_at BEFORE UPDATE
ON property_images FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_client_contractor_information_updated_at BEFORE UPDATE
ON client_contractor_information FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

PRINT 'Initial tables created successfully.'; 
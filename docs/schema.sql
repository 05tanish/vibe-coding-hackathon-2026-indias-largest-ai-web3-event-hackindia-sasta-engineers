-- ============================================================================
-- PROJECT: Bravio - Database Schema Specification (PostgreSQL 15+)
-- DESCRIPTION: High-fidelity relational database layout representing the Startup Launch OS.
-- ============================================================================

-- Enable UUID extension for cryptographic keys
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Define Enums for status tracking
CREATE TYPE user_role_enum AS ENUM ('GUEST', 'FREE_USER', 'PREMIUM_USER', 'SYSTEM_ADMIN');
CREATE TYPE subscription_status_enum AS ENUM ('ACTIVE', 'PAST_DUE', 'CANCELED', 'UNPAID', 'TRIALING');
CREATE TYPE project_status_enum AS ENUM ('PENDING', 'GENERATING', 'COMPLETED', 'FAILED');
CREATE TYPE logo_format_enum AS ENUM ('SVG', 'PNG', 'JPG');
CREATE TYPE check_status_enum AS ENUM ('AVAILABLE', 'TAKEN', 'ERROR', 'UNKNOWN');
CREATE TYPE milestone_status_enum AS ENUM ('TODO', 'IN_PROGRESS', 'DONE');

-- ============================================================================
-- ENTITY RELATIONSHIP DIAGRAM (ERD)
-- ============================================================================
/*
```mermaid
erDiagram
    users ||--o| subscriptions : "has"
    users ||--o{ projects : "creates"
    users ||--o{ audit_logs : "triggers"
    projects ||--o{ startup_generations : "logs"
    projects ||--o| brand_assets : "owns"
    projects ||--o| logos : "features"
    projects ||--o| landing_pages : "publishes"
    projects ||--o| pricing_models : "structures"
    projects ||--o| marketing_assets : "utilizes"
    projects ||--o| pitch_decks : "presents"
    projects ||--o{ business_cards : "prints"
    projects ||--o{ mockups : "shows"
    projects ||--o{ domain_checks : "queries"
    projects ||--o{ social_checks : "scans"
    projects ||--o{ competitor_analysis : "tracks"
    projects ||--o{ roadmaps : "executes"

    users {
        uuid id PK
        varchar clerk_id UK
        varchar email UK
        varchar name
        user_role_enum role
        timestamp created_at
        timestamp updated_at
    }

    subscriptions {
        uuid id PK
        uuid user_id FK, UK
        varchar stripe_sub_id UK
        subscription_status_enum status
        timestamp period_start
        timestamp period_end
        timestamp created_at
        timestamp updated_at
    }

    projects {
        uuid id PK
        uuid user_id FK
        varchar name
        text original_prompt
        project_status_enum status
        timestamp created_at
        timestamp updated_at
    }
```
*/

-- ============================================================================
-- 1. USERS TABLE
-- ============================================================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    clerk_id VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    role user_role_enum NOT NULL DEFAULT 'FREE_USER',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_clerk_id ON users(clerk_id);
CREATE INDEX idx_users_email ON users(email);

-- ============================================================================
-- 2. SUBSCRIPTIONS TABLE
-- ============================================================================
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL UNIQUE,
    stripe_subscription_id VARCHAR(255) UNIQUE NOT NULL,
    stripe_customer_id VARCHAR(255) NOT NULL,
    status subscription_status_enum NOT NULL DEFAULT 'TRIALING',
    price_id VARCHAR(255) NOT NULL,
    period_start TIMESTAMP WITH TIME ZONE NOT NULL,
    period_end TIMESTAMP WITH TIME ZONE NOT NULL,
    cancel_at_period_end BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_subscriptions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_subscriptions_stripe_sub ON subscriptions(stripe_subscription_id);

-- ============================================================================
-- 3. PROJECTS TABLE
-- ============================================================================
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    original_prompt TEXT NOT NULL,
    status project_status_enum NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_projects_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_projects_user ON projects(user_id);
CREATE INDEX idx_projects_status ON projects(status);

-- ============================================================================
-- 4. STARTUP_GENERATIONS TABLE (Execution Logging)
-- ============================================================================
CREATE TABLE startup_generations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    progress_percentage INT NOT NULL DEFAULT 0 CHECK (progress_percentage BETWEEN 0 AND 100),
    current_step VARCHAR(100),
    error_message TEXT,
    completed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_generations_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_generations_project ON startup_generations(project_id);

-- ============================================================================
-- 5. BRAND_ASSETS TABLE
-- ============================================================================
CREATE TABLE brand_assets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL UNIQUE,
    tagline_suggestions JSONB NOT NULL, -- Array of taglines
    primary_color VARCHAR(10) NOT NULL, -- HEX
    secondary_color VARCHAR(10) NOT NULL, -- HEX
    accent_color VARCHAR(10) NOT NULL, -- HEX
    background_color VARCHAR(10) NOT NULL, -- HEX
    heading_font VARCHAR(100) NOT NULL,
    body_font VARCHAR(100) NOT NULL,
    brand_voice_guide TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_brand_assets_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

-- ============================================================================
-- 6. LOGOS TABLE
-- ============================================================================
CREATE TABLE logos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL UNIQUE,
    dalle_prompt TEXT NOT NULL,
    s3_image_url VARCHAR(2048) NOT NULL,
    logo_format logo_format_enum NOT NULL DEFAULT 'PNG',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_logos_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

-- ============================================================================
-- 7. LANDING_PAGES TABLE
-- ============================================================================
CREATE TABLE landing_pages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL UNIQUE,
    seo_title VARCHAR(255) NOT NULL,
    seo_description TEXT NOT NULL,
    hero_title VARCHAR(255) NOT NULL,
    hero_subtitle TEXT NOT NULL,
    cta_text VARCHAR(100) NOT NULL,
    features_json JSONB NOT NULL, -- Array of {icon, title, desc}
    faq_json JSONB NOT NULL, -- Array of {q, a}
    social_proof_json JSONB, -- Testimonial structures
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_landing_pages_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

-- ============================================================================
-- 8. PRICING_MODELS TABLE
-- ============================================================================
CREATE TABLE pricing_models (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    tier_name VARCHAR(100) NOT NULL, -- 'Free', 'Growth', 'Enterprise'
    price_amount NUMERIC(10, 2) NOT NULL,
    billing_period VARCHAR(50) NOT NULL DEFAULT 'monthly', -- 'monthly' or 'annual'
    features_included JSONB NOT NULL, -- Array of feature text strings
    is_recommended BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pricing_models_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_pricing_project ON pricing_models(project_id);

-- ============================================================================
-- 9. MARKETING_ASSETS TABLE
-- ============================================================================
CREATE TABLE marketing_assets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    channel VARCHAR(100) NOT NULL, -- 'Google', 'Facebook', 'LinkedIn', 'Twitter'
    headline VARCHAR(255) NOT NULL,
    body_content TEXT NOT NULL,
    call_to_action VARCHAR(100) NOT NULL,
    target_keywords JSONB, -- Array of search words
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_marketing_assets_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_marketing_project ON marketing_assets(project_id);

-- ============================================================================
-- 10. PITCH_DECKS TABLE
-- ============================================================================
CREATE TABLE pitch_decks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL UNIQUE,
    slides_json JSONB NOT NULL, -- Array of {slide_number, title, content_bullets}
    s3_pdf_url VARCHAR(2048),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pitch_decks_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

-- ============================================================================
-- 11. BUSINESS_CARDS TABLE
-- ============================================================================
CREATE TABLE business_cards (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    cardholder_name VARCHAR(255) NOT NULL,
    cardholder_title VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(50),
    website_url VARCHAR(2048),
    layout_style VARCHAR(100) DEFAULT 'minimalist',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_business_cards_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_business_cards_project ON business_cards(project_id);

-- ============================================================================
-- 12. MOCKUPS TABLE
-- ============================================================================
CREATE TABLE mockups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    device_type VARCHAR(50) NOT NULL, -- 'mobile', 'desktop', 'tablet'
    description_prompt TEXT NOT NULL,
    s3_mockup_url VARCHAR(2048) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_mockups_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_mockups_project ON mockups(project_id);

-- ============================================================================
-- 13. DOMAIN_CHECKS TABLE
-- ============================================================================
CREATE TABLE domain_checks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    domain_name VARCHAR(255) NOT NULL,
    tld VARCHAR(20) NOT NULL,
    status check_status_enum NOT NULL DEFAULT 'UNKNOWN',
    whois_raw TEXT,
    checked_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_domain_checks_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_domain_checks_project ON domain_checks(project_id);

-- ============================================================================
-- 14. SOCIAL_CHECKS TABLE
-- ============================================================================
CREATE TABLE social_checks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    platform VARCHAR(100) NOT NULL, -- 'Twitter', 'Instagram', 'LinkedIn', 'GitHub'
    username VARCHAR(100) NOT NULL,
    status check_status_enum NOT NULL DEFAULT 'UNKNOWN',
    checked_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_social_checks_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_social_checks_project ON social_checks(project_id);

-- ============================================================================
-- 15. COMPETITOR_ANALYSIS TABLE
-- ============================================================================
CREATE TABLE competitor_analysis (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    competitor_name VARCHAR(255) NOT NULL,
    strengths TEXT NOT NULL,
    weaknesses TEXT NOT NULL,
    estimated_market_share VARCHAR(100),
    website_url VARCHAR(2048),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_competitors_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_competitors_project ON competitor_analysis(project_id);

-- ============================================================================
-- 16. ROADMAPS TABLE
-- ============================================================================
CREATE TABLE roadmaps (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL,
    milestone_title VARCHAR(255) NOT NULL,
    milestone_description TEXT,
    timeframe VARCHAR(100) NOT NULL, -- 'Week 1-2', 'Month 1', 'Month 3', 'Month 6'
    status milestone_status_enum NOT NULL DEFAULT 'TODO',
    priority_level INT DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_roadmaps_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE INDEX idx_roadmaps_project ON roadmaps(project_id);

-- ============================================================================
-- 17. AUDIT_LOGS TABLE
-- ============================================================================
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID,
    action_type VARCHAR(100) NOT NULL, -- 'PROJECT_DELETED', 'USER_SIGNUP', 'BILLING_SUCCESS'
    ip_address VARCHAR(45) NOT NULL,
    user_agent VARCHAR(512),
    payload JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_audit_logs_user ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_action ON audit_logs(action_type);

-- ============================================================================
-- AUTOMATED TRIGGER FOR TIMESTAMPS
-- ============================================================================
-- Generic update trigger function
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for standard tables with updated_at column
CREATE TRIGGER update_users_modtime BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_subscriptions_modtime BEFORE UPDATE ON subscriptions FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_projects_modtime BEFORE UPDATE ON projects FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_generations_modtime BEFORE UPDATE ON startup_generations FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_brand_assets_modtime BEFORE UPDATE ON brand_assets FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_logos_modtime BEFORE UPDATE ON logos FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_landing_pages_modtime BEFORE UPDATE ON landing_pages FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_pricing_models_modtime BEFORE UPDATE ON pricing_models FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_marketing_assets_modtime BEFORE UPDATE ON marketing_assets FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_pitch_decks_modtime BEFORE UPDATE ON pitch_decks FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_business_cards_modtime BEFORE UPDATE ON business_cards FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_mockups_modtime BEFORE UPDATE ON mockups FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_competitor_analysis_modtime BEFORE UPDATE ON competitor_analysis FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
CREATE TRIGGER update_roadmaps_modtime BEFORE UPDATE ON roadmaps FOR EACH ROW EXECUTE PROCEDURE update_modified_column();

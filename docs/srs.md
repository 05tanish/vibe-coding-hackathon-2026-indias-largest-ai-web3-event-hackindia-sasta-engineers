# Software Requirements Specification (SRS)
## Bravio: Turn your business idea into a startup in 60 seconds

---

## 1. Executive Summary
Bravio is an enterprise-grade, AI-powered Startup Launch Operating System designed to democratize entrepreneurship. By leveraging advanced Large Language Models (LLMs), web-search scrapers, vector embeddings, and graphic generation models, Bravio allows aspiring founders, serial entrepreneurs, and product managers to convert a single, high-level business idea into a fully-realized startup package in under 60 seconds.

Bravio acts as a co-founder in a box. It eliminates the traditional weeks of manual planning, branding, market research, and copywriting by generating a comprehensive operational blueprint. This includes naming suggestions, logo concepts, landing page copy, color palettes, pitch decks, business cards, roadmaps, pricing strategies, market analysis, and a live interactive startup dashboard.

---

## 2. Problem Statement
Starting a new business is characterized by high friction, fragmentation, and prohibitive upfront costs:
1. **Friction & Analysis Paralysis**: Aspiring founders struggle with the initial setup phase—formulating value propositions, creating business model canvases, and defining target demographics.
2. **High Financial Barriers**: Hiring copywriters, brand designers, marketing strategists, and financial analysts to draft initial collateral costs thousands of dollars before a single customer is acquired.
3. **Tool Fragmentation**: Founders must navigate dozens of disparate tools for domain availability, trademark searching, social media checks, logo design, copy generation, and task management.
4. **Time to Market**: The manual synthesis of roadmaps, investor decks, and ad copy takes weeks, delaying the validation of business viability in a rapidly changing market.

Bravio solves this fragmentation by consolidating the entire ideation-to-launch workflow into a single, unified, AI-driven operating system.

---

## 3. Goals
- **Minimize Time-to-Validation**: Generate all critical startup launching assets from a single prompt in under 60 seconds.
- **Provide High-Fidelity Outputs**: Generate production-ready brand assets, structural pricing models, detailed roadmaps, and copy that does not look "templated" or generic.
- **Consolidate Workflows**: Integrate domain, trademark, and social media availability checks directly into the startup generation process.
- **Drive High Engagement**: Offer an interactive dashboard where founders can customize, manage, export, and evolve their generated startup assets.
- **Enable Seamless Scalability**: Design a highly-available, queue-backed, event-driven architecture capable of handling thousands of concurrent generations without service degradation.

---

## 4. Scope
### In-Scope Features
1. **Unified AI Startup Engine**: Orchestration layer that splits a single idea prompt into parallel pipelines (branding, marketing, financial, operational, and design assets).
2. **Interactive Startup Dashboard**: A single portal containing all generated startup assets organized by department (Brand, Marketing, Product, Operations, Investor Relations).
3. **Real-time Availability Checks**: Automated scraping/checking of domain registers, major social media platforms (X, Instagram, LinkedIn, GitHub), and US Trademark database links.
4. **Export Utilities**: Export pitch decks to PDF/Markdown, roadmaps to CSV/JSON, brand assets to PDF guidelines, and landing page copy to HTML/React components.
5. **Subscription & Token Billing**: Paid subscription tiers and generation credits managed via Stripe.
6. **Collaboration Portal**: Shareable links for projects, allowing co-founders or investors to view the startup dashboard in read-only format.

### Out-of-Scope (Future Phases)
1. **Automated Legal Entity Formation**: Direct API integration with services like Stripe Atlas or Clerky for automatic LLC/C-Corp registration.
2. **Custom Domain Hosting**: Hosting the generated landing page directly on a custom domain with SSL (managed within Bravio).
3. **AI Video Ad Generator**: Creating animated or voice-over video ads for the generated startup.
4. **Direct Bank Account Opening**: Integration with Mercury or Brex for instant banking application.

---

## 5. Functional Requirements

### 5.1 Registration and Authentication
- **FR-1.1**: The system MUST support user registration and login using Clerk authentication.
- **FR-1.2**: Users MUST be able to authenticate using email/password, magic links, or OAuth (Google, GitHub).
- **FR-1.3**: The system MUST implement role-based access control (RBAC) supporting Guest, Free, Premium, and Admin roles.
- **FR-1.4**: Session tokens MUST be secured using HTTP-only cookies or secure Bearer tokens in headers.

### 5.2 Project Management
- **FR-2.1**: Authenticated users MUST be able to create, read, update, and delete (CRUD) multiple startup projects.
- **FR-2.2**: Each project MUST capture the user's initial prompt, target industry, target audience, and geographic focus.
- **FR-2.3**: Projects MUST serve as the container for all generated resources (branding, logos, pitch decks, etc.).

### 5.3 AI Generation Pipeline
The system MUST support the generation of 20 core assets grouped into 5 distinct modules:

#### Module A: Brand Identity & Naming
- **FR-3.1 (Name Suggestion)**: Generate 10 contextual, creative startup names with semantic explanations.
- **FR-3.2 (Brand Palette & Fonts)**: Generate a comprehensive color palette (Primary, Secondary, Accent, Background) in HEX format with specific Google Font pairing recommendations.
- **FR-3.3 (Logo Concepts)**: Generate 3 detailed text-to-image prompts for logo generation, and automatically execute one via DALL-E 3/Midjourney APIs to produce a high-fidelity brand logo.
- **FR-3.4 (Taglines & Brand Guidelines)**: Generate 5 distinct taglines (minimal, corporate, funny, bold) and a 1-page brand voice guide.

#### Module B: Market & Digital Presence Checks
- **FR-3.5 (Domain Availability)**: Query Whois/Domain APIs in real-time to check availability for generated names on `.com`, `.co`, `.io`, and `.ai` extensions.
- **FR-3.6 (Social Media Availability)**: Scan username availability on X/Twitter, Instagram, LinkedIn, and GitHub.
- **FR-3.7 (Trademark Search Links)**: Generate deep-links to the USPTO trademark search portal pre-populated with the generated brand names.
- **FR-3.8 (Competitor Analysis)**: Generate a list of 3 direct and 3 indirect competitors using Tavily search integration, complete with their perceived strengths and weaknesses.

#### Module C: Marketing & Digital Presence
- **FR-3.9 (Landing Page Copy)**: Generate structured, SEO-optimized copy for a landing page, including Hero section, Value Proposition, Feature Grid, Social Proof, and FAQ.
- **FR-3.10 (Ad Copies)**: Generate targeted copy for Google Ads, Facebook/Instagram Ads, and LinkedIn Ads.
- **FR-3.11 (Social Media Content)**: Create a 7-day launch social media content calendar (including post text and hashtag recommendations).
- **FR-3.12 (Business Card Design)**: Generate structural layouts and copy for professional business cards in physical standard print dimensions.

#### Module D: Strategy & Operations
- **FR-3.13 (Pricing Strategy)**: Generate 3 tier-based pricing models (Free/Starter, Growth, Enterprise) tailored to the business type, including key features per tier.
- **FR-3.14 (Business Model Canvas)**: Generate a complete 9-box Business Model Canvas (Key Partners, Key Activities, Value Propositions, Customer Relationships, Customer Segments, Key Resources, Channels, Cost Structure, Revenue Streams).
- **FR-3.15 (Startup Roadmap)**: Generate a structured, milestone-driven execution plan broken down into Week 1-2, Month 1, Month 3, and Month 6.

#### Module E: Investor & Design Assets
- **FR-3.16 (Investor Pitch Deck)**: Generate slide-by-slide structured content for a 10-slide standard pitch deck (Problem, Solution, Market Size, Product, Business Model, Go-To-Market, Team, Financials, Competition, The Ask).
- **FR-3.17 (Mockup Concepts)**: Generate high-fidelity prompt descriptions for generating UI mockups of the startup's product, alongside physical product mockups where applicable.
- **FR-3.18 (Startup Dashboard UI)**: Render an interactive client-side dashboard where users can interactively edit, modify, and check off items from their roadmap or update generated assets.

---

## 6. Non-Functional Requirements

### 6.1 Performance and Latency
- **NFR-1.1**: The application landing page and public dashboard pages MUST load within 1.5 seconds (LCP < 2.5s) on standard 3G connections.
- **NFR-1.2**: AI orchestrator pipeline operations (requiring multiple API calls) MUST be executed asynchronously using a message queue (BullMQ/Redis). The client MUST receive updates in real-time via Server-Sent Events (SSE) or WebSockets.
- **NFR-1.3**: Database queries MUST utilize indexes efficiently, resolving all standard SELECT queries within 100ms.

### 6.2 Reliability and Availability
- **NFR-2.1**: The system MUST target 99.9% uptime (excluding planned maintenance).
- **NFR-2.2**: The backend services MUST deploy behind an Application Load Balancer with auto-scaling to prevent single-point-of-failure (SPOF) outages.
- **NFR-2.3**: Database backups MUST occur automatically on a daily basis with a Retain Policy of 30 days, stored in an isolated S3 bucket.

### 6.3 Security and Compliance
- **NFR-3.1**: All communications in transit MUST be encrypted via HTTPS using TLS 1.3.
- **NFR-3.2**: Sensitive information at rest (e.g., API keys, database fields) MUST be encrypted using AES-256-GCM.
- **NFR-3.3**: The system MUST achieve GDPR compliance by providing users with options to export their personal data and delete their account ("Right to be Forgotten").
- **NFR-3.4**: Rate limiting MUST be applied to all public APIs: maximum 60 requests per minute per IP for standard endpoints, and 5 requests per minute per IP for authentication/generation routes.

### 6.4 Scalability
- **NFR-4.1**: Backend microservices/APIs MUST be stateless, allowing horizontal autoscaling based on CPU and Memory usage.
- **NFR-4.2**: The Redis queue instance MUST handle up to 10,000 active execution payloads concurrently.
- **NFR-4.3**: Database scale-out MUST be supported through PostgreSQL read-replicas for intensive dashboard data queries.

---

## 7. User Roles
1. **Guest**: Non-registered visitors. Can view the landing page, read the pricing model, and preview standard public dashboard templates.
2. **Free Tier User**: Registered user. Can create 1 active project and generate a subset of core startup assets (Naming, 3 taglines, pricing tier mockups, basic roadmaps). No visual logo generation or deep-link trademark integrations.
3. **Premium Tier User**: Paid subscriber. Unlimited active projects, access to full 20-asset generations, visual logo output via DALL-E 3, PDF exports, and real-time social/domain checks.
4. **System Administrator**: Can manage users, adjust AI prompt templates, view analytics, inspect audit logs, and override billing tiers.

---

## 8. User Stories
1. **US-1 (Ideation)**: As an aspiring founder, I want to type a brief, unstructured business idea into a text area so that I can quickly explore its potential name, market viability, and branding direction without manual analysis.
2. **US-2 (Interactive Dashboard)**: As a registered user, I want a single, cohesive dashboard where I can access my generated startup assets in clean, designated cards so that I do not have to copy and paste text into separate documents.
3. **US-3 (Brand Guidelines)**: As a user, I want to generate a coordinated color palette and font pairing that matches the vibe of my business idea so that I can hand them off directly to a web designer.
4. **US-4 (Real-time Domain Checking)**: As a founder, I want to see if the generated startup name suggestions have available `.com` or `.ai` domains in real-time so that I can register them immediately before someone else does.
5. **US-5 (Social Handles Scanning)**: As a creator, I want to verify if the social handles on Twitter, LinkedIn, and Instagram are available for my chosen startup name so that I can maintain consistent branding across the web.
6. **US-6 (Pitch Deck Exporting)**: As an entrepreneur preparing to meet angel investors, I want to export my generated 10-slide pitch deck content into a professionally styled PDF so that I can send it out as an attachment.
7. **US-7 (Interactive Roadmap)**: As a solo founder, I want to interact with my generated startup roadmap (marking milestones as checked/completed) so that I can use it as a real-time progress tracker.
8. **US-8 (Logo Customization)**: As a Premium user, I want the system to generate a visual logo concept using an AI image generator based on my chosen name and palette so that I have a solid visual brand asset on day one.

---

## 9. Acceptance Criteria

### AC-1: Startup Generation Lifecycle
- **Scenario**: A premium user submits a startup idea.
- **Given**: The user is authenticated and has active premium credits.
- **When**: The user enters "An automated newsletter curation tool for marketers" and clicks "Launch".
- **Then**: The system must spin up an asynchronous execution worker, update the frontend in real-time via Server-Sent Events, and complete all 20 generation nodes in under 60 seconds.
- **And**: The project must successfully save to the PostgreSQL database with correct relations to the user.

### AC-2: Real-time Domain and Social Validation
- **Scenario**: Fetching availability for suggested brand names.
- **Given**: A list of 5 brand name suggestions has been generated by the LLM.
- **When**: The dashboard loads the brand assets panel.
- **Then**: The system must invoke the background check services concurrently to verify `.com` availability and social handle presence, returning HTTP 200 with structured JSON statuses for each within 3 seconds.

### AC-3: Safe Export of Pitch Deck
- **Scenario**: Exporting generated Pitch Deck content.
- **Given**: The pitch deck section contains valid AI-generated content.
- **When**: The user clicks the "Export as PDF" button.
- **Then**: The backend must compile the slide markdown/JSON data into a styled PDF document using a server-side layout engine and trigger a download of the PDF in the client's browser.

---

## 10. Database Design (Overview)
- Database Engine: **PostgreSQL (v15+)**
- ORM Layer: **Prisma**
- Schema highlights:
  - Strongly typed relational schemas for projects, assets, and audit logs.
  - Foreign key constraints with cascading deletes for project-linked assets.
  - Database-level indexes on primary keys, email addresses, and foreign keys (`user_id`, `project_id`).
  - Strict compliance with normal forms (up to 3NF) for transactional stability.
  *(Detailed Database DDL and Entity Relationship Diagram are documented in docs/schema.sql)*

---

## 11. Security Requirements
1. **JWT Verification & Session Management**: Handled securely at the gateway using Clerk middleware. Tokens are short-lived, and rotation is forced.
2. **CORS Configuration**: Restrict API calls to specific, whitelisted client origins (e.g., dashboard, landing page domains). Reject any requests missing valid origin verification headers.
3. **Data Sanitization**: Protect against Injection attacks. All database queries must run through Prisma parameterization. All user input rendered on the frontend must be sanitized to prevent Cross-Site Scripting (XSS).
4. **Audit Logging**: Write structural logs to `audit_logs` tracking sensitive system mutations (e.g., deletion of projects, change of subscription levels, API token generation).

---

## 12. Scalability Requirements
1. **Stateless APIs**: API and generation servers do not save state locally. Local caching uses Redis, and persistent state uses PostgreSQL. This allows dynamic autoscaling of servers.
2. **Redis Message Brokering**: Decouple the user request from execution. The client request pushes a job to Redis (BullMQ). Workers pick up the job and execute the intensive LLM chains.
3. **LLM Throttle Management**: Implement smart retry logic with exponential backoff on OpenAI/DALL-E calls to handle rate limit (TPM/RPM) errors gracefully.

---

## 13. API Requirements
1. **RESTful Architecture**: Follow standard HTTP methods (`GET`, `POST`, `PATCH`, `DELETE`) with semantically correct status codes (`200 OK`, `201 Created`, `400 Bad Request`, `401 Unauthorized`, `403 Forbidden`, `422 Unprocessable Entity`, `500 Server Error`).
2. **OpenAPI Specification**: The system's complete API interface must be described using an OpenAPI 3.0 specification (`swagger.yaml`).
3. **Input Validation**: All requests MUST be validated at the route boundary using NestJS validation pipes (`class-validator` / `zod`).

---

## 14. DevOps Requirements
1. **Containerization**: Define strict `Dockerfile` profiles for the NestJS backend, Next.js frontend, and the execution workers.
2. **Continuous Integration (CI)**: GitHub Actions pipelines executing automated formatting checks, linting, and Prisma unit test suites on every pull request.
3. **Continuous Deployment (CD)**: Automatically build and push Docker containers to AWS ECR, and execute a rolling update to ECS/Fargate clusters upon merging into the `main` branch.

---

## 15. Deployment Architecture
- **DNS & CDN**: AWS Route53 + Amazon CloudFront (providing caching, edge TLS termination, and DDoS protection).
- **Frontend Hosting**: Vercel (recommended for Next.js) or AWS ECS behind Application Load Balancer (ALB).
- **Backend Orchestrator**: NestJS backend container running in AWS ECS (Fargate).
- **Database**: Amazon RDS PostgreSQL with automatic multi-AZ failover and standard automated backups.
- **Cache & Queue**: Amazon ElastiCache (Redis) cluster.
- **File Storage**: Amazon S3 buckets for storing logos, generated PDF pitch decks, and mockups.

```
       [Route 53] / [CloudFront CDN]
              |
      +-------+-------+
      |               |
[Next.js Client] [ALB Gateway]
                      |
              [NestJS API App]
                      |
         +------------+------------+
         |            |            |
     [RDS PG]  [ElastiCache]    [S3 Bucket]
                  (Redis)
```

---

## 16. Future Enhancements
1. **Automated LLC Registration**: Integrating Stripe Atlas to allow users to register an actual US Delaware LLC directly from their Bravio dashboard.
2. **Custom Domain Generator**: Offer one-click deployments of the generated landing page onto a custom domain registered inside Bravio.
3. **Cold Email Automator**: Connect to email APIs (e.g., Resend, SendGrid) to auto-generate cold outreach campaigns for their target customer demographics.
4. **Co-founder Matching**: A internal network directory matching users whose roadmaps and startup profiles show complementary needs (e.g., technical founder looking for sales founder).

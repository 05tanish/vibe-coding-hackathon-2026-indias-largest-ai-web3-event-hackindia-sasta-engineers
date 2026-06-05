# Cursor AI Coding Tasks Directory
## Bravio: Turn your business idea into a startup in 60 seconds

This document catalogs exactly **100 granular implementation tasks** to guide Cursor AI or developers step-by-step through building Bravio. The tasks are grouped logically by architectural modules.

---

## Module 1: Monorepo Scaffolding & Dev Environment (Tasks 1-10)

### Task 1: Initialize Root package.json & Turborepo Settings
- **Description**: Configure the base monorepo structure, defining workspaces for applications (`apps/*`) and library packages (`packages/*`), alongside turbo execution caching parameters.
- **Files Affected**:
  - `package.json` [NEW]
  - `turbo.json` [NEW]
- **Dependencies**: None.
- **Acceptance Criteria**: Running `npm install` successfully links directories; `npx turbo run build` correctly identifies execution pipeline blocks.

### Task 2: Setup Shared TypeScript Configurations
- **Description**: Create base, node-optimized, and next-optimized tsconfig presets in a shared package workspace to align compiler environments.
- **Files Affected**:
  - `packages/typescript-config/package.json` [NEW]
  - `packages/typescript-config/base.json` [NEW]
  - `packages/typescript-config/nextjs.json` [NEW]
  - `packages/typescript-config/nodejs.json` [NEW]
- **Dependencies**: Task 1.
- **Acceptance Criteria**: Other workspace apps can import configurations using `"extends": "@bravio/typescript-config/nodejs.json"`.

### Task 3: Establish Central ESLint Shared Configuration Rules
- **Description**: Setup standard code quality checks and import organization rules.
- **Files Affected**:
  - `packages/eslint-config/package.json` [NEW]
  - `packages/eslint-config/index.js` [NEW]
- **Dependencies**: Task 2.
- **Acceptance Criteria**: Linter executes on both next.js and nest.js apps without conflicts.

### Task 4: Scaffold API Application (NestJS Setup)
- **Description**: Initialize the core NestJS backend structure within the monorepo apps folder.
- **Files Affected**:
  - `apps/api/package.json` [NEW]
  - `apps/api/tsconfig.json` [NEW]
  - `apps/api/src/main.ts` [NEW]
- **Dependencies**: Task 2.
- **Acceptance Criteria**: Backend compiles and starts successfully, returning default HTTP status responses.

### Task 5: Scaffold Client Application (Next.js App Router Setup)
- **Description**: Setup Next.js boilerplate utilizing React 18, TypeScript, and Tailwind configurations.
- **Files Affected**:
  - `apps/web/package.json` [NEW]
  - `apps/web/src/app/page.tsx` [NEW]
- **Dependencies**: Task 2.
- **Acceptance Criteria**: Next.js client renders dummy landing page successfully on local port 3000.

### Task 6: Add Tailwind and Design Token Configuration
- **Description**: Create unified theme variables, colors (HEX mappings), font pairings (Outfit, Inter), and rounded corner limits.
- **Files Affected**:
  - `apps/web/tailwind.config.js` [NEW]
  - `apps/web/src/styles/globals.css` [NEW]
- **Dependencies**: Task 5.
- **Acceptance Criteria**: Tailwind CSS outputs successfully build and styles compile.

### Task 7: Setup Shadcn UI Component Core Scaffolding
- **Description**: Run setup command to link Radix primitives with local components folder.
- **Files Affected**:
  - `apps/web/components.json` [NEW]
  - `apps/web/src/lib/utils.ts` [NEW]
- **Dependencies**: Task 6.
- **Acceptance Criteria**: Custom `cn()` utility class exists and resolves conditional styling seamlessly.

### Task 8: Import Shadcn Primitives - Button & Input Components
- **Description**: Write basic styled inputs and interactive buttons into the client UI structure.
- **Files Affected**:
  - `apps/web/src/components/ui/button.tsx` [NEW]
  - `apps/web/src/components/ui/input.tsx` [NEW]
- **Dependencies**: Task 7.
- **Acceptance Criteria**: Components load on client views and follow standard tailwind class customization.

### Task 9: Import Shadcn Primitives - Card & Dialog Components
- **Description**: Establish layout borders and overlay dialogs for popup modules.
- **Files Affected**:
  - `apps/web/src/components/ui/card.tsx` [NEW]
  - `apps/web/src/components/ui/dialog.tsx` [NEW]
- **Dependencies**: Task 7.
- **Acceptance Criteria**: Layout elements mount and accessibility rules are fully preserved.

### Task 10: Import Shadcn Primitives - Skeleton & Loader Components
- **Description**: Supply interactive placeholder UI frames for active rendering pipelines.
- **Files Affected**:
  - `apps/web/src/components/ui/skeleton.tsx` [NEW]
- **Dependencies**: Task 7.
- **Acceptance Criteria**: Elements animate correctly when mock flags state changes.

---

## Module 2: Clerk Authentication & Authorization (Tasks 11-20)

### Task 11: Configure Clerk Provider on Frontend Layout
- **Description**: Integrate the Clerk wrapping block at the base level of the Next.js client.
- **Files Affected**:
  - `apps/web/src/app/providers.tsx` [NEW]
  - `apps/web/src/app/layout.tsx` [MODIFY]
- **Dependencies**: Task 5.
- **Acceptance Criteria**: Page compilation succeeds; browser reads public publishable key without runtime errors.

### Task 12: Build Client Sign-In Page Route
- **Description**: Setup dedicated Clerk sign-in elements supporting oauth and passwords.
- **Files Affected**:
  - `apps/web/src/app/(auth)/sign-in/[[...sign-in]]/page.tsx` [NEW]
- **Dependencies**: Task 11.
- **Acceptance Criteria**: Accessing `/sign-in` renders styled Clerk login form.

### Task 13: Build Client Sign-Up Page Route
- **Description**: Setup customized onboarding credentials forms.
- **Files Affected**:
  - `apps/web/src/app/(auth)/sign-up/[[...sign-up]]/page.tsx` [NEW]
- **Dependencies**: Task 11.
- **Acceptance Criteria**: Routing to `/sign-up` shows onboarding forms.

### Task 14: Protect Frontend Routes via Next.js Middleware
- **Description**: Write intercept filter requiring credentials for dashboard routes.
- **Files Affected**:
  - `apps/web/src/middleware.ts` [NEW]
- **Dependencies**: Task 11.
- **Acceptance Criteria**: Unauthenticated requests to `/dashboard` redirect to login immediately.

### Task 15: Install Clerk Node SDK in NestJS API App
- **Description**: Embed JWT parsing capabilities within NestJS environment.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Server starts and can verify keys.

### Task 16: Implement Backend Auth Guard Middleware
- **Description**: Parse headers and extract active user profiles inside HTTP execution threads.
- **Files Affected**:
  - `apps/api/src/common/guards/auth.guard.ts` [NEW]
- **Dependencies**: Task 15.
- **Acceptance Criteria**: Requests lacking valid Bearer auth tokens fail with HTTP 401.

### Task 17: Build Custom User Session Decorator
- **Description**: Formulate short handle tags for controller methods to inject active user attributes.
- **Files Affected**:
  - `apps/api/src/common/decorators/user.decorator.ts` [NEW]
- **Dependencies**: Task 16.
- **Acceptance Criteria**: Controller can extract `userId` payload via custom tags.

### Task 18: Build Backend Mock User Sync Hook
- **Description**: Configure test endpoints to test user creation profiles.
- **Files Affected**:
  - `apps/api/src/modules/auth/auth.module.ts` [NEW]
  - `apps/api/src/modules/auth/auth.controller.ts` [NEW]
- **Dependencies**: Task 16.
- **Acceptance Criteria**: Executing validation commands returns valid testing payloads.

### Task 19: Design Custom Dashboard Header Components
- **Description**: Render clean headers displaying user status and logout action controls.
- **Files Affected**:
  - `apps/web/src/components/shared/header.tsx` [NEW]
- **Dependencies**: Task 8.
- **Acceptance Criteria**: Rendered header accurately displays avatar images and handles session exit triggers.

### Task 20: Write Global Error Handling Interceptors in API App
- **Description**: Build unified error responses for authentication edge cases.
- **Files Affected**:
  - `apps/api/src/common/filters/http-exception.filter.ts` [NEW]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: System exceptions format cleanly into structured client JSON.

---

## Module 3: Database & Prisma Layer (Tasks 21-30)

### Task 21: Setup packages/database Scaffolding
- **Description**: Configure separate workspace module managing Prisma schemas.
- **Files Affected**:
  - `packages/database/package.json` [NEW]
  - `packages/database/src/index.ts` [NEW]
- **Dependencies**: Task 1.
- **Acceptance Criteria**: Running build inside database package generates active compiler outputs.

### Task 22: Define Prisma Schema - Core Users & Projects Models
- **Description**: Draft database layouts for primary entities and status structures.
- **Files Affected**:
  - `packages/database/prisma/schema.prisma` [NEW]
- **Dependencies**: Task 21.
- **Acceptance Criteria**: Models reflect standard user profiles and active project flags.

### Task 23: Define Prisma Schema - Brand & Logo Models
- **Description**: Write schema structures storing design palettes and media asset records.
- **Files Affected**:
  - `packages/database/prisma/schema.prisma` [MODIFY]
- **Dependencies**: Task 22.
- **Acceptance Criteria**: Models support multi-line text descriptions and valid relational keys.

### Task 24: Define Prisma Schema - Marketing, Pricing & Competitors Models
- **Description**: Define database models for landing copy JSON, price models, and competitor entities.
- **Files Affected**:
  - `packages/database/prisma/schema.prisma` [MODIFY]
- **Dependencies**: Task 23.
- **Acceptance Criteria**: Models compile successfully with JSON schema compatibility.

### Task 25: Define Prisma Schema - Roadmap, Business Cards & Audit Logs Models
- **Description**: Define structures tracking milestones, printable assets, and operational logs.
- **Files Affected**:
  - `packages/database/prisma/schema.prisma` [MODIFY]
- **Dependencies**: Task 24.
- **Acceptance Criteria**: Prisma models compile cleanly without syntax anomalies.

### Task 26: Execute Initial Prisma Migration Against PostgreSQL
- **Description**: Run migration routines to set up Postgres table shapes.
- **Files Affected**:
  - `packages/database/prisma/migrations/` [NEW]
- **Dependencies**: Task 25.
- **Acceptance Criteria**: Local Postgres DB shows all 17 tables matching specifications.

### Task 27: Build Dynamic Prisma Seeder Script
- **Description**: Compose data creation scripts to populate test accounts.
- **Files Affected**:
  - `packages/database/prisma/seed.ts` [NEW]
- **Dependencies**: Task 26.
- **Acceptance Criteria**: Running `npx prisma db seed` seeds database tables without errors.

### Task 28: Write Instantiated Database Client Wrapper
- **Description**: Setup central execution hooks resolving multi-service connections.
- **Files Affected**:
  - `packages/database/src/index.ts` [MODIFY]
- **Dependencies**: Task 26.
- **Acceptance Criteria**: Reusable database clients export correctly.

### Task 29: Connect API App with database package
- **Description**: Inject database connection hooks inside NestJS backend workspace.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
  - `apps/api/src/app.module.ts` [MODIFY]
- **Dependencies**: Task 28.
- **Acceptance Criteria**: API server starts and successfully connects to database.

### Task 30: Implement Automatic UpdatedAt PostgreSQL Triggers
- **Description**: Set up database triggers to manage updated_at timestamps.
- **Files Affected**:
  - `packages/database/prisma/migrations/` [MODIFY]
- **Dependencies**: Task 26.
- **Acceptance Criteria**: Modifying records updates database timestamps automatically.

---

## Module 4: BullMQ Queue & Worker Infrastructure (Tasks 31-40)

### Task 31: Add NestJS BullMQ Packages
- **Description**: Add queue integration scripts to runtime scopes.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Dependencies resolve and install without conflicts.

### Task 32: Create API Queue Module Container
- **Description**: Wire Redis server profiles into application scopes.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.module.ts` [NEW]
  - `apps/api/src/modules/queue/queue.service.ts` [NEW]
- **Dependencies**: Task 31.
- **Acceptance Criteria**: Controller imports queue modules cleanly.

### Task 33: Write Queue Job Producer Logic
- **Description**: Compose job dispatch methods routing requests to active Redis queue lists.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.service.ts` [MODIFY]
- **Dependencies**: Task 32.
- **Acceptance Criteria**: System can enqueue structured JSON parameters to Redis lists.

### Task 34: Setup Isolated Background Worker Process
- **Description**: Scaffold separate NestJS runner dedicated to pulling queue items.
- **Files Affected**:
  - `apps/api/src/worker.ts` [NEW]
- **Dependencies**: Task 32.
- **Acceptance Criteria**: Running `npm run start:worker` boots background processors.

### Task 35: Write Queue Consumer Processor Boilerplate
- **Description**: Set up central callback handlers to parse pending queue tasks.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [NEW]
- **Dependencies**: Task 34.
- **Acceptance Criteria**: Workers capture emitted messages and print trace statements.

### Task 36: Configure BullMQ Exponential Backoff Settings
- **Description**: Configure queue settings to handle temporary third-party failures gracefully.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.service.ts` [MODIFY]
- **Dependencies**: Task 33.
- **Acceptance Criteria**: Failed tasks automatically retry with exponential time spacing.

### Task 37: Setup BullMQ Sandbox Unit Tests
- **Description**: Compose simple pipeline tests verifying active queue dispatching.
- **Files Affected**:
  - `apps/api/test/queue.spec.ts` [NEW]
- **Dependencies**: Task 35.
- **Acceptance Criteria**: Test suite executes without errors.

### Task 38: Implement Worker Processing Logging Instrumentation
- **Description**: Insert comprehensive trace points detailing runtime states.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Task 35.
- **Acceptance Criteria**: Active output tracks task execution progress.

### Task 39: Implement Server-Sent Events (SSE) Progress Module
- **Description**: Set up realtime endpoints to stream background generation progress.
- **Files Affected**:
  - `apps/api/src/modules/generator/generator.controller.ts` [NEW]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Client browser can open SSE streams.

### Task 40: Build SSE Progress Dispatch Broker
- **Description**: Push messages over active HTTP streams when jobs report updates.
- **Files Affected**:
  - `apps/api/src/modules/generator/generator.service.ts` [NEW]
- **Dependencies**: Task 39.
- **Acceptance Criteria**: Browser reads real-time updates as workers proceed.

---

## Module 5: Projects API Operations (Tasks 41-50)

### Task 41: Create Projects NestJS Module Scaffolding
- **Description**: Standardize initial file layouts managing core user folders.
- **Files Affected**:
  - `apps/api/src/modules/projects/projects.module.ts` [NEW]
  - `apps/api/src/modules/projects/projects.controller.ts` [NEW]
  - `apps/api/src/modules/projects/projects.service.ts` [NEW]
- **Dependencies**: Task 29.
- **Acceptance Criteria**: Service hooks map smoothly to routing tables.

### Task 42: Implement POST /api/projects Route Handler
- **Description**: Validate requests and save new empty projects into Postgres.
- **Files Affected**:
  - `apps/api/src/modules/projects/projects.controller.ts` [MODIFY]
  - `apps/api/src/modules/projects/projects.service.ts` [MODIFY]
- **Dependencies**: Task 41.
- **Acceptance Criteria**: Endpoint creates database records, returning custom IDs with status `PENDING`.

### Task 43: Create DTO Validations for Project Creation
- **Description**: Verify request body structures using standard decorators.
- **Files Affected**:
  - `apps/api/src/modules/projects/dto/create-project.dto.ts` [NEW]
- **Dependencies**: Task 42.
- **Acceptance Criteria**: Submitting short prompts or empty parameters throws HTTP 400 validation exceptions.

### Task 44: Implement GET /api/projects Route Handler
- **Description**: Return list of active projects belonging to authenticated profiles.
- **Files Affected**:
  - `apps/api/src/modules/projects/projects.controller.ts` [MODIFY]
  - `apps/api/src/modules/projects/projects.service.ts` [MODIFY]
- **Dependencies**: Task 41.
- **Acceptance Criteria**: Endpoint retrieves exact records matching specific ownership IDs.

### Task 45: Implement GET /api/projects/:id (Hydrated Project Details)
- **Description**: Retrieve a project and all its child tables in a single hydrated query.
- **Files Affected**:
  - `apps/api/src/modules/projects/projects.controller.ts` [MODIFY]
  - `apps/api/src/modules/projects/projects.service.ts` [MODIFY]
- **Dependencies**: Task 41.
- **Acceptance Criteria**: Successfully returns a project's related child records.

### Task 46: Implement DELETE /api/projects/:id Route Handler
- **Description**: Perform cascading deletion of a project and its associated records.
- **Files Affected**:
  - `apps/api/src/modules/projects/projects.controller.ts` [MODIFY]
  - `apps/api/src/modules/projects/projects.service.ts` [MODIFY]
- **Dependencies**: Task 45.
- **Acceptance Criteria**: Deletion cleans up Postgres completely, throwing HTTP 404 on subsequent queries.

### Task 47: Implement Project Owner Validation Logic
- **Description**: Write custom intercept checks ensuring users can only manage their own projects.
- **Files Affected**:
  - `apps/api/src/modules/projects/projects.service.ts` [MODIFY]
- **Dependencies**: Task 45.
- **Acceptance Criteria**: Authenticated users attempting to access another user's project ID receive HTTP 404.

### Task 48: Scaffold Projects UI Pages in Next.js Client
- **Description**: Build frontend page layouts listing current user projects.
- **Files Affected**:
  - `apps/web/src/app/dashboard/page.tsx` [NEW]
- **Dependencies**: Task 8.
- **Acceptance Criteria**: Dashboard route displays styled tables of user projects.

### Task 49: Write Client Side API Fetch Hooks
- **Description**: Construct query modules requesting remote datasets with Clerk token headers.
- **Files Affected**:
  - `apps/web/src/lib/api-client.ts` [MODIFY]
- **Dependencies**: Task 11.
- **Acceptance Criteria**: Client successfully fetches database queries from api backend.

### Task 50: Add Project Creation Form Dialog Panel
- **Description**: Render clean input areas enabling prompt submission.
- **Files Affected**:
  - `apps/web/src/components/dashboard/create-project-dialog.tsx` [NEW]
- **Dependencies**: Task 9.
- **Acceptance Criteria**: Form displays properly and initiates project creation.

---

## Module 6: AI Orchestrator Main Engine (Tasks 51-60)

### Task 51: Configure OpenAI SDK on Backend App
- **Description**: Integrate OpenAI package and coordinate credentials files.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
  - `apps/api/src/modules/generator/generator.module.ts` [MODIFY]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Orchestrator correctly loads API tokens.

### Task 52: Define Structured JSON Output Schemas for Naming Engine
- **Description**: Map target model definitions to restrict GPT outputs.
- **Files Affected**:
  - `apps/api/src/modules/generator/schemas/naming.schema.ts` [NEW]
- **Dependencies**: Task 51.
- **Acceptance Criteria**: Validation rules strictly verify input parameters.

### Task 53: Write Core Naming & Branding LLM Node
- **Description**: Build prompt routines generating brand names, color palettes, and fonts.
- **Files Affected**:
  - `apps/api/src/modules/generator/services/brand-node.service.ts` [NEW]
- **Dependencies**: Task 52.
- **Acceptance Criteria**: Node runs and generates valid JSON payloads matching naming schemas.

### Task 54: Write Core Strategy & Operations LLM Node
- **Description**: Compose prompts generating roadmaps, business canvases, and pricing structures.
- **Files Affected**:
  - `apps/api/src/modules/generator/services/strategy-node.service.ts` [NEW]
- **Dependencies**: Task 51.
- **Acceptance Criteria**: System yields clean pricing tables and structured milestone timelines.

### Task 55: Write Digital Copywriting LLM Node
- **Description**: Generate targeted ad copies and landing page structures.
- **Files Affected**:
  - `apps/api/src/modules/generator/services/copy-node.service.ts` [NEW]
- **Dependencies**: Task 51.
- **Acceptance Criteria**: Output yields descriptive value statements and landing copy.

### Task 56: Write DALL-E 3 Logo Concept Builder
- **Description**: Translate generated startup themes into optimized image-generation prompts.
- **Files Affected**:
  - `apps/api/src/modules/generator/services/logo-node.service.ts` [NEW]
- **Dependencies**: Task 51.
- **Acceptance Criteria**: Concept prompts capture key brand elements and visual tone guidelines.

### Task 57: Coordinate Sequential Execution DAG Pipeline
- **Description**: Group execution routines to run nodes in correct dependency order.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Tasks 53, 54, 55.
- **Acceptance Criteria**: Worker runs pipeline stages sequentially, successfully passing parameters between nodes.

### Task 58: Write DB Persist Pipeline Handler
- **Description**: Map generated JSON segments into corresponding database tables.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Task 29.
- **Acceptance Criteria**: Generated assets save cleanly inside database records.

### Task 59: Implement AWS S3 SDK for File Storage
- **Description**: Install and configure the AWS S3 SDK on the backend.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
  - `apps/api/src/modules/generator/services/s3.service.ts` [NEW]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Local scripts successfully upload mock files to S3 buckets.

### Task 60: Connect Logo Renderer Worker Node
- **Description**: Run image generation pipelines and upload logo PNG files directly to AWS S3.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Tasks 56, 59.
- **Acceptance Criteria**: Logos render, upload to S3, and save to database records.

---

## Module 7: Domain, Social & Competitor Services (Tasks 61-70)

### Task 61: Integrate Tavily SDK inside API App
- **Description**: Add Tavily search client to NestJS backend modules.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
  - `apps/api/src/modules/generator/services/tavily.service.ts` [NEW]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Search queries yield optimized, clean contextual market summaries.

### Task 62: Write Competitor Analysis Generation Service
- **Description**: Retrieve competitor profiles using Tavily and summarize strengths and weaknesses.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Task 61.
- **Acceptance Criteria**: Competitor records populate database tables correctly.

### Task 63: Install WHOIS and Network Lookup Packages
- **Description**: Integrate domain check packages to query registration records.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Local tools resolve network validation queries.

### Task 64: Build Real-time Domain Checker Service
- **Description**: Query Whois records concurrently to check domain availability.
- **Files Affected**:
  - `apps/api/src/modules/generator/services/domain-checker.service.ts` [NEW]
- **Dependencies**: Task 63.
- **Acceptance Criteria**: Queries return accurate `AVAILABLE` or `TAKEN` statuses.

### Task 65: Connect Domain Validation inside Main Worker Pipeline
- **Description**: Check availability of generated names on `.com` and `.ai` extensions.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Task 64.
- **Acceptance Criteria**: Domain check results save to database tables.

### Task 66: Build Real-time Social Handles Scraper Service
- **Description**: Query Twitter/GitHub profile routes to check username availability.
- **Files Affected**:
  - `apps/api/src/modules/generator/services/social-checker.service.ts` [NEW]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Social handle checks return accurate status responses.

### Task 67: Connect Social Checks inside Worker Pipeline
- **Description**: Scan handles for generated startup names during generation.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Task 66.
- **Acceptance Criteria**: Scan results persist to project records.

### Task 68: Build USPTO Trademark Link Builder
- **Description**: Generate pre-populated USPTO search portal deep-links for generated names.
- **Files Affected**:
  - `apps/api/src/modules/generator/services/trademark.service.ts` [NEW]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Generates valid trademark search URLs dynamically.

### Task 69: Write Integrated Testing for External Network Services
- **Description**: Compose tests verifying domain, trademark, and social checkers.
- **Files Affected**:
  - `apps/api/test/external-checks.spec.ts` [NEW]
- **Dependencies**: Tasks 64, 66.
- **Acceptance Criteria**: Test scripts run and resolve successfully.

### Task 70: Implement Competitor & Digital Presence UI Cards
- **Description**: Render domain, social, and competitor cards in the frontend dashboard.
- **Files Affected**:
  - `apps/web/src/components/dashboard/presence-panel.tsx` [NEW]
- **Dependencies**: Task 9.
- **Acceptance Criteria**: Dashboard UI displays structured competitor analyses and handle statuses.

---

## Module 8: PDF Compiling & Asset Exporters (Tasks 71-80)

### Task 71: Install Puppeteer on Backend Application
- **Description**: Add Puppeteer library to run headless browser instances.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Dependencies install and compile without errors.

### Task 72: Build Slide PDF HTML Template
- **Description**: Standardize base HTML structures to represent styled presentation slides.
- **Files Affected**:
  - `apps/api/src/modules/exports/templates/pitch-deck.template.html` [NEW]
- **Dependencies**: Task 71.
- **Acceptance Criteria**: Renders clean presentation layouts locally.

### Task 73: Write Puppeteer Pitch Deck Compiler Service
- **Description**: Generate pitch deck PDF files by printing slide HTML to PDF.
- **Files Affected**:
  - `apps/api/src/modules/exports/services/pdf-compiler.service.ts` [NEW]
- **Dependencies**: Task 72.
- **Acceptance Criteria**: Successfully outputs styled PDF files to temp folder.

### Task 74: Connect PDF Exporter with AWS S3
- **Description**: Upload compiled PDF files directly to S3 and save URL keys.
- **Files Affected**:
  - `apps/api/src/modules/exports/services/pdf-compiler.service.ts` [MODIFY]
- **Dependencies**: Task 59.
- **Acceptance Criteria**: Exporter uploads PDFs and returns clean CloudFront links.

### Task 75: Write Pitch Deck PDF Generation Worker Hook
- **Description**: Auto-generate pitch deck PDFs as final step of startup generation.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Task 73.
- **Acceptance Criteria**: Final project record contains a valid `s3PdfUrl`.

### Task 76: Build GET /api/projects/:id/export/pitch-deck Route
- **Description**: Expose endpoint returning direct pitch deck download links.
- **Files Affected**:
  - `apps/api/src/modules/projects/projects.controller.ts` [MODIFY]
- **Dependencies**: Task 75.
- **Acceptance Criteria**: Requesting URL yields HTTP 200 with the active PDF URL key.

### Task 77: Design printable Business Cards PDF Layout Template
- **Description**: Compose HTML templates mapping physical business card print dimensions.
- **Files Affected**:
  - `apps/api/src/modules/exports/templates/business-card.template.html` [NEW]
- **Dependencies**: Task 71.
- **Acceptance Criteria**: HTML matches exact physical print dimensions.

### Task 78: Build Business Cards Exporter Hook
- **Description**: Generate printable business cards via headless browser.
- **Files Affected**:
  - `apps/api/src/modules/exports/services/card-compiler.service.ts` [NEW]
- **Dependencies**: Task 77.
- **Acceptance Criteria**: System generates printable business card PDFs.

### Task 79: Build Client Export Pitch Deck Action Button
- **Description**: Create interactive buttons to trigger pitch deck PDF downloads.
- **Files Affected**:
  - `apps/web/src/components/dashboard/pitch-deck-panel.tsx` [NEW]
- **Dependencies**: Task 8.
- **Acceptance Criteria**: Clicking buttons fetches and initiates PDF file downloads.

### Task 80: Integrate PDF Generation Progress Events inside SSE
- **Description**: Broadcast real-time events over SSE during PDF compiling.
- **Files Affected**:
  - `apps/api/src/modules/queue/queue.processor.ts` [MODIFY]
- **Dependencies**: Task 39.
- **Acceptance Criteria**: Frontend updates state when PDF compiling finishes.

---

## Module 9: Premium Front-end Design & Panels (Tasks 81-90)

### Task 81: Setup Next.js Project Detail View Router
- **Description**: Establish dynamic routes representing individual project portals.
- **Files Affected**:
  - `apps/web/src/app/dashboard/[projectId]/page.tsx` [NEW]
- **Dependencies**: Task 5.
- **Acceptance Criteria**: Direct requests parse the dynamic ID correctly.

### Task 82: Implement Unified Glassmorphism Theme Layout
- **Description**: Formulate premium glassmorphism styles in custom styling definitions.
- **Files Affected**:
  - `apps/web/src/app/dashboard/[projectId]/layout.tsx` [NEW]
- **Dependencies**: Task 6.
- **Acceptance Criteria**: Dashboard background shows sleek translucent cards and smooth gradient outlines.

### Task 83: Build Realtime Loading Progress Pipeline Overlay
- **Description**: Show beautiful interactive loaders during generation.
- **Files Affected**:
  - `apps/web/src/components/dashboard/pipeline-progress.tsx` [NEW]
- **Dependencies**: Task 39.
- **Acceptance Criteria**: Loader tracks SSE progress and displays status checks in real-time.

### Task 84: Build Brand Assets Sidebar Dashboard Panel
- **Description**: Render branding panel showing colors, typography, voice guide, and logos.
- **Files Affected**:
  - `apps/web/src/components/dashboard/brand-panel.tsx` [NEW]
- **Dependencies**: Task 82.
- **Acceptance Criteria**: Clicking colors copies hex codes, and brand typography pairing renders beautifully.

### Task 85: Build Marketing & Copy Dashboard Panel
- **Description**: Render marketing panel displaying landing page copy and social ads.
- **Files Affected**:
  - `apps/web/src/components/dashboard/marketing-panel.tsx` [NEW]
- **Dependencies**: Task 82.
- **Acceptance Criteria**: Tab components toggle smoothly between social posts, ad copies, and landing page previews.

### Task 86: Build Strategy & Pricing Dashboard Panel
- **Description**: Render strategy panel showing pricing tiers and Business Model Canvas.
- **Files Affected**:
  - `apps/web/src/components/dashboard/strategy-panel.tsx` [NEW]
- **Dependencies**: Task 82.
- **Acceptance Criteria**: Displays complete 9-box canvas layout and responsive pricing tables.

### Task 87: Build Milestone Roadmap Dashboard Panel
- **Description**: Render interactive roadmap timeline view.
- **Files Affected**:
  - `apps/web/src/components/dashboard/roadmap-panel.tsx` [NEW]
- **Dependencies**: Task 82.
- **Acceptance Criteria**: Roadmap displays milestones in a chronological vertical timeline.

### Task 88: Build Interactive Roadmap State Sync Hook
- **Description**: Update milestone status in DB when user toggles checkbox in the UI.
- **Files Affected**:
  - `apps/web/src/components/dashboard/roadmap-panel.tsx` [MODIFY]
- **Dependencies**: Task 87.
- **Acceptance Criteria**: Toggling milestones updates progress states in PostgreSQL.

### Task 89: Build Global Toast Notification System
- **Description**: Integrate popups notifying users of success and error events.
- **Files Affected**:
  - `apps/web/src/components/ui/toaster.tsx` [NEW]
  - `apps/web/src/app/layout.tsx` [MODIFY]
- **Dependencies**: Task 8.
- **Acceptance Criteria**: Triggering alerts displays animated toast alerts on screens.

### Task 90: Implement Pitch Deck Slides Carousel
- **Description**: Build interactive visual slides viewer component.
- **Files Affected**:
  - `apps/web/src/components/dashboard/deck-carousel.tsx` [NEW]
- **Dependencies**: Task 82.
- **Acceptance Criteria**: Renders dynamic, responsive slide viewer in dashboard view.

---

## Module 10: Stripe Webhooks, Limits & Deployment (Tasks 91-100)

### Task 91: Install Stripe Backend Library
- **Description**: Embed Stripe package inside NestJS modules.
- **Files Affected**:
  - `apps/api/package.json` [MODIFY]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: API application starts successfully.

### Task 92: Build POST /api/billing/webhook Endpoint Handler
- **Description**: Parse Stripe webhook events and sync subscription updates to database.
- **Files Affected**:
  - `apps/api/src/modules/billing/billing.controller.ts` [NEW]
  - `apps/api/src/modules/billing/billing.service.ts` [NEW]
- **Dependencies**: Task 91.
- **Acceptance Criteria**: Endpoint parses raw signatures and updates database subscription flags.

### Task 93: Write Billing Subscription Enforcement Interceptors
- **Description**: Block pipeline execution if users lack active premium credits.
- **Files Affected**:
  - `apps/api/src/common/guards/billing.guard.ts` [NEW]
- **Dependencies**: Task 92.
- **Acceptance Criteria**: Unpaid accounts attempting to initiate generations receive HTTP 402.

### Task 94: Create Clerk Custom Metadata Sync Hook
- **Description**: Push billing tier changes to Clerk to cache roles at edge gates.
- **Files Affected**:
  - `apps/api/src/modules/billing/billing.service.ts` [MODIFY]
- **Dependencies**: Task 92.
- **Acceptance Criteria**: Stripe updates reflect immediately in Clerk user metadata.

### Task 95: Build Next.js Premium Upgrade Portal Redirect
- **Description**: Add upgrade buttons redirection to Stripe checkout.
- **Files Affected**:
  - `apps/web/src/components/shared/upgrade-button.tsx` [NEW]
- **Dependencies**: Task 8.
- **Acceptance Criteria**: Clicking button opens Stripe Checkout portal session.

### Task 96: Build Multi-Stage Dockerfile for NestJS API
- **Description**: Compose production Docker configurations for API.
- **Files Affected**:
  - `apps/api/Dockerfile.api` [NEW]
- **Dependencies**: Task 4.
- **Acceptance Criteria**: Docker build resolves, creating a lightweight container.

### Task 97: Build Multi-Stage Dockerfile for Workers
- **Description**: Compose production Docker configurations for background workers.
- **Files Affected**:
  - `apps/api/Dockerfile.worker` [NEW]
- **Dependencies**: Task 34.
- **Acceptance Criteria**: Docker build succeeds, preparing worker container.

### Task 98: Define GitHub Actions CI lint & test pipelines
- **Description**: Compose testing pipelines to run on pull requests.
- **Files Affected**:
  - `.github/workflows/test.yml` [NEW]
- **Dependencies**: Task 1.
- **Acceptance Criteria**: Merging branches executes automated tests.

### Task 99: Define AWS ECS CD Deployment Pipeline
- **Description**: Add CD pipeline to build and deploy containers to AWS ECS.
- **Files Affected**:
  - `.github/workflows/deploy.yml` [NEW]
- **Dependencies**: Tasks 96, 97.
- **Acceptance Criteria**: Master merges auto-deploy updated containers to Fargate tasks.

### Task 100: Execute Final Monorepo Local Build Validation
- **Description**: Run full monorepo build command to verify stability.
- **Files Affected**:
  - `package.json` [MODIFY]
- **Dependencies**: All Tasks 1-99.
- **Acceptance Criteria**: Monorepo compiles cleanly, preparing optimized production artifacts.

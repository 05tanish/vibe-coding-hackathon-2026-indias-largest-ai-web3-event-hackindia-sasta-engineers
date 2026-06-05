# REST API Specification
## Bravio: Turn your business idea into a startup in 60 seconds

---

## 1. Authentication & Global Headers
All private endpoints require Bearer Token authorization from the Clerk authentication service.

```
Authorization: Bearer <clerk_session_jwt>
Content-Type: application/json
Accept: application/json
```

### Response Status Codes
- **`200 OK`**: Request successfully completed.
- **`201 Created`**: Resource successfully created.
- **`202 Accepted`**: Background generation job successfully enqueued.
- **`400 Bad Request`**: Validation failed (schema violation).
- **`401 Unauthorized`**: JWT expired, invalid, or missing.
- **`402 Payment Required`**: Active subscription tier limit exceeded or payment past due.
- **`404 Not Found`**: Resource does not exist or user lacks permission to access it.
- **`429 Too Many Requests`**: IP or User rate limits exceeded.
- **`500 Internal Server Error`**: Unexpected error on the backend server.

---

## 2. Projects Endpoints

### 2.1 List All Projects
Retrieve all startup projects owned by the authenticated user.

- **Endpoint**: `GET /api/projects`
- **Authentication**: Required (JWT Session)
- **Response**: `200 OK`
```json
[
  {
    "id": "e43b1740-4228-4444-8d99-d45009d73d2a",
    "name": "Bravio",
    "originalPrompt": "Turn your business idea into a startup in 60 seconds.",
    "status": "COMPLETED",
    "createdAt": "2026-05-24T13:40:00.000Z",
    "updatedAt": "2026-05-24T13:41:00.000Z"
  }
]
```

### 2.2 Create New Project Container
Initialize a brand new startup project container. This assigns a default placeholder name before running the generator.

- **Endpoint**: `POST /api/projects`
- **Authentication**: Required (JWT Session)
- **Request Body Validation**:
  - `originalPrompt` (String, min: 10 chars, max: 2000 chars, Required)
- **Request Body**:
```json
{
  "originalPrompt": "I want to build an AI fitness coach for busy professionals."
}
```
- **Response**: `201 Created`
```json
{
  "id": "d74b971a-6e3e-436b-a25e-e47012bc552f",
  "name": "Draft Project - 13:40",
  "originalPrompt": "I want to build an AI fitness coach for busy professionals.",
  "status": "PENDING",
  "userId": "usr_9d8s7g6h5j4k3l2",
  "createdAt": "2026-05-24T13:40:12.000Z",
  "updatedAt": "2026-05-24T13:40:12.000Z"
}
```

### 2.3 Get Hydrated Project Details
Fetches the fully hydrated startup bundle including branding, logos, competitor lists, pricing tiers, ad copies, roadmaps, and marketing templates.

- **Endpoint**: `GET /api/projects/:id`
- **Authentication**: Required (JWT Session)
- **Response**: `200 OK`
```json
{
  "id": "d74b971a-6e3e-436b-a25e-e47012bc552f",
  "name": "FitPulse AI",
  "originalPrompt": "I want to build an AI fitness coach for busy professionals.",
  "status": "COMPLETED",
  "createdAt": "2026-05-24T13:40:12.000Z",
  "brandAssets": {
    "taglineSuggestions": [
      "AI Workout plans that adapt to your calendar",
      "Executive fitness in 15 minutes a day"
    ],
    "primaryColor": "#1A365D",
    "secondaryColor": "#4A5568",
    "accentColor": "#ED8936",
    "backgroundColor": "#F7FAFC",
    "headingFont": "Outfit",
    "bodyFont": "Inter",
    "brandVoiceGuide": "Empowering, premium, scientific yet simple."
  },
  "logo": {
    "dallePrompt": "Minimalist digital app logo representing pulse wave combined with a dumbbell, high tech style, primary color blue and orange",
    "s3ImageUrl": "https://cdn.bravio.ai/logos/pulse_dumbbell_logo.png",
    "logoFormat": "PNG"
  },
  "landingPage": {
    "seoTitle": "FitPulse AI - Personal Coaching Built for Your Calendar",
    "seoDescription": "Get custom workouts driven by smart AI, adapting daily to your meetings and travel. Maximize health, minimize time.",
    "heroTitle": "Premium AI Coaching for Dynamic Professionals",
    "heroSubtitle": "Skip the gym planning. FitPulse AI builds optimized micro-workouts based on your active calendar.",
    "ctaText": "Start Free 14-Day Trial",
    "featuresJson": [
      {
        "icon": "Calendar",
        "title": "Calendar Sync Integration",
        "desc": "Automatically scans your Google/Outlook calendar to schedule short workouts."
      }
    ],
    "faqJson": [
      {
        "q": "How long are the workouts?",
        "a": "Usually range between 10 to 25 minutes tailored to your dynamic schedule."
      }
    ]
  },
  "pricingModels": [
    {
      "tierName": "Starter",
      "priceAmount": 19.00,
      "billingPeriod": "monthly",
      "featuresIncluded": ["Calendar sync", "10 customized sessions", "Text chat support"],
      "isRecommended": false
    },
    {
      "tierName": "Pro Executive",
      "priceAmount": 49.00,
      "billingPeriod": "monthly",
      "featuresIncluded": ["Unlimited dynamic sessions", "Weekly video review", "Wearable API sync"],
      "isRecommended": true
    }
  ],
  "competitors": [
    {
      "competitorName": "Freeletics AI",
      "strengths": "Large workout library, gamified progression system.",
      "weaknesses": "No direct Google calendar synchronization or meeting awareness."
    }
  ],
  "roadmap": [
    {
      "id": "2d8f9e6d-2c3b-419b-a010-bbccdd112233",
      "milestoneTitle": "Secure Domain and Brand Handles",
      "milestoneDescription": "Register fitpulse.ai and set up active accounts on Twitter/LinkedIn.",
      "timeframe": "Week 1-2",
      "status": "TODO",
      "priorityLevel": 1
    }
  ]
}
```

### 2.4 Delete Project Container
Performs a cascading deletion of the project and all child tables.

- **Endpoint**: `DELETE /api/projects/:id`
- **Authentication**: Required (JWT Session)
- **Response**: `200 OK`
```json
{
  "success": true,
  "message": "Project d74b971a-6e3e-436b-a25e-e47012bc552f and all associated assets successfully deleted."
}
```

---

## 3. Asynchronous AI Orchestration Endpoints

### 3.1 Trigger Startup Generation (Main Pipeline)
Initiates the asynchronous multi-node startup generation DAG task. Enqueues a task in Redis BullMQ.

- **Endpoint**: `POST /api/generate/startup`
- **Authentication**: Required (JWT Session)
- **Request Body Validation**:
  - `projectId` (UUID string, Required)
- **Request Body**:
```json
{
  "projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f"
}
```
- **Response**: `202 Accepted`
```json
{
  "jobId": "job_98s7dfg987sdf87sd",
  "projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f",
  "status": "GENERATING",
  "statusUrl": "/api/projects/d74b971a-6e3e-436b-a25e-e47012bc552f/generation-status"
}
```

### 3.2 Stream Startup Generation Progress (SSE)
Establishes a Server-Sent Events (SSE) channel to track step-by-step progress updates.

- **Endpoint**: `GET /api/projects/:id/generation-status`
- **Headers**:
  - `Connection: keep-alive`
  - `Content-Type: text/event-stream`
  - `Cache-Control: no-cache`
- **Auth**: Required (Token passed via URL query parameter `?token=<jwt_token>`)
- **Event Outputs Streamed**:
```
event: progress
data: {"percentage": 10, "step": "GENERATE_NAMES", "message": "Synthesizing brand naming suggestions..."}

event: progress
data: {"percentage": 30, "step": "CHECK_DIGITAL_HANDLES", "message": "Checking domain availability and social handles..."}

event: progress
data: {"percentage": 60, "step": "GENERATE_STRATEGY", "message": "Structuring pricing configurations and milestone roadmaps..."}

event: progress
data: {"percentage": 90, "step": "EXECUTE_LOGOS", "message": "Rendering primary brand logo concept via image engine..."}

event: completed
data: {"projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f", "message": "Startup OS successfully built."}
```

---

## 4. Specific Asset Custom Regeneration Endpoints
Used on the interactive dashboard to selectively refresh individual assets.

### 4.1 Custom Logo Regeneration
Submit custom styling requirements to override the previous image.

- **Endpoint**: `POST /api/generate/logo`
- **Authentication**: Required (JWT Session)
- **Request Body Validation**:
  - `projectId` (UUID string, Required)
  - `styleOverride` (String, max: 255 chars, Optional)
- **Request Body**:
```json
{
  "projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f",
  "styleOverride": "Vibrant Neon synthwave style, dark backdrop"
}
```
- **Response**: `200 OK`
```json
{
  "logoId": "3cc76f8e-d1a2-44be-99dd-887766554433",
  "s3ImageUrl": "https://cdn.bravio.ai/logos/fitpulse_synthwave.png"
}
```

### 4.2 Custom Landing Page Regeneration
Reprovisions the copywriting text blocks.

- **Endpoint**: `POST /api/generate/landing-page`
- **Authentication**: Required (JWT Session)
- **Request Body Validation**:
  - `projectId` (UUID string, Required)
  - `toneOfVoice` (String, Optional) - e.g. "Humorous", "Aggressive", "Luxury"
- **Request Body**:
```json
{
  "projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f",
  "toneOfVoice": "Aggressive motivational"
}
```
- **Response**: `200 OK` (Returns updated landing page schema)

### 4.3 Custom Pricing Regeneration
Re-aligns the model with custom parameters.

- **Endpoint**: `POST /api/generate/pricing`
- **Request**:
```json
{
  "projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f",
  "monetizationModel": "Subscription with usage credits"
}
```
- **Response**: `200 OK`

### 4.4 Custom Marketing & Social Ads Regeneration
Regenerate marketing text templates.

- **Endpoint**: `POST /api/generate/marketing`
- **Request**:
```json
{
  "projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f"
}
```
- **Response**: `200 OK`

### 4.5 Custom Pitch Deck Generation
Recompile investor slides.

- **Endpoint**: `POST /api/generate/pitch-deck`
- **Request**:
```json
{
  "projectId": "d74b971a-6e3e-436b-a25e-e47012bc552f",
  "slideTheme": "Modern Corporate Minimalist"
}
```
- **Response**: `200 OK`
```json
{
  "pitchDeckId": "ee3b1740-4228-4444-8d99-d45009d73d2a",
  "s3PdfUrl": "https://cdn.bravio.ai/pitchdecks/fitpulse_deck_2026.pdf"
}
```

# Bravio 🚀

*A submission for the [Vibe Coding Hackathon 2026 by HackIndia](https://github.com/HackIndiaXYZ/vibe-coding-hackathon-2026-indias-largest-ai-web3-event-hackindia-sasta-engineers).*

**Turn your business idea into a startup in 60 seconds.**

Bravio is our hackathon project built to rapidly validate and generate startup structures from a single idea. We built this to help aspiring entrepreneurs skip the boilerplate and get straight to building. 

## 🛠️ Tech Stack

This project is structured as a monorepo using [Turborepo](https://turbo.build/repo).

*   **Frontend**: Next.js, React, TailwindCSS, Radix UI
*   **Backend**: NestJS, Express
*   **Database**: Prisma ORM
*   **Authentication**: Clerk

## 📂 Project Structure

```text
bravio/
├── apps/
│   ├── api/       # NestJS backend API
│   └── web/       # Next.js frontend application
├── packages/
│   └── database/  # Prisma schema and generated client
└── turbo.json     # Turborepo configuration
```

## 🚀 Getting Started

### Prerequisites

*   Node.js (v18+)
*   npm (v10+)
*   A database (e.g., PostgreSQL or SQLite) setup for Prisma.

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/05tanish/vibe-coding-hackathon-2026-indias-largest-ai-web3-event-hackindia-sasta-engineers.git
    cd vibe-coding-hackathon-2026-indias-largest-ai-web3-event-hackindia-sasta-engineers
    ```

2.  Install dependencies:
    ```bash
    npm install
    ```

3.  Set up environment variables:
    *   Check `.env.example` in `apps/api` and `apps/web`.
    *   Create `.env` or `.env.local` files in those directories and fill in your Clerk API keys and Database URL.

4.  Set up the database:
    ```bash
    cd packages/database
    npm run db:push
    cd ../..
    ```

5.  Run the development server:
    ```bash
    npm run dev
    ```

This will start both the frontend (`apps/web`) and backend (`apps/api`) concurrently via Turborepo.

## 💡 Functionality

*   **User Auth**: Secure sign-up and login utilizing Clerk.
*   **Idea Generation**: Input a core business concept, and the backend processes it into actionable insights.
*   **Rapid Prototyping**: Instantly generates the foundational requirements for your new startup.

## 👨‍💻 Built by

*   Tanish Jain & Team

---
*Created for our recent hackathon. Still a work in progress!*

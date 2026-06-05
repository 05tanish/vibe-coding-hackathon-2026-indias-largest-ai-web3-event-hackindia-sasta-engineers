# Project Folder Structure Blueprint
## Bravio: Turn your business idea into a startup in 60 seconds

---

Bravio is structured as a high-velocity, scalable **TypeScript Monorepo** managed using **Turborepo** and **npm workspaces**. This consolidates shared configuration rules, shared types, and shared database clients, while keeping the client code and orchestrator code isolated in high-cohesion applications.

```
bravio-monorepo/
├── .github/                  # GitHub Actions CI/CD workflows
│   └── workflows/
│       ├── test.yml          # Automated CI lint/test suites
│       └── deploy.yml        # AWS rolling ECS build/deployments
├── apps/                     # Core runtime applications
│   ├── web/                  # Next.js Frontend App
│   └── api/                  # NestJS Backend API & Workers App
├── packages/                 # Shared utilities and configurations
│   ├── database/             # Shared Prisma Client and Migrations
│   ├── typescript-config/    # Standardized tsconfig profiles
│   └── eslint-config/        # Universal linting standards
├── package.json              # Monorepo root manager config
├── turbo.json                # Turborepo build optimization parameters
└── .env.example              # Central environment keys template
```

---

## 1. apps/web/ (Next.js Frontend Application)
```
apps/web/
├── public/                   # Static visual assets
│   ├── brand/                # Bravio native logos & icons
│   └── fonts/                # Self-hosted typography (if not using Google Fonts)
├── src/
│   ├── app/                  # Next.js App Router (Layouts & Pages)
│   │   ├── (auth)/           # Clerk Auth layouts and routes
│   │   │   ├── sign-in/
│   │   │   └── sign-up/
│   │   ├── dashboard/        # Authenticated workspace dashboard
│   │   │   ├── [projectId]/  # Dynamic startup details page
│   │   │   └── page.tsx      # Projects list overview
│   │   ├── layout.tsx        # Base root layout (HTML wrap)
│   │   ├── page.tsx          # Public marketing landing page
│   │   └── providers.tsx     # Theme, Query, and Clerk client providers
│   ├── components/           # Reusable React components
│   │   ├── dashboard/        # Dashboard panels (Roadmap, PitchDeck, Colors)
│   │   ├── ui/               # Copy-pasted Shadcn UI primitives (Button, Card, Input)
│   │   └── shared/           # Navigation bars, Footers, Alert states
│   ├── hooks/                # Custom React hook logic
│   │   ├── use-sse.ts        # Listening to generation streaming events
│   │   └── use-toast.ts      # Visual user notification trigger
│   ├── lib/                  # Shared web utilities
│   │   ├── api-client.ts     # Axios/Fetch setup with Clerk JWT injection
│   │   └── utils.ts          # Styling merge helper (clsx + tailwind-merge)
│   └── styles/
│       └── globals.css       # Core Tailwind directives
├── tailwind.config.js        # Design tokens styling setup
├── tsconfig.json             # Next.js TypeScript rules
└── next.config.js            # Build parameters and image domain rules
```

---

## 2. apps/api/ (NestJS Backend API & Workers Application)
```
apps/api/
├── src/
│   ├── main.ts               # Core API gateway entry point
│   ├── worker.ts             # Decoupled queue execution worker entry point
│   ├── app.module.ts         # Base NestJS routing configuration
│   ├── modules/              # Core business domains (Modular Pattern)
│   │   ├── auth/             # Clerk Auth guard integration
│   │   ├── projects/         # CRUD Operations for Projects
│   │   │   ├── projects.controller.ts
│   │   │   ├── projects.service.ts
│   │   │   └── projects.module.ts
│   │   ├── generator/        # Main AI orchestrator DAG controller
│   │   │   ├── generator.controller.ts
│   │   │   ├── generator.service.ts
│   │   │   └── generator.module.ts
│   │   ├── queue/            # BullMQ integrations (Producer & Consumer)
│   │   │   ├── queue.processor.ts # Queue Worker Logic
│   │   │   └── queue.service.ts   # Queue Job Dispatches
│   │   └── exports/          # PDF compiling & export operations
│   ├── common/               # Universal backend utilities
│   │   ├── decorators/       # Custom guards (@GetUser)
│   │   ├── filters/          # Global Exception Catch filters
│   │   ├── guards/           # Rate limiting & RBAC handlers
│   │   └── interceptors/     # Format transforming intercepts
│   └── config/               # Schema validations for env variables
├── test/                     # End-to-End Jest unit tests
├── Dockerfile.api            # Lightweight NestJS API Docker production wrapper
├── Dockerfile.worker         # Lightweight Queue Worker Docker production wrapper
└── tsconfig.json             # Backend TypeScript rules
```

---

## 3. packages/database/ (Prisma Database Layer)
```
packages/database/
├── prisma/
│   ├── schema.prisma         # Central Prisma database models definition
│   ├── migrations/           # Versioned SQL migration histories
│   └── seed.ts               # Seed data for local postgres setup
├── src/
│   └── index.ts              # Exports instantiated client instance
├── package.json
└── tsconfig.json
```

---

## 4. packages/typescript-config/ (Standardized Compile Rules)
```
packages/typescript-config/
├── base.json                 # Foundation TypeScript standard settings
├── nextjs.json               # Next.js client customized configurations
└── nodejs.json               # NestJS backend customized configurations
```

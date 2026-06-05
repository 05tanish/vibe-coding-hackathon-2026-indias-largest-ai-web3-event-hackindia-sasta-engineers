"use client";

import { UserButton } from "@clerk/nextjs";
import { Zap } from "lucide-react";
import Link from "next/link";

export function Header() {
  return (
    <header className="sticky top-0 z-50 w-full border-b border-white/5 glass-panel">
      <div className="max-w-7xl mx-auto px-4 md:px-8 h-16 flex items-center justify-between">
        {/* Logo */}
        <Link href="/dashboard" className="flex items-center gap-2.5 group">
          <div className="w-8 h-8 rounded-lg bg-gradient-to-tr from-blue-600 to-violet-500 flex items-center justify-center shadow-lg shadow-blue-500/20 group-hover:shadow-blue-500/40 transition-shadow duration-300">
            <Zap className="w-4 h-4 text-white" />
          </div>
          <span className="font-heading font-bold text-base tracking-tight bg-gradient-to-r from-white to-slate-400 bg-clip-text text-transparent">
            Bravio
          </span>
        </Link>

        {/* Nav Links */}
        <nav className="hidden md:flex items-center gap-1">
          <Link
            href="/dashboard"
            className="px-3 py-1.5 rounded-lg text-sm text-slate-400 hover:text-white hover:bg-white/5 transition-all duration-200"
            id="nav-dashboard"
          >
            Dashboard
          </Link>
        </nav>

        {/* Right Side: User Session */}
        <div className="flex items-center gap-4">
          <UserButton
            afterSignOutUrl="/"
            appearance={{
              variables: {
                colorPrimary: "#2563eb",
              },
              elements: {
                avatarBox: "w-8 h-8 ring-2 ring-white/10 hover:ring-blue-500/50 transition-all duration-200",
              },
            }}
          />
        </div>
      </div>
    </header>
  );
}

import { ArrowRight, Sparkles, Zap, Rocket, Shield, Globe } from "lucide-react";

export default function Home() {
  return (
    <main className="flex flex-col items-center justify-between min-h-screen px-4 md:px-8 py-12 md:py-24 relative overflow-hidden">
      {/* Background Decorative Gradients */}
      <div className="absolute top-[-10%] left-[5%] w-[35rem] h-[35rem] rounded-full bg-blue-500/10 blur-[120px] pointer-events-none" />
      <div className="absolute bottom-[10%] right-[5%] w-[40rem] h-[40rem] rounded-full bg-violet-600/10 blur-[130px] pointer-events-none" />

      {/* Header / Nav */}
      <nav className="w-full max-w-6xl flex justify-between items-center mb-16 md:mb-24 z-10">
        <div className="flex items-center gap-2">
          <div className="w-9 h-9 rounded-lg bg-gradient-to-tr from-blue-600 to-violet-500 flex items-center justify-center shadow-lg shadow-blue-500/20">
            <Zap className="w-5 h-5 text-white" />
          </div>
          <span className="font-heading font-bold text-xl tracking-tight bg-gradient-to-r from-white to-slate-400 bg-clip-text text-transparent">
            Bravio
          </span>
        </div>
        <a 
          href="/dashboard" 
          className="px-4 py-2 rounded-lg text-sm font-medium bg-slate-900 border border-slate-800 hover:border-slate-700 hover:bg-slate-800 transition duration-200"
          id="btn-open-app"
        >
          Open App
        </a>
      </nav>

      {/* Hero Section */}
      <div className="w-full max-w-4xl text-center flex flex-col items-center gap-6 md:gap-8 mb-20 md:mb-32 z-10">
        <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-500/10 border border-blue-500/20 text-xs font-semibold text-blue-400 mb-2">
          <Sparkles className="w-3.5 h-3.5" />
          <span>Launch Your Dream Instantly</span>
        </div>
        
        <h1 className="font-heading font-extrabold text-4xl md:text-7xl leading-tight md:leading-none tracking-tight">
          Turn your business idea into a{" "}
          <span className="bg-gradient-to-r from-blue-400 via-indigo-400 to-violet-400 bg-clip-text text-transparent">
            startup in 60 seconds
          </span>
        </h1>
        
        <p className="text-slate-400 text-base md:text-xl max-w-2xl leading-relaxed">
          Bravio orchestrates deep, multi-node AI agents to draft complete brand guidelines, responsive landing page copies, competitor strategies, and interactive investor pitch decks in real-time.
        </p>

        {/* Input Area */}
        <div className="w-full max-w-xl mt-4">
          <form className="p-1.5 rounded-xl bg-slate-900/80 border border-slate-800 flex flex-col sm:flex-row gap-2 shadow-2xl shadow-blue-500/5 focus-within:border-slate-700 transition duration-200">
            <input 
              type="text" 
              placeholder="I want to build an AI fitness coach for busy professionals..." 
              className="flex-1 bg-transparent px-4 py-3 text-sm focus:outline-none text-white placeholder-slate-500"
              id="prompt-input"
            />
            <button 
              type="submit" 
              className="px-6 py-3 rounded-lg bg-white text-black font-semibold text-sm hover:bg-slate-200 transition duration-200 flex items-center justify-center gap-2 group whitespace-nowrap"
              id="submit-prompt"
            >
              <span>Build Startup</span>
              <ArrowRight className="w-4 h-4 group-hover:translate-x-0.5 transition" />
            </button>
          </form>
        </div>
      </div>

      {/* Feature Section */}
      <div className="w-full max-w-6xl grid grid-cols-1 md:grid-cols-3 gap-6 z-10 mb-16">
        <div className="glass-panel p-8 rounded-2xl flex flex-col gap-4">
          <div className="w-10 h-10 rounded-lg bg-blue-500/10 flex items-center justify-center text-blue-400 border border-blue-500/20">
            <Rocket className="w-5 h-5" />
          </div>
          <h3 className="font-heading font-bold text-lg text-white">Full Brand Kit</h3>
          <p className="text-sm text-slate-400 leading-relaxed">
            Beautiful color palettes, typography guidelines, and custom logo marks compiled via intelligent DALL-E models in high-definition.
          </p>
        </div>

        <div className="glass-panel p-8 rounded-2xl flex flex-col gap-4">
          <div className="w-10 h-10 rounded-lg bg-indigo-500/10 flex items-center justify-center text-indigo-400 border border-indigo-500/20">
            <Globe className="w-5 h-5" />
          </div>
          <h3 className="font-heading font-bold text-lg text-white">Digital Identity</h3>
          <p className="text-sm text-slate-400 leading-relaxed">
            Seo-optimized landing page structure, sales copy, social ads copywriting, domain validation, and active network check results instantly.
          </p>
        </div>

        <div className="glass-panel p-8 rounded-2xl flex flex-col gap-4">
          <div className="w-10 h-10 rounded-lg bg-violet-500/10 flex items-center justify-center text-violet-400 border border-violet-500/20">
            <Shield className="w-5 h-5" />
          </div>
          <h3 className="font-heading font-bold text-lg text-white">Execution Strategies</h3>
          <p className="text-sm text-slate-400 leading-relaxed">
            Interactive roadmaps, business models canvasses, competitors analyses, and downloadable investor pitch decks generated seamlessly.
          </p>
        </div>
      </div>

      {/* Footer */}
      <footer className="w-full max-w-6xl flex justify-between items-center border-t border-slate-900 pt-8 z-10 text-xs text-slate-600">
        <p>© 2026 Bravio Technologies Inc. All rights reserved.</p>
        <p>Built with Google Gemini & Turborepo.</p>
      </footer>
    </main>
  );
}

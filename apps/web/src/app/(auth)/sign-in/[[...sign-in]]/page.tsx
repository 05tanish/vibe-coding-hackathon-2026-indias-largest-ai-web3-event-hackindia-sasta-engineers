import { SignIn } from "@clerk/nextjs";

export default function SignInPage() {
  return (
    <main className="flex min-h-screen w-full items-center justify-center relative overflow-hidden bg-background">
      {/* Background Decorative Gradients */}
      <div className="absolute top-[-20%] left-[-10%] w-[45rem] h-[45rem] rounded-full bg-blue-500/10 blur-[130px] pointer-events-none" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[45rem] h-[45rem] rounded-full bg-violet-600/10 blur-[130px] pointer-events-none" />

      <div className="relative z-10 p-1.5 rounded-2xl glass-panel shadow-2xl">
        <SignIn
          appearance={{
            variables: {
              colorPrimary: "#2563eb",
            },
          }}
          signUpUrl="/sign-up"
        />
      </div>
    </main>
  );
}

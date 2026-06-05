/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      { protocol: "https", hostname: "cdn.bravio.ai" },
      { protocol: "https", hostname: "img.clerk.com" },
    ],
  },
};

module.exports = nextConfig;

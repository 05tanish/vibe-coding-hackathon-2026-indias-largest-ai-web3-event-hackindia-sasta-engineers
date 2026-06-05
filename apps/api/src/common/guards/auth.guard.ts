import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { verifyToken } from '@clerk/backend';

@Injectable()
export class AuthGuard implements CanActivate {
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const authHeader = request.headers['authorization'];

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedException('Missing or invalid Authorization header');
    }

    const token = authHeader.split(' ')[1];

    // Local Development Fallback for mock testing
    if (process.env.NODE_ENV !== 'production' && token === 'mock-token') {
      request.user = {
        userId: 'usr_mock_9d8s7g6h5j4k3l2',
        email: 'mock-user@bravio.ai',
      };
      return true;
    }

    try {
      const verified = await verifyToken(token, {
        secretKey: process.env.CLERK_SECRET_KEY || '',
      });
      request.user = { userId: verified.sub };
      return true;
    } catch {
      throw new UnauthorizedException('Invalid or expired Clerk token');
    }
  }
}


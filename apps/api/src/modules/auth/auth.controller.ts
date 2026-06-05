import { Controller, Post, UseGuards, Req, HttpCode } from '@nestjs/common';
import { AuthGuard } from '../../common/guards/auth.guard';
import { GetUser } from '../../common/decorators/user.decorator';

@Controller('api/auth')
export class AuthController {
  @Post('sync')
  @UseGuards(AuthGuard)
  @HttpCode(200)
  syncUser(@GetUser() user: { userId: string }) {
    return {
      success: true,
      message: 'User session verified and synced successfully.',
      userId: user.userId,
    };
  }
}

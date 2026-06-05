import { Module, Controller, Get } from '@nestjs/common';
import { AuthModule } from './modules/auth/auth.module';

@Controller('api')
export class AppController {
  @Get('health')
  getHealth() {
    return { status: 'OK', timestamp: new Date().toISOString() };
  }
}

@Module({
  imports: [AuthModule],
  controllers: [AppController],
  providers: [],
})
export class AppModule {}

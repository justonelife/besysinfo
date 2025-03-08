import { Controller, Get, HttpStatus, Res } from '@nestjs/common';
import { Response } from 'express';
import * as si from 'systeminformation';

@Controller('temperature')
export class TemperatureController {
  @Get()
  async getTemperature(@Res() res: Response) {
    // const sysInfo = await si.cpu();
    const temperature = await si.cpuTemperature();

    res.status(HttpStatus.OK).json({
      // ...sysInfo,
      ...temperature
    });
  }
}

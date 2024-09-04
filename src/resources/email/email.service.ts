import { Injectable } from '@nestjs/common';
import * as MailPace from '@mailpace/mailpace.js';
import * as handlebars from 'handlebars';
import * as fs from 'fs';
import * as path from 'path';

@Injectable()
export class EmailService {
  compileTemplate(templateName: string, context: any): string {
    const templatePath = path.join(
      __dirname,
      'templates',
      `${templateName}.hbs`,
    );
    const templateSource = fs.readFileSync(templatePath, 'utf-8');
    const template = handlebars.compile(templateSource);
    return template(context);
  }

  async sendEmail(to: string, subject: string, htmlbody: string) {
    const client = new MailPace.DomainClient(
      '028500a7-0cc1-428b-a42c-5a9f0abac42d',
    );

    // const htmlbody = this.compileTemplate('/register/html', {
    //   name: 'register',
    //   confirmationLink: 'aaa',
    // });

    const data = await client.sendEmail({
      from: 'admin@support.smoteam.com',
      to,
      subject,
      htmlbody,
    });

    return data;

    // await this.mailerService.sendMail({
    //   to, // địa chỉ email người nhận
    //   subject, // chủ đề email
    //   //   template, // tên template
    //   //   context, // dữ liệu context cho template
    //   html: '<h1>Hellodggdg</h1>',
    // });
  }
}

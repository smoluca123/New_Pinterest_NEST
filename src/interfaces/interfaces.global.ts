export interface IResponseType<ResultDataType = any> {
  message: string;
  data: ResultDataType;
  statusCode: number;
  date: Date;
}

export interface IDecodedAccecssTokenType {
  id: string;
  username: string;
  key: string | number;
  iat?: string | number;
  exp?: string | number;
}

export interface IInfoApiType {
  name: string;
  author: string;
  version: string;
  description: string;
  authorizationToken: string;
  swagger: string;
}

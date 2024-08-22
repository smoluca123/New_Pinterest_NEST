interface IUsertypeType {
  id: number;
  type_name: string | null;
}

interface IUserType {
  id: number;
  username: string;
  full_name: string;
  email: string;
  age: number;
  avatar: string;
  user_type: IUsertypeType;
  created_at: string;
  updated_at: string;
  is_ban: number;
}

export interface ICommentType {
  id: number;
  content: string;
  user_id: number;
  created_at: Date;
  updated_at: Date;
  level: number;
  reply_to: null;
  media_id: number;
  user: IUserType;
  replies: number;
}

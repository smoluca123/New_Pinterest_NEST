import { Prisma } from '@prisma/client';

export const userTypeDataSelect = {
  id: true,
  type_name: true,
} satisfies Prisma.user_typeSelect;

export const userDataSelect = {
  id: true,
  username: true,
  email: true,
  full_name: true,
  avatar: true,
  age: true,

  is_hidden: true,
  is_active: true,
  is_ban: true,
  user_type: {
    select: userTypeDataSelect,
  },
  created_at: true,
  updated_at: true,
} satisfies Prisma.userSelect;

export const imageDataSelect = {
  id: true,
  img_name: true,
  url: true,
  created_at: true,
} satisfies Prisma.imageSelect;

export const mediaDataSelect = {
  id: true,
  name: true,
  slug: true,
  description: true,
  created_at: true,
  updated_at: true,
  type: true,
  image: {
    select: imageDataSelect,
  },
  user: {
    select: userDataSelect,
  },
} satisfies Prisma.mediaSelect;

export const saveMediaDataSelect = {
  id: true,
  created_at: true,
  media: {
    select: mediaDataSelect,
  },
} satisfies Prisma.save_mediaSelect;

export type ImageDataType = Prisma.imageGetPayload<{
  select: typeof imageDataSelect;
}>;

export type SaveMediaDataType = Prisma.save_mediaGetPayload<{
  select: typeof saveMediaDataSelect;
}>;

export type MediaDataType = Prisma.mediaGetPayload<{
  select: typeof mediaDataSelect;
}>;

export type UserDataType = Prisma.userGetPayload<{
  select: typeof userDataSelect;
}>;

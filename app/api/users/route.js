import prisma from '@/lib/prisma';
import { NextResponse } from 'next/server';

export async function GET() {
  const users = await prisma.user.findMany();
  return NextResponse.json(users);
}

export async function POST(request) {
  const data = await request.json();
  const newUser = await prisma.user.create({
    data: {
      username: data.username,
      password: data.password,
      email: data.email,
    },
  });
  return NextResponse.json(newUser);
}


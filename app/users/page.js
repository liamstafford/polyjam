import prisma from '@/lib/prisma';

async function getUsers() {
  const users = await prisma.user.findMany();
  return users;
}

export default async function UsersPage() {
  const users = await getUsers();
  return (
    <div>
      <h1>Users</h1>
      <ul>
        {users.map((user) => (
          <li key={user.id}>{user.username}</li>
        ))}
      </ul>
    </div>
  );
}


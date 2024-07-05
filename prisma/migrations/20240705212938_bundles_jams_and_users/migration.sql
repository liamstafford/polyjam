/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_userId_fkey";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Admin" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Normie" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Normie_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Judge" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Judge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OfficialJam" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authorId" INTEGER NOT NULL,

    CONSTRAINT "OfficialJam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnofficialJam" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authorId" INTEGER NOT NULL,
    "judgeId" INTEGER,

    CONSTRAINT "UnofficialJam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bundle" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Bundle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ParticipatedOfficialJams" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ParticipatedUnofficialJams" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_BundleToNormie" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_OfficialJamBundles" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_UnofficialJamBundles" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_username_key" ON "Admin"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Normie_username_key" ON "Normie"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Normie_email_key" ON "Normie"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Judge_username_key" ON "Judge"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Judge_email_key" ON "Judge"("email");

-- CreateIndex
CREATE UNIQUE INDEX "_ParticipatedOfficialJams_AB_unique" ON "_ParticipatedOfficialJams"("A", "B");

-- CreateIndex
CREATE INDEX "_ParticipatedOfficialJams_B_index" ON "_ParticipatedOfficialJams"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ParticipatedUnofficialJams_AB_unique" ON "_ParticipatedUnofficialJams"("A", "B");

-- CreateIndex
CREATE INDEX "_ParticipatedUnofficialJams_B_index" ON "_ParticipatedUnofficialJams"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_BundleToNormie_AB_unique" ON "_BundleToNormie"("A", "B");

-- CreateIndex
CREATE INDEX "_BundleToNormie_B_index" ON "_BundleToNormie"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_OfficialJamBundles_AB_unique" ON "_OfficialJamBundles"("A", "B");

-- CreateIndex
CREATE INDEX "_OfficialJamBundles_B_index" ON "_OfficialJamBundles"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_UnofficialJamBundles_AB_unique" ON "_UnofficialJamBundles"("A", "B");

-- CreateIndex
CREATE INDEX "_UnofficialJamBundles_B_index" ON "_UnofficialJamBundles"("B");

-- AddForeignKey
ALTER TABLE "OfficialJam" ADD CONSTRAINT "OfficialJam_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Admin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnofficialJam" ADD CONSTRAINT "UnofficialJam_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Normie"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnofficialJam" ADD CONSTRAINT "UnofficialJam_judgeId_fkey" FOREIGN KEY ("judgeId") REFERENCES "Judge"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ParticipatedOfficialJams" ADD CONSTRAINT "_ParticipatedOfficialJams_A_fkey" FOREIGN KEY ("A") REFERENCES "Normie"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ParticipatedOfficialJams" ADD CONSTRAINT "_ParticipatedOfficialJams_B_fkey" FOREIGN KEY ("B") REFERENCES "OfficialJam"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ParticipatedUnofficialJams" ADD CONSTRAINT "_ParticipatedUnofficialJams_A_fkey" FOREIGN KEY ("A") REFERENCES "Normie"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ParticipatedUnofficialJams" ADD CONSTRAINT "_ParticipatedUnofficialJams_B_fkey" FOREIGN KEY ("B") REFERENCES "UnofficialJam"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BundleToNormie" ADD CONSTRAINT "_BundleToNormie_A_fkey" FOREIGN KEY ("A") REFERENCES "Bundle"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BundleToNormie" ADD CONSTRAINT "_BundleToNormie_B_fkey" FOREIGN KEY ("B") REFERENCES "Normie"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OfficialJamBundles" ADD CONSTRAINT "_OfficialJamBundles_A_fkey" FOREIGN KEY ("A") REFERENCES "Bundle"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OfficialJamBundles" ADD CONSTRAINT "_OfficialJamBundles_B_fkey" FOREIGN KEY ("B") REFERENCES "OfficialJam"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UnofficialJamBundles" ADD CONSTRAINT "_UnofficialJamBundles_A_fkey" FOREIGN KEY ("A") REFERENCES "Bundle"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UnofficialJamBundles" ADD CONSTRAINT "_UnofficialJamBundles_B_fkey" FOREIGN KEY ("B") REFERENCES "UnofficialJam"("id") ON DELETE CASCADE ON UPDATE CASCADE;

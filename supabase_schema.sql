-- ============================================================
-- Bazar Ache — Supabase Schema
-- Run this in your Supabase SQL Editor (Dashboard → SQL → New Query)
-- ============================================================

-- 1. Products table
create table if not exists public.products (
  id          uuid primary key default gen_random_uuid(),
  nombre      text not null,
  descripcion text,
  categoria   text not null,
  precio      numeric(10,2) not null,
  imagen_url  text,
  galeria     text[] default '{}'::text[],
  estado      text not null default 'disponible'
                check (estado in ('disponible', 'vendido')),
  created_at  timestamptz not null default now()
);

-- ============================================================
-- 1.5 Migration: If you already created the table, run this:
-- ============================================================
-- alter table public.products add column if not exists descripcion text;
-- alter table public.products add column if not exists galeria text[] default '{}'::text[];

-- 2. Enable Row-Level Security
alter table public.products enable row level security;

-- 3. RLS Policies

-- Anyone can read products (public catalog)
create policy "Public read access"
  on public.products
  for select
  using (true);

-- Only authenticated users can insert
create policy "Authenticated insert"
  on public.products
  for insert
  to authenticated
  with check (true);

-- Only authenticated users can update
create policy "Authenticated update"
  on public.products
  for update
  to authenticated
  using (true)
  with check (true);

-- Only authenticated users can delete
create policy "Authenticated delete"
  on public.products
  for delete
  to authenticated
  using (true);

-- ============================================================
-- 4. Storage Bucket for product images
--
-- Run these AFTER creating the bucket named "product-images"
-- in Supabase Dashboard → Storage → New Bucket (set to PUBLIC).
--
-- Alternatively, run via SQL:
-- ============================================================

-- Create the bucket (public)
insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do nothing;

-- Anyone can view/download images
create policy "Public read images"
  on storage.objects
  for select
  using (bucket_id = 'product-images');

-- Authenticated users can upload images
create policy "Authenticated upload images"
  on storage.objects
  for insert
  to authenticated
  with check (bucket_id = 'product-images');

-- Authenticated users can update images
create policy "Authenticated update images"
  on storage.objects
  for update
  to authenticated
  using (bucket_id = 'product-images');

-- Authenticated users can delete images
create policy "Authenticated delete images"
  on storage.objects
  for delete
  to authenticated
  using (bucket_id = 'product-images');

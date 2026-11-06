-- รันใน Supabase > SQL Editor (รันซ้ำได้ ไม่ error)
create table if not exists public.toys (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  name text not null default 'ของเล่น',
  pixel_path text not null,
  original_path text,
  shelf int not null default 0,
  x real not null default 0.5,
  anim text not null default 'bob',
  created_at timestamptz not null default now()
);
alter table public.toys enable row level security;

drop policy if exists "own toys" on public.toys;
create policy "own toys" on public.toys for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

insert into storage.buckets (id, name, public) values ('toys','toys',true)
  on conflict (id) do nothing;

drop policy if exists "toys read" on storage.objects;
create policy "toys read" on storage.objects for select using (bucket_id = 'toys');

drop policy if exists "toys upload" on storage.objects;
create policy "toys upload" on storage.objects for insert to authenticated
  with check (bucket_id = 'toys' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "toys delete" on storage.objects;
create policy "toys delete" on storage.objects for delete to authenticated
  using (bucket_id = 'toys' and (storage.foldername(name))[1] = auth.uid()::text);

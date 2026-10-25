-- Ceviche de Cenicienta: tabla privada para guardar el estado del sistema.
-- Ejecuta este archivo en Supabase Dashboard > SQL Editor > New query.
create table if not exists public.app_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{"buys":[],"sales":[],"openingCash":0}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

revoke all on table public.app_state from anon, authenticated;
grant select, insert, update, delete on table public.app_state to authenticated;

drop policy if exists "Only owner can read app state" on public.app_state;
create policy "Only owner can read app state"
on public.app_state for select
to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "Only owner can insert app state" on public.app_state;
create policy "Only owner can insert app state"
on public.app_state for insert
to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "Only owner can update app state" on public.app_state;
create policy "Only owner can update app state"
on public.app_state for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "Only owner can delete app state" on public.app_state;
create policy "Only owner can delete app state"
on public.app_state for delete
to authenticated
using ((select auth.uid()) = user_id);

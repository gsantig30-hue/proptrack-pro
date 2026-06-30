-- ============================================================
-- PropTrack Pro — Script de configuración de Supabase
-- Ejecutar este script completo en: Supabase > SQL Editor > New query
-- ============================================================

-- Tabla de inmuebles
create table if not exists inmuebles (
  id text primary key,
  tipo text,
  operacion text,
  estado text default 'disponible',
  precio numeric,
  direccion text,
  metros numeric,
  habitaciones integer,
  banos integer,
  planta text,
  garaje text,
  telefono text,
  contacto_nombre text,
  descripcion text,
  grupo text,
  fecha_publicacion date,
  fecha_subida timestamptz default now(),
  notas jsonb default '[]'::jsonb,
  lat numeric,
  lng numeric,
  ubicacion_aproximada boolean default false,
  url_portal text,
  created_at timestamptz default now()
);

-- Tabla de clientes
create table if not exists clientes (
  id text primary key,
  nombre text not null,
  telefono text,
  email text,
  presupuesto numeric,
  presupuesto_min numeric,
  tipo text default 'cualquiera',
  operacion text default 'venta',
  metros_min numeric,
  hab_min integer,
  garaje text default 'indiferente',
  estado_pref text default 'cualquiera',
  zona text,
  notas text,
  fecha_subida timestamptz default now(),
  created_at timestamptz default now()
);

-- Activar Row Level Security (necesario en Supabase)
alter table inmuebles enable row level security;
alter table clientes enable row level security;

-- Política: cualquiera con la clave anon puede leer (vista pública de solo lectura)
create policy "Lectura publica inmuebles" on inmuebles
  for select using (true);

create policy "Lectura publica clientes" on clientes
  for select using (true);

-- Política: cualquiera con la clave anon puede escribir
-- (el control de quién puede escribir lo hacemos en el frontend con la contraseña de admin,
--  ya que es una herramienta interna de 2 personas, no una app pública)
create policy "Escritura inmuebles" on inmuebles
  for all using (true) with check (true);

create policy "Escritura clientes" on clientes
  for all using (true) with check (true);

-- Índices para mejorar rendimiento de búsquedas
create index if not exists idx_inmuebles_tipo on inmuebles(tipo);
create index if not exists idx_inmuebles_operacion on inmuebles(operacion);
create index if not exists idx_inmuebles_estado on inmuebles(estado);
create index if not exists idx_clientes_nombre on clientes(nombre);

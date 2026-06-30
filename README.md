# PropTrack Pro — Versión Online (Supabase + Vercel)

Guía paso a paso para poner PropTrack Pro en internet, accesible para 2 usuarios
(uno administrador y otro de solo vista), sin coste.

---

## PASO 1 — Crear el proyecto en Supabase

1. Ve a https://supabase.com y haz clic en **"Start your project"**
2. Regístrate con tu email o con Google (gratis)
3. Haz clic en **"New project"**
4. Rellena:
   - **Name**: `proptrack-pro`
   - **Database Password**: genera una y guárdala en un sitio seguro (no la necesitarás para el día a día, pero consérvala)
   - **Region**: elige `West EU (Ireland)` o la más cercana a Madrid
5. Pulsa **"Create new project"** y espera 1-2 minutos a que se cree

## PASO 2 — Crear las tablas de la base de datos

1. En el menú izquierdo de Supabase, haz clic en **SQL Editor**
2. Pulsa **"New query"**
3. Abre el archivo `SETUP_SUPABASE.sql` que está en esta misma carpeta
4. Copia **todo** el contenido y pégalo en el editor de Supabase
5. Pulsa **"Run"** (o Ctrl+Enter)
6. Deberías ver "Success. No rows returned" — las tablas `inmuebles` y `clientes` ya están creadas

## PASO 3 — Obtener las claves de conexión

1. En Supabase, ve a **Project Settings** (icono de engranaje) → **API**
2. Copia dos valores:
   - **Project URL** (algo como `https://abcdefgh.supabase.co`)
   - **anon public** key (una clave larga que empieza por `eyJ...`)
3. Abre el archivo `index.html` de esta carpeta con el Bloc de notas
4. Busca estas dos líneas casi al principio del `<script>`:
   ```
   const SUPABASE_URL = 'TU_SUPABASE_URL_AQUI';
   const SUPABASE_ANON_KEY = 'TU_SUPABASE_ANON_KEY_AQUI';
   ```
5. Sustituye los textos entre comillas por tus valores reales copiados de Supabase
6. Guarda el archivo

## PASO 4 — Migrar tus datos actuales

Como ya tienes inmuebles y clientes cargados en la versión local (la que abres con
doble clic en tu ordenador), vamos a exportarlos y subirlos a Supabase.

1. Abre tu PropTrack actual (el local, el de siempre)
2. Abre la consola del navegador: pulsa `F12`, luego ve a la pestaña **Console**
3. Pega este código y pulsa Enter:
   ```javascript
   copy(JSON.stringify({inmuebles: JSON.parse(localStorage.getItem('proptrack_inmuebles')||'[]'), clientes: JSON.parse(localStorage.getItem('proptrack_clientes')||'[]')}))
   ```
4. Esto copia tus datos al portapapeles. Pégalos en un archivo de texto temporal y guárdalo. Vuelve a este chat y pégamelo, y te genero el script SQL exacto de importación con tus datos reales.

## PASO 5 — Subir el proyecto a GitHub

1. Ve a https://github.com y crea una cuenta si no tienes (gratis)
2. Pulsa el botón **"New"** (o el `+` arriba a la derecha) → **"New repository"**
3. Nombre del repositorio: `proptrack-pro`
4. Marca como **Private** (privado) si no quieres que sea público
5. Pulsa **"Create repository"**
6. En tu ordenador, abre la consola (cmd) dentro de esta carpeta y ejecuta:
   ```
   git init
   git add .
   git commit -m "PropTrack Pro - version online"
   git branch -M main
   git remote add origin https://github.com/TU_USUARIO/proptrack-pro.git
   git push -u origin main
   ```
   (sustituye `TU_USUARIO` por tu usuario real de GitHub; te pedirá iniciar sesión la primera vez)

## PASO 6 — Conectar con Vercel

1. Ve a https://vercel.com y regístrate con tu cuenta de GitHub (un clic, usa el mismo login)
2. Pulsa **"Add New"** → **"Project"**
3. Busca el repositorio `proptrack-pro` que acabas de subir y pulsa **"Import"**
4. Deja todo por defecto (no hace falta tocar nada de configuración)
5. Pulsa **"Deploy"**
6. En 30-60 segundos tendrás tu URL pública, algo como `proptrack-pro.vercel.app`

## PASO 7 — Compartir el acceso

- **Tú (administrador)**: entra con la contraseña `santiago2003`
- **El segundo usuario (solo vista)**: entra sin escribir nada en el campo de contraseña, pulsando "Entrar solo en modo vista"

Comparte la URL de Vercel con la otra persona y ya puede acceder.

---

## ¿Cómo hago cambios después de publicarlo?

1. Le pides el cambio a Claude como siempre
2. Claude te da el archivo `index.html` actualizado
3. Lo sustituyes en esta carpeta
4. Ejecutas en la consola, dentro de la carpeta:
   ```
   git add .
   git commit -m "actualización"
   git push
   ```
5. Vercel detecta el cambio automáticamente y lo publica en segundos, sin que tengas que hacer nada más

---

## Notas importantes

- Esta versión **no incluye fotos** (para mantenerse dentro del plan gratuito de Supabase). Puedes guardar la URL del anuncio en el campo "URL del portal" de cada inmueble.
- Los datos se guardan en Supabase, no en el navegador — así los ven ambos usuarios en tiempo real.
- Si algún día quieres añadir fotos, se puede hacer con Supabase Storage (otro cupo gratuito de 1GB aparte).

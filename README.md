# Bazar Ache — Catálogo en Línea

Catálogo estático de artículos para un negocio local en Mexicali. Los clientes navegan el catálogo y compran directamente por WhatsApp. Incluye un panel de administración para gestionar inventario sin necesidad de código.

## Stack Tecnológico

- **[Astro](https://astro.build)** — Framework estático
- **[Tailwind CSS v4](https://tailwindcss.com)** — Estilos con configuración CSS-first
- **[Supabase](https://supabase.com)** — Base de datos, autenticación y almacenamiento de imágenes
- **Vanilla JavaScript** — Interactividad del cliente

## Requisitos Previos

- Node.js 18+
- Una cuenta de [Supabase](https://supabase.com) (plan gratuito es suficiente)

## Configuración

### 1. Clonar e instalar

```bash
git clone <repo-url>
cd bazar-ache
npm install
```

### 2. Configurar Supabase

1. Crea un proyecto nuevo en [supabase.com](https://supabase.com).
2. Ve a **SQL Editor** y ejecuta el contenido de `supabase_schema.sql`.
3. Ve a **Authentication → Users** y crea un usuario admin con email y contraseña.
4. Copia tu **Project URL** y **anon/public key** desde **Settings → API**.

### 3. Variables de entorno

Crea un archivo `.env` en la raíz del proyecto:

```env
PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
PUBLIC_SUPABASE_ANON_KEY=tu-anon-key-aqui
```

> **Nota:** Las variables con prefijo `PUBLIC_` son accesibles desde el cliente. La clave `anon` es segura para el cliente porque las políticas RLS protegen los datos.

### 4. Número de WhatsApp

Busca `WHATSAPP_NUMBER` en `src/pages/index.astro` y reemplaza `526860000000` con el número real del negocio (formato internacional sin `+`).

También actualiza los enlaces de WhatsApp en el header y footer de `index.astro`.

### 5. Ejecutar en desarrollo

```bash
npm run dev
```

- Catálogo público: `http://localhost:4321`
- Panel admin: `http://localhost:4321/admin`

## Estructura del Proyecto

```
├── public/
│   └── favicon.svg
├── src/
│   ├── layouts/
│   │   └── BaseLayout.astro      # Layout base con SEO y fuentes
│   ├── lib/
│   │   └── supabase.mjs          # Cliente de Supabase
│   ├── pages/
│   │   ├── index.astro           # Catálogo público
│   │   └── admin.astro           # Panel de administración
│   └── styles/
│       └── global.css            # Tailwind v4 + sistema de diseño
├── supabase_schema.sql           # Schema SQL + políticas RLS
├── .env.example                  # Plantilla de variables de entorno
├── astro.config.mjs              # Configuración de Astro + Tailwind
└── README.md
```

## Funcionalidades

### Catálogo Público (`/`)
- Grid asimétrico tipo editorial con productos
- Filtros por categoría (dinámicos)
- Botón "Comprar por WhatsApp" con mensaje pre-llenado
- Artículos vendidos se muestran en gris con badge "Vendido"
- Diseño responsive

### Panel Admin (`/admin`)
- Login seguro con Supabase Auth
- Dashboard con estadísticas (total, disponibles, vendidos, categorías)
- Formulario para agregar nuevos artículos
- Subida de imágenes a Supabase Storage
- Edición inline de artículos existentes
- Toggle rápido de estado (Disponible ↔ Vendido)
- Eliminación con confirmación
- Autocompletado de categorías existentes

## Despliegue

### Vercel
```bash
npm i -g vercel
vercel
```

### Netlify
```bash
npm run build
# Sube el directorio `dist/`
```

Configura las variables de entorno (`PUBLIC_SUPABASE_URL`, `PUBLIC_SUPABASE_ANON_KEY`) en la plataforma de hosting.

## Paleta de Colores

| Nombre | Hex | Uso |
|--------|-----|-----|
| Cream | `#F7F6F0` | Fondo principal |
| Charcoal | `#1C201D` | Texto y bordes |
| Forest | `#1B3B2B` | Acento principal |
| Sage | `#E2E8DC` | Tags y badges |

## Tipografía

- **Playfair Display** — Títulos y encabezados
- **Plus Jakarta Sans** — Navegación, etiquetas, cuerpo
- **Geist Mono** — Precios y datos numéricos

## Licencia

Proyecto privado — Bazar Ache, Mexicali.
# BazarAche

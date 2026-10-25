# Ceviche de Cenicienta — versión sencilla

Aplicación estática para registrar ventas y compras de una pequeña cevichería.

## Archivos
- `index.html`: aplicación.
- `_headers`: encabezados básicos de seguridad para Cloudflare Pages.

## Importante sobre el acceso privado
No se incluye un usuario y contraseña dentro del HTML. En una web estática, un login hecho solo con JavaScript puede saltarse y no protege de verdad el contenido. Para proteger el sitio publicado, usa **Cloudflare Access** y permite únicamente tu correo electrónico (y los correos de personas de confianza, si quieres).

Cloudflare Access normalmente puede enviar un código de un solo uso a tu correo. Es más seguro que escribir una contraseña compartida dentro del código.

## Publicar con GitHub + Cloudflare Pages
1. Crea un repositorio en GitHub, por ejemplo `ceviche-de-cenicienta`.
2. Sube `index.html`, `_headers` y este `README.md` a la raíz del repositorio.
3. En Cloudflare, entra a **Workers & Pages → Create → Pages → Connect to Git** (los nombres pueden variar).
4. Conecta el repositorio. Como es una web estática, no necesita comando de compilación. Deja vacío el comando de build y usa `.` como directorio de salida si el panel lo solicita.
5. Publica y copia el hostname de producción (`tu-proyecto.pages.dev`) o conecta tu dominio.
6. En Cloudflare Zero Trust, crea una aplicación **Access → Applications → Add application → Self-hosted** para el hostname de producción.
7. Configura un método de inicio de sesión (por ejemplo, **One-time PIN**) y crea una política **Allow** que incluya solo tu correo exacto. No uses una regla que permita a todo el mundo ni solo “One-time PIN” como regla de inclusión.
8. Si quieres proteger URLs de vista previa de Pages, configúralas también por separado; proteger producción no implica necesariamente proteger las vistas previas. Prueba el enlace en una ventana privada y confirma que aparece el inicio de sesión antes de ver la app.

Documentación oficial:
- Cloudflare Access: https://developers.cloudflare.com/cloudflare-one/applications/configure-apps/self-hosted-apps/
- Inicio de sesión por código al correo: https://developers.cloudflare.com/cloudflare-one/integrations/identity-providers/one-time-pin/

## Cómo se guardan los datos
Las ventas y compras se guardan en el almacenamiento local del navegador (`localStorage`). Eso significa:
- Los datos no se sincronizan automáticamente entre celular y computadora.
- Si borras los datos del navegador o cambias de navegador/dispositivo, puedes perder el registro.
- Usa el botón **DESCARGAR COPIA** regularmente y guarda el archivo CSV en un lugar seguro.
- El control de acceso protege el sitio publicado, pero no sincroniza ni cifra los datos guardados localmente en tu dispositivo.

## Qué significan los indicadores
- **Ventas:** suma de las ventas que has anotado.
- **Compras:** suma de las compras registradas, incluidos equipos reutilizables.
- **Ventas menos compras de insumos:** ventas menos las compras de ingredientes y desechables registradas. No equivale a ganancia contable real si quedan ingredientes sin usar.
- **Dinero estimado en caja:** saldo inicial + ventas registradas − todas las compras registradas. Compara con el efectivo real y actualiza el saldo inicial si empiezas un periodo nuevo.

No pongas contraseñas, claves API ni datos privados en el repositorio.

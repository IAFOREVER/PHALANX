---
name: phalanx
description: Suite soberana militar de DevSecOps, Pentesting activo, Análisis de Arquitectura AST (Understand-Anything), Certificación Adversaria Ciega con el modelo Elephant-Goldfish de Google (Dave Rensin EGM) y Mandato de Refutación Cloudflare. Audita 12 dimensiones y motores de seguridad en <35s, genera el Coverage Ledger determinista (SOC2/ISO 27001) y entrega un Dashboard Visual Interactivo Dual (Árbol de Archivos + Canvas de Nodos con Glowing Attack Path).
---

# 🛡️ PHALANX V2 — Suite Soberana de Ciberdefensa, Pentesting y Compliance

Phalanx (inspirado en la falange espartana: una muralla de escudos impenetrables) es el sistema integral de auditoría de seguridad, hardening y cumplimiento normativo para proyectos de software e inteligencia artificial.

## 🚀 Comando de Disparo
Invoca `/phalanx` en cualquier conversación para auditar de forma autónoma el proyecto activo.

```bash
/phalanx
```

---

## 🧱 Los 12 Motores y Dimensiones de Ciberdefensa

1. **SAST (Código Lógico — Semgrep):** Escaneo de sintaxis AST, inyecciones SQL/NoSQL/RCE, deserialización insegura (`pickle`), CORS permisivo y desvíos de autorización.
2. **SCA (Dependencias — Trivy):** Comprobación de CVEs públicos en manifiestos (`requirements.txt`, `package.json`, etc.) contra bases NVD y GitHub Advisory.
3. **Secretos Git (Gitleaks):** Rastreo forense de API Keys (OpenAI, Gemini, AWS, GitHub), llaves SSH privadas y contraseñas de bases de datos mediante cálculo de entropía de Shannon.
4. **DAST & APIs (Nuclei):** Sondeo dinámico de cabeceras HTTP de seguridad (HSTS, CSP, X-Content-Type-Options) y exposición de esquemas Swagger/OpenAPI.
5. **Pentesting & Fuzzing (SecLists):** Pruebas activas con diccionarios de SecLists (archivos residuales `.env`, `.git`, `.db`, backups) y verificación de Rate Limiting (HTTP 429).
6. **Perímetro VPS (Flan Scan):** Detección automática de IPs de servidores en la documentación/código y escaneo de puertos de ataque (SSH, Docker, bases de datos expuestas).
7. **Host Hardening (CIS Linux Benchmark):** Validación de amarre de servicios (`127.0.0.1` vs `0.0.0.0`), permisos de bases de datos locales (`chmod 600`) y prevención de exfiltración.
8. **AI & RAG Threat Security (Promptfoo):** Auditoría contra inyecciones indirectas de prompts, envenenamiento de embeddings, exfiltración de system prompts y DoS en el Event Loop.
9. **OSINT & Attack Surface (Subfinder):** Reconocimiento pasivo de subdominios y activos perimetrales vía Certificate Transparency (`crt.sh`) y DNS público sin emitir tráfico hostil.
10. **IaC & Container Posture (Checkov & Prowler):** Auditoría de Dockerfiles (usuarios no-root, healthchecks), Docker Compose (servicios privilegiados, `network_mode: host`) y protección SSRF Cloud 169.254.
11. **Topología AST & Reachability (Understand-Anything):** Grafo de código determinista, análisis de alcanzabilidad de fallos desde puntos de entrada públicos y cálculo del radio de impacto (*Blast Radius*).
12. **Certificación Adversaria Ciega (Elephant-Goldfish EGM):** Protocolo de doble ciego de Dave Rensin (Google) + Mandato de Refutación de Cloudflare para certificar parches libres de sesgo de memoria.

---

## 🐟 Protocolo Elephant-Goldfish (Dave Rensin EGM) + Mandato de Refutación

Phalanx erradica el sesgo de confirmación de los modelos de lenguaje mediante la separación estricta de funciones:

* **El Elefante (The Hunter):** Con memoria contextual profunda, indexa los nodos de arquitectura, rastrea correlaciones y formula hipótesis de vulnerabilidad.
* **El Pez Dorado (The Verifier):** Un auditor hostil de ojos frescos sin memoria cuya única consigna es: *"Tú no escribiste este código ni hallaste este fallo. Intenta REFUTARLO a partir de mitigaciones previas y alcanzabilidad factual"*.

### Los 5 Lentes de Certificación Goldfish:
1. **Solidez Formal y AST:** Compilación y validación de sintaxis Python nativa.
2. **Anti-Bypass Adversarial:** Detección y rechazo inmediato de parches cosméticos (`verify=False`, `except: pass`, `allow_origins=["*"]`).
3. **Radio de Impacto AST (Blast Radius):** Mapeo de propagación de cambios sobre el grafo de Understand-Anything.
4. **Accionabilidad Quirúrgica:** Generación del Diff Antes/Después y contexto detallado para el programador.
5. **Mandato de Refutación (3 Veredictos):**
   * **`CONFIRMED`:** Resistió todos los intentos de refutación (vulnerabilidad activa y alcanzable).
   * **`NEEDS_VALIDATION`:** Refutación parcial (fixture de test, ejemplo `.env.example`, o dependencia no invocada en AST).
   * **`REJECTED`:** Refutado como falso positivo o bypass inaceptable.

---

## 📋 Libro Mayor de Cobertura (`phalanx_coverage_ledger.json`)

Generado determinísticamente en cada auditoría para cumplimiento **SOC2 Tipo II**, **ISO/IEC 27001:2022** y **OWASP ASVS**:
* Manifiesto completo de archivos inspeccionados con conteo de líneas de código y estado de verificación.
* Registro inmutable de puntos de entrada y nodos AST auditados.
* Tasa de refutación de falsos positivos (100% libre de sesgo).
* Firma criptográfica **SHA-256** para auditorías corporativas.

---

## 📚 Threat Profiles de Referencia (`references/`)

* [AI & LLM Threat Profile](references/AI-AND-LLM-THREAT-PROFILE.md): Vulnerabilidades en RAG, Qdrant y Prompt Injections.
* [Adversarial Verification Protocol](references/ADVERSARIAL-VERIFICATION-PROTOCOL.md): Fundamentos matemáticos y operativos del modelo EGM.
* [Coverage & Audit Taxonomy](references/COVERAGE-AND-AUDIT-TAXONOMY.md): Estándar del Coverage Ledger e inmunidad a fallos comunes.

---

## 🛡️ Inmunidad a Fallas Conocidas de la Industria (Garantías de Diseño)

* **Windows / NTFS Safe:** Normalización de rutas POSIX/NTFS para evitar bloqueos por junctions o identificadores de 64 bits.
* **Zero Token Exhaustion:** Motores ejecutados localmente en CPU en memoria. Auditoría completa en **< 35 segundos**.
* **Zero Schema Errors:** Estructuras nativas fuertemente tipadas en Python, eliminando errores por respuestas JSON truncadas de LLMs.
* **Zero Safety Filter Refusal:** Enfoque defensivo constructivo con reglas éticas deterministas.

---

## 🎨 Dashboard Standalone Interactivo (`phalanx_report.html`)

* **Velocímetro Global de Inviolabilidad (0 a 100)** y desglose DevSecOps.
* **Flight Recorder Stepper:** Bitácora visual de cada etapa de inspección.
* **Navegación Dual:**
  * **🌲 Modalidad A (Árbol de Archivos):** Explorador jerárquico accionable con sincronización en vivo.
  * **🕸️ Modalidad B (Canvas de Nodos):** Grafo interactivo con físicas, zoom y **Glowing Attack Path**.
* **Fichas Técnicas de Remediación:** Diffs quirúrgicos con botón para copiar parche con contexto completo y dictamen adversarial.
* **Exportación Ejecutiva a PDF:** Diagramación optimizada A4 lista para comités directivos y CISOs.

---

## 🖥️ Phalanx Live Cockpit & Visual Radar (Tiempo Real)

Phalanx cuenta con un servidor de telemetría y transmisión en vivo en tiempo real con experiencia interactiva:
* **Terminal en Vivo:** Muestra el streaming de eventos de cada uno de los 13 motores durante los ~25 segundos de escaneo.
* **Radar Arquitectónico 3D:** Topología AST con orbitación interactiva y trazado en tiempo real del camino de ataque interceptado.
* **Control Dual (Escritorio + Móvil):** Permite controlar o monitorear la auditoría tanto desde el navegador de escritorio como desde cualquier smartphone conectado a la misma red Wi-Fi (incluye código QR integrado).
* **Botón Standby & Lanzamiento:** Permite iniciar la auditoría al accionar `[ 🛡️ INICIAR AUDITORÍA MILITAR ]`, y al concluir desplegar el War Room Dashboard completo con `[ 🚀 LANZAR WAR ROOM DASHBOARD ]`.

---

## 🤖 Protocolo del Asistente ante `/phalanx`

Cuando el usuario invoque `/phalanx` o solicite ejecutar la auditoría de seguridad:

1. **Activar el Live Cockpit:** Ejecutar en segundo plano el comando:
   ```powershell
   phalanx .
   # o alternativamente:
   python C:\Personal\Proyectos\Phalanx\phalanx.py .
   ```
2. **Presentar inmediatamente los 2 Enlaces Activos:** El agente DEBE responder mostrando de forma destacada ambos accesos:
   * 💻 **Enlace de Escritorio:** `http://localhost:8765`
   * 📱 **Enlace Móvil (Wi-Fi):** `http://<LAN_IP>:8765` (ej. `http://192.168.68.54:8765`)
3. **Instruir la interacción:** Indicar al usuario que el monitor se ha abierto en su navegador, y que puede iniciar la auditoría directamente accionando el botón **"🛡️ INICIAR AUDITORÍA MILITAR"** desde cualquiera de sus dispositivos, o monitorear el flujo en vivo.

---

## 💻 Ejecución Manual por CLI

```powershell
# Iniciar con Live Cockpit interactivo (muestra ambos enlaces y abre navegador)
phalanx .

# Iniciar directamente con ejecución automática
phalanx . --auto

# Ejecución tradicional pura en consola CLI (sin servidor web)
phalanx . --cli
```

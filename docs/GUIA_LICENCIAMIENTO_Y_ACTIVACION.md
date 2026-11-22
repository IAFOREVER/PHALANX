# 🛡️ Guía de Licenciamiento, Tiers y Activación — Phalanx Commercial v3.0

Esta guía documenta la gobernanza de accesos, enclavamiento causal de motores por niveles de suscripción (Tiers) y los procedimientos de activación tanto por CLI como desde el Cockpit Web en caliente (Milestones 1, 2 y 3).

---

## 1. Matriz de Cobertura de Motores por Tier

| Motor de Ciberdefensa / Pentesting | Identificador | Nivel Requerido | Cobertura |
| :--- | :--- | :---: | :---: |
| **SAST (Semgrep & AST)** | `sast` | **TRIAL / COMMUNITY** | 4 / 13 Motores |
| **SCA (Dependencias CVE Trivy)** | `sca` | **TRIAL / COMMUNITY** | 4 / 13 Motores |
| **Secretos Git (Gitleaks)** | `secrets` | **TRIAL / COMMUNITY** | 4 / 13 Motores |
| **Topología AST Básica** | `ast_basic` | **TRIAL / COMMUNITY** | 4 / 13 Motores |
| **Alcanzabilidad AST Causal (BFS)** | `reachability` | **PRO** | 8 / 13 Motores |
| **DAST Nuclei (APIs & Headers)** | `dast` | **PRO** | 8 / 13 Motores |
| **Fuzzing Activo (SecLists)** | `fuzzing` | **PRO** | 8 / 13 Motores |
| **Host Hardening (CIS Benchmark)** | `hardening` | **PRO** | 8 / 13 Motores |
| **OSINT Pasivo (crt.sh / Subfinder)** | `osint` | **ENTERPRISE** | 13 / 13 Motores |
| **Perímetro VPS (Flan Scan)** | `vps_perimeter` | **ENTERPRISE** | 13 / 13 Motores |
| **IaC & Containers (Prowler)** | `iac_containers` | **ENTERPRISE** | 13 / 13 Motores |
| **AI & RAG Security (OWASP LLM)** | `ai_rag` | **ENTERPRISE** | 13 / 13 Motores |
| **Certificación Ciega Google EGM** | `goldfish_egm` | **ENTERPRISE** | 13 / 13 Motores |
| **Libro Mayor Ed25519 (Coverage Ledger)** | `coverage_ledger` | **ENTERPRISE** | 13 / 13 Motores |

---

## 2. Experiencia Táctica en el Cockpit Web (Milestone 3)

El Cockpit Web de Phalanx (`http://127.0.0.1:8765/cockpit`) cuenta con una consola interactiva de suscripción en tiempo real:

### 2.1 Badge de Estado en el HUD Header
Ubicado en la barra superior junto al timer de telemetría:
- 🟢 **ENTERPRISE (13/13)**: Suscripción corporativa plena con todos los motores activos.
- 🔵 **PRO (8/13)**: Nivel profesional con análisis DAST, fuzzing y alcanzabilidad AST.
- 🟡 **TRIAL (Xd)**: Modo evaluación local de 14 días.
- 🔴 **LICENCIA EXPIRADA**: Alerta visual; deshabilita la ejecución de auditorías manteniendo el acceso irrestricto al historial y reportes previos.

### 2.2 Modal de Activación en Caliente
Al hacer clic en el Badge de Licencia se despliega el modal táctico que permite:
1. **Copiar Hardware ID:** Botón instantáneo `[ Copiar ID ]` que copia la huella digital canónica (`PHX-HW-XXXXXXXXXXXXXXXX`) para enviarla a IAFOREVER.
2. **Visualizar Métricas Tácticas:** Cliente titular, nivel de cobertura, estado de validez y días restantes.
3. **Parrilla de Motores Activos:** Indicadores visuales en tiempo real de qué módulos están habilitados (`✓`) o bloqueados (`🔒`).
4. **Activación sin Reinicio (Hot Reload):**
   - Pegar el token criptográfico firmado en el área de texto o presionar `[ Cargar Archivo .lic ]`.
   - Presionar `[ ACTIVAR EN CALIENTE ]`.
   - La API (`POST /api/activate_license`) valida la firma Ed25519, instala la licencia en `%APPDATA%\Phalanx\phalanx.lic`, recarga la sesión en memoria en $\le 50\text{ ms}$ y emite un evento SSE `license_updated` sincronizando todas las pestañas abiertas en $\le 100\text{ ms}$.
5. **Protección Anti-Fuzzing:** Cuerpos de solicitud mayores a 64 KB son rechazados de forma instantánea ($< 2\text{ ms}$) con código HTTP 400 y cero fugas de stack traces internos.

---

## 3. Comandos CLI de Licenciamiento (Milestone 2)

### Obtener Hardware ID de la Máquina
```bash
phalanx --hardware-id
```
*Salida canónica:* `PHX-HW-7849F051A0BE0449`

### Consultar Estado y Días Restantes
```bash
phalanx --license-info
```

### Activar Licencia Comercial
```bash
# Mediante token directo:
phalanx --activate-license "PHX.eyJhbGxvd2Vk..."

# O mediante archivo de licencia:
phalanx --activate-license mi_empresa.lic
```

### Consultar Historial (Siempre accesible, incluso con licencia expirada)
```bash
phalanx --history
```

---

## 4. Verificación de Integridad de la Suite

Para auditar y validar los 3 Milestones en un solo comando:
```bash
python verify_m1_m2_m3_environment.py
```
Salida esperada: `6/6 verificaciones exitosas` y `Criterios cuantitativos AC-M1, AC-M2 y AC-M3 100% cumplidos`.

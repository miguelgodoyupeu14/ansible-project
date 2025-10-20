# 📚 GUÍA COMPLETA DEL PROYECTO ANSIBLE

## 🎯 **VISIÓN GENERAL DEL PROYECTO**

Este es un **proyecto Ansible profesional** diseñado para automatizar la configuración completa de un **laboratorio académico híbrido** que incluye:

- 🎮 **Zentyal Server** - Gaming Center completo para estudiantes
- 🖥️ **Windows Server** - Gestión de máquinas virtuales cliente para laboratorio  
- 💻 **Administración automática** de VMs cliente con acceso al Gaming Center

**Propósito:** Crear un entorno académico donde estudiantes acceden a VMs gestionadas por Windows Server y pueden utilizar el Gaming Center en Zentyal para sesiones educativas y recreativas.

---

## 🏗️ **ARQUITECTURA DEL PROYECTO - LABORATORIO ACADÉMICO**

### 🎓 **ESCENARIO: LABORATORIO ACADÉMICO HÍBRIDO**
```
🏢 LABORATORIO ACADÉMICO
├── 🎮 Zentyal Server (Gaming Center)
│   ├── Steam + SteamCMD
│   ├── Servidores: Minecraft, Valheim, CS
│   └── Acceso desde máquinas cliente
├── 🖥️ Windows Server (Gestión Académica)  
│   ├── Active Directory
│   ├── DHCP/DNS centralizado
│   ├── Hyper-V/VMware
│   └── Políticas de grupo
└── 💻 Máquinas Cliente (Virtuales)
    ├── Windows 10/11 (laboratorio)
    ├── Linux (desarrollo)
    └── Gaming (acceso al Zentyal)
```

### 📁 **Estructura Organizacional**
```
ansible-project/
├── 📜 main.yml                    # ARCHIVO PRINCIPAL - Ejecuta todo
├── 🔐 secrets.yml                 # TODAS las contraseñas (cifrado)
├── 🛠️ vault-helper.sh             # Script para manejar contraseñas
├── ⚙️ ansible.cfg                 # Configuración de Ansible
├── 📊 README.md                   # Documentación principal
├── 🔒 SECURITY_FIXES.md          # Correcciones de seguridad
├── 🗂️ inventory/                  # Definición de servidores
│   ├── production/hosts.yml       # zenthial + windows server
│   └── group_vars/                # Configuraciones por grupo
├── 🎭 roles/                      # Funcionalidades modulares
│   ├── base/                      # Para ambos servidores
│   ├── gaming/                    # Solo Zentyal (Gaming Center)
│   └── [otros roles]/            # Multi-plataforma
├── 📋 unified_playbooks/          # Playbooks específicos
└── 📄 files/                     # Archivos y scripts
```

---

## 🎮 **FUNCIONALIDAD PRINCIPAL: GAMING CENTER**

### 🎯 **¿Qué hace el Gaming Center?**
Convierte cualquier servidor **Zentyal/Ubuntu** en un **centro completo de gaming** con:

- ✅ **SteamCMD instalado y configurado**
- ✅ **Usuario dedicado para Steam**
- ✅ **Almacenamiento optimizado** (/data/games)
- ✅ **Firewall configurado** para servidores de juegos
- ✅ **Optimizaciones de red** para gaming
- ✅ **Scripts de gestión** automatizados
- ✅ **Monitoreo y logs** especializados

### 🔧 **Juegos y Servidores Soportados:**
- 🎮 **Minecraft** (Java y Bedrock)
- ⚔️ **Valheim** 
- 🚂 **Counter-Strike**
- 🎯 **Cualquier juego con SteamCMD**

---

## 🏛️ **ROLES Y FUNCIONALIDADES**

### 🔧 **1. ROL BASE** (`roles/base/`)
**Función:** Preparación inicial del sistema

**Linux (Zentyal/Ubuntu):**
- ✅ Actualización de paquetes (apt/yum)
- ✅ Configuración de zona horaria
- ✅ Instalación de paquetes esenciales
- ✅ Configuración SSH segura
- ✅ Firewall UFW/firewalld configurado
- ✅ Creación de directorios base

**Windows:**
- ✅ Actualizaciones críticas de Windows
- ✅ Configuración IIS (si se requiere)
- ✅ Configuración de zona horaria
- ✅ Creación de directorios de scripts

### 👥 **2. ROL USERS** (`roles/users/`)
**Función:** Gestión de usuarios y seguridad

**Linux:**
- ✅ Creación de usuarios administradores
- ✅ Configuración de SSH keys (todas las llaves)
- ✅ Sudoers con **permisos limitados** (no NOPASSWD:ALL)
- ✅ Políticas de contraseñas seguras

**Windows:**
- ✅ Usuarios locales de backup
- ✅ Grupos de administradores
- ✅ Políticas de contraseñas

### ⚙️ **3. ROL SERVICES** (`roles/services/`)
**Función:** Gestión de servicios críticos

**Linux:**
- ✅ **service_facts** para detección correcta
- ✅ Cron/crond según la distribución
- ✅ Servicios de tiempo (ntp/chrony/systemd-timesyncd)
- ✅ Reportes de servicios críticos

**Windows:**
- ✅ WinRM configurado
- ✅ Servicios de tiempo Windows
- ✅ Monitoreo de procesos críticos

### 💾 **4. ROL STORAGE** (`roles/storage/`)
**Función:** Configuración de almacenamiento

**Linux (CON VALIDACIONES DE SEGURIDAD):**
- ✅ **Validaciones anti-formateo** accidental
- ✅ Verificación de dispositivos seguros
- ✅ Montaje con módulo `mount` (no lineinfile)
- ✅ Configuración de cuotas de disco
- ✅ Soporte para check_mode

**Windows:**
- ✅ Gestión de discos y volúmenes
- ✅ Formateo seguro de discos adicionales
- ✅ Permisos NTFS

### 🎮 **5. ROL GAMING** (`roles/gaming/`)
**Función:** ⭐ CORAZÓN DEL GAMING CENTER ⭐

**Funcionalidades completas:**
- ✅ **Usuario Steam dedicado** (steamuser)
- ✅ **Descarga e instalación de SteamCMD**
- ✅ **Arquitectura i386 habilitada**
- ✅ **Directorios optimizados**: /data/steam, /data/games
- ✅ **Firewall gaming** (puertos 27015, 25565, 2456, etc.)
- ✅ **Optimizaciones de red** (sysctl)
- ✅ **Script de gestión**: steam-manager.sh
- ✅ **Validaciones completas** del sistema
- ✅ **Logs especializados** para gaming

**Puertos abiertos automáticamente:**
- 🎮 27015-27016 (Steam)
- ⛏️ 25565 (Minecraft Java)
- 📱 19132 (Minecraft Bedrock)  
- ⚔️ 2456-2458 (Valheim)
- 🎯 7777-7778 (Juegos generales)

### 📊 **6. ROL AUDIT** (`roles/audit/`)
**Función:** Monitoreo y reportes del sistema

**Linux (IDEMPOTENTE Y SEGURO):**
- ✅ **Módulos nativos** (no shell >)
- ✅ Reportes de uso de disco, memoria, procesos
- ✅ Detección de servicios fallidos
- ✅ Logs de accesos recientes
- ✅ **Template de reporte** consolidado
- ✅ Copia automática al nodo de control

**Windows:**
- ✅ Recolección de servicios y procesos
- ✅ Event logs del sistema
- ✅ Reportes automáticos

---

## 🔐 **SISTEMA DE SEGURIDAD AVANZADO**

### 🛡️ **Características de Seguridad Implementadas:**
1. ✅ **Ansible Vault** - Todas las contraseñas cifradas AES256
2. ✅ **SSH Key Checking** - Host verification habilitado
3. ✅ **Sudo Limitado** - Permisos específicos, no blanket NOPASSWD
4. ✅ **Firewall Inteligente** - UFW/firewalld configurados correctamente
5. ✅ **Validaciones Storage** - Anti-formateo accidental
6. ✅ **SSH Keys Múltiples** - Todas las llaves para todos los usuarios
7. ✅ **Módulos Nativos** - No más shell inseguro

### 🔒 **Gestión Centralizada de Contraseñas:**
- 📁 **Un solo archivo**: `secrets.yml`
- 🔐 **Cifrado seguro**: AES256 con Ansible Vault
- 🛠️ **Script helper**: `./vault-helper.sh`
- 📋 **Organización clara**: Por categorías (usuarios, servicios, gaming)

---

## 🚀 **MODOS DE USO DEL PROYECTO**

### 🎯 **1. CONFIGURACIÓN COMPLETA (Recomendado)**
```bash
# Configura TODO el sistema desde cero:
./vault-helper.sh run main.yml
```
**Ejecuta:** Base + Users + Services + Storage + Gaming + Audit

### 🎮 **2. SOLO GAMING CENTER**
```bash
# Solo instala y configura el Gaming Center:
./vault-helper.sh run main.yml --tags gaming
```

### 🔧 **3. CONFIGURACIÓN POR MÓDULOS**
```bash
# Solo configuración base:
./vault-helper.sh run main.yml --tags base

# Solo usuarios y seguridad:
./vault-helper.sh run main.yml --tags users

# Solo servicios:
./vault-helper.sh run main.yml --tags services
```

### 🔍 **4. MODO VERIFICACIÓN (Sin cambios)**
```bash
# Verifica qué se haría sin ejecutar:
./vault-helper.sh run main.yml --check
```

---

## 📋 **INVENTARIO Y CONFIGURACIÓN**

### 🖥️ **Servidores del Laboratorio Académico:**

#### 🎮 **Gaming Center (Zentyal Server):**
- **Host:** zenthial (192.168.164.130)
- **Usuario:** miguelgod
- **SSH:** Key-based authentication  
- **Propósito:** Gaming Center para estudiantes con Steam y servidores de juegos
- **Grupos:** linux_servers, gaming_servers

#### 🏢 **Laboratorio Académico (Windows Server):**
- **Propósito:** Gestión de máquinas virtuales cliente
- **Servicios:** Active Directory, DHCP, DNS, Hyper-V/VMware
- **Función:** Administrar VMs de estudiantes para clases
- **Grupos:** windows_servers (en configuración)

#### 💻 **Máquinas Cliente Virtuales:**
- **Gestión:** Windows Server (dominio, políticas, DHCP)
- **Gaming:** Acceso directo al Zentyal Gaming Center
- **Tipos:** Windows 10/11 (académico), Ubuntu (desarrollo)

### 📊 **Variables por Grupo:**
- **`all.yml`** - Variables globales (timezone, paths)
- **`linux_servers.yml`** - Gaming habilitado, SSH keys, paquetes
- **`windows_servers.yml`** - Configuración Windows
- **`vault.yml`** - Referencias a contraseñas cifradas

---

## � **CASOS DE USO - LABORATORIO ACADÉMICO**

### � **1. Gaming Center (Zentyal Server)**
```bash
# Configurar Zentyal como Gaming Center completo:
./vault-helper.sh run main.yml --limit zenthial

# Resultado: Steam, Minecraft, Valheim listos para clientes
```

### 🏢 **2. Laboratorio Académico (Windows Server)**  
```bash
# Configuración Windows Server para gestión de VMs:
ansible-playbook main.yml --limit windows_servers --ask-vault-pass

# Resultado: AD, DHCP, DNS, Hyper-V configurados
```

### 💻 **3. Configuración Híbrida Completa**
```bash
# Configurar ambos servidores del laboratorio:
./vault-helper.sh run main.yml

# Resultado: Gaming Center + Laboratorio académico funcionales
```

### 🎯 **4. Solo Gaming para Clientes**
```bash
# Solo instalar gaming sin servicios académicos:
./vault-helper.sh run main.yml --limit zenthial --tags gaming

# Resultado: Gaming Center listo, clientes pueden conectar
```

### � **5. Mantenimiento de Laboratorio**
```bash
# Actualizar solo servicios críticos:
./vault-helper.sh run main.yml --tags base,services,audit

# Resultado: Ambos servidores actualizados y monitoreados
```

### 📚 **6. Preparación de Clase**
```bash
# Verificar estado antes de clase:
./vault-helper.sh run main.yml --check

# Gaming Center status:
ssh miguelgod@192.168.164.130 "/data/steam/scripts/steam-manager.sh status"
```

---

## 🛠️ **HERRAMIENTAS DE GESTIÓN**

### 🔐 **Vault Helper (`./vault-helper.sh`)**
```bash
./vault-helper.sh encrypt    # Cifrar contraseñas
./vault-helper.sh edit       # Editar contraseñas
./vault-helper.sh view       # Ver contraseñas
./vault-helper.sh status     # Estado del vault
./vault-helper.sh run        # Ejecutar playbooks
```

### 🎮 **Gaming Manager (En el servidor)**
```bash
# Después de instalar Gaming Center:
/data/steam/scripts/steam-manager.sh start   # Iniciar Steam
/data/steam/scripts/steam-manager.sh status  # Ver estado
/data/steam/scripts/steam-manager.sh logs    # Ver logs
```

---

## 🎯 **RESULTADOS ESPERADOS**

### ✅ **Después de ejecutar el proyecto completo:**

1. **🎮 Gaming Center Funcional:**
   - SteamCMD instalado y configurado
   - Usuario steam creado
   - Puertos gaming abiertos
   - Scripts de gestión disponibles

2. **🔒 Seguridad Robusta:**
   - SSH configurado correctamente
   - Firewall activo y configurado
   - Usuarios con permisos apropiados
   - Contraseñas cifradas

3. **📊 Sistema Monitoreado:**
   - Servicios críticos funcionando
   - Reportes de auditoría generados
   - Logs organizados

4. **💾 Storage Optimizado:**
   - Discos montados correctamente
   - Cuotas configuradas
   - Directorios de juegos listos

---

## 🎉 **¿QUÉ HACE ESPECIAL A ESTE PROYECTO?**

### 🏆 **Características Únicas:**
- ✅ **Gaming Center completo** con una sola ejecución
- ✅ **Multi-plataforma** (Linux + Windows en desarrollo)
- ✅ **Seguridad profesional** (16 correcciones implementadas)
- ✅ **Gestión centralizada** de contraseñas
- ✅ **Validaciones robustas** anti-desastres
- ✅ **Scripts helper** intuitivos
- ✅ **Estructura escalable** y mantenible

### 🎯 **Perfecto para:**
- � **Laboratorios académicos híbridos**
- 🎮 **Gaming Centers educativos**
- � **Administradores de sistemas educativos**
- 💻 **Gestión de máquinas virtuales cliente**
- 📚 **Aprendizaje práctico de Ansible** 
- 🚀 **Proyectos académicos de producción**
- 🎯 **Centros de formación en gaming y tecnología**

## 💻 **GESTIÓN DE MÁQUINAS CLIENTE VIRTUALES**

### 🎮 **Clientes Gaming (Acceso a Zentyal)**
```bash
# En máquinas cliente, conectar a Gaming Center:
# Minecraft Java:
minecraft_client → zenthial:25565

# Minecraft Bedrock:  
minecraft_bedrock → zenthial:19132

# Steam games:
steam_client → zenthial:27015

# Valheim:
valheim_client → zenthial:2456
```

### 🏢 **Clientes Académicos (Gestionados por Windows Server)**
```bash
# Desde Windows Server, gestionar VMs:
# Crear nueva VM para estudiante:
New-VM -Name "Estudiante01" -MemoryStartupBytes 2GB

# Aplicar políticas de grupo:
gpupdate /force

# Conectar a dominio académico:
Add-Computer -DomainName "academia.local"
```

### 🌐 **Red del Laboratorio**
```
📡 Router Principal
├── 🎮 Zentyal (192.168.164.130) - Gaming Center
├── 🖥️ Windows Server (IP a configurar) - Laboratorio  
└── 💻 Clientes (DHCP del Windows Server)
    ├── VM Windows 10 (192.168.164.x)
    ├── VM Windows 11 (192.168.164.x)
    ├── VM Linux Ubuntu (192.168.164.x)
    └── Gaming Clients (acceso directo a Zentyal)
```

### 🎯 **Flujo Típico de Clase**
1. **Profesor inicia laboratorio:**
   ```bash
   ./vault-helper.sh run main.yml --check  # Verificar estado
   ```

2. **Estudiantes acceden a VMs:**
   - Windows Server distribuye IPs (DHCP)
   - Políticas de grupo aplicadas automáticamente

3. **Gaming session:**
   - Clientes se conectan directamente a Zentyal Gaming Center
   - Servidores de Minecraft/Valheim funcionando

4. **Fin de clase:**
   ```bash
   # Backup automático y cleanup
   ansible all -m shell -a "backup-class-session.sh"
   ```

---

## 📞 **SOPORTE Y TROUBLESHOOTING**

### 🔧 **Comandos de Diagnóstico:**
```bash
# Verificar conectividad:
ansible all -m ping

# Debug completo:
./vault-helper.sh run main.yml -vvv

# Solo verificar sintaxis:
ansible-playbook main.yml --syntax-check

# Ver estado del vault:
./vault-helper.sh status
```

### 🎮 **Gaming Center Específico:**
```bash
# Verificar Steam en el servidor:
sudo -u steamuser /data/steam/steamcmd/steamcmd.sh +quit

# Ver logs de gaming:
tail -f /var/log/gaming/*.log

# Estado de servicios gaming:
/data/steam/scripts/steam-manager.sh status
```

---

🎉 **¡Tu proyecto es ahora una solución completa para LABORATORIO ACADÉMICO HÍBRIDO!** 🎓🎮🚀

### 🎯 **FUNCIONALIDAD FINAL:**
- ✅ **Zentyal Gaming Center** - Estudiantes juegan Minecraft, Valheim, Steam games
- ✅ **Windows Server** - Gestiona todas las VMs cliente del laboratorio  
- ✅ **VMs Cliente** - Acceso automático al dominio académico + Gaming Center
- ✅ **Administración centralizada** - Un comando configura todo el laboratorio

**¿Listo para activar tu laboratorio académico completo? Solo ejecuta:** `./vault-helper.sh run main.yml` 

**Resultado:** Gaming Center funcional + Windows Server gestionando VMs + Laboratorio académico operativo 🎯
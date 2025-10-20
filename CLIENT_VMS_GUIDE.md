# 💻 CONFIGURACIÓN DE MÁQUINAS CLIENTE VIRTUALES

## 🎓 **ESCENARIO DEL LABORATORIO ACADÉMICO**

### 🏗️ **Infraestructura del Laboratorio**
```
🏢 LABORATORIO ACADÉMICO HÍBRIDO
├── 🎮 Zentyal Server (192.168.164.130) 
│   ├── Gaming Center con Steam
│   ├── Minecraft Java (puerto 25565)
│   ├── Minecraft Bedrock (puerto 19132)  
│   ├── Valheim (puerto 2456-2458)
│   └── Otros juegos Steam (puerto 27015+)
│
├── 🖥️ Windows Server (a configurar)
│   ├── Active Directory Domain Services
│   ├── DHCP Server (para clientes)
│   ├── DNS Server 
│   ├── Hyper-V / VMware vSphere
│   └── Group Policy Management
│
└── 💻 Máquinas Cliente Virtuales
    ├── 🖥️ VMs Windows 10/11 (laboratorio académico)
    ├── 🐧 VMs Linux Ubuntu (desarrollo)
    ├── 🎮 Gaming Clients (acceso a Zentyal)
    └── 📚 Estaciones de trabajo (estudiantes)
```

---

## 🎮 **GAMING CENTER - CONFIGURACIÓN CLIENTE**

### 🎯 **Conexiones Gaming desde VMs Cliente**

#### ⛏️ **Minecraft Java Edition:**
```yaml
Servidor: zenthial:25565 (192.168.164.130:25565)
Versión: Última compatible con SteamCMD
Modo: Supervivencia/Creativo (configurable)
Jugadores: Hasta 20 simultáneos
```

#### 📱 **Minecraft Bedrock Edition:**  
```yaml
Servidor: zenthial:19132 (192.168.164.130:19132)
Plataforma: PC, móvil, consolas
Crossplay: Habilitado
Jugadores: Hasta 10 simultáneos
```

#### ⚔️ **Valheim:**
```yaml
Servidor: zenthial:2456 (192.168.164.130:2456)  
Mundo: Compartido entre estudiantes
Password: Configurado en vault
Jugadores: Hasta 10 simultáneos
```

#### 🎮 **Steam Games Generales:**
```yaml
Servidor Base: zenthial:27015 (192.168.164.130:27015)
Puertos Adicionales: 27016, 7777, 7778
Games: CS:GO, TF2, otros compatibles SteamCMD
```

---

## 🏢 **WINDOWS SERVER - GESTIÓN DE VMs CLIENTE**

### 📋 **Servicios Configurados en Windows Server:**

#### 🌐 **Active Directory Domain Services:**
```powershell
Dominio: academia.local
Forest: academia.local  
Domain Controller: winserver.academia.local
Users OU: CN=Estudiantes,DC=academia,DC=local
Computers OU: CN=VMs-Cliente,DC=academia,DC=local
```

#### 📡 **DHCP Server:**
```yaml
Scope: 192.168.164.100 - 192.168.164.200
Gateway: 192.168.164.1
DNS Primary: Windows Server IP
DNS Secondary: 8.8.8.8
Lease Duration: 8 horas (duración de clase)
```

#### 🌍 **DNS Server:**  
```yaml
Domain: academia.local
Forwarders: 8.8.8.8, 1.1.1.1
A Record: zenthial.academia.local → 192.168.164.130
A Record: gaming.academia.local → 192.168.164.130
```

#### 🖥️ **Hyper-V / VMware:**
```yaml
VM Templates:
  - Windows 10 Education (base académica)
  - Ubuntu 22.04 Desktop (desarrollo)
  - Gaming Client (optimizada para juegos)
  
VM Specs Standard:
  - RAM: 2-4GB por VM  
  - Storage: 40-60GB por VM
  - vCPUs: 2 cores por VM
  - Network: Bridged a red del laboratorio
```

---

## 🎯 **CONFIGURACIÓN DE POLÍTICAS DE GRUPO**

### 📚 **GPO: Laboratorio Académico**
```powershell
# Política base para todas las VMs cliente
- Desktop Wallpaper: Logo de la institución
- Start Menu: Aplicaciones académicas predefinidas
- Windows Updates: Managed by WSUS
- User Account Control: Habilitado
- Windows Firewall: Configurado para gaming + académico
```

### 🎮 **GPO: Gaming Access** 
```powershell
# Permitir acceso a Gaming Center desde VMs
- Firewall Rules: 
  * Allow zenthial:25565 (Minecraft Java)
  * Allow zenthial:19132 (Minecraft Bedrock)  
  * Allow zenthial:2456-2458 (Valheim)
  * Allow zenthial:27015+ (Steam)
- Network Access: Gaming servers whitelist
- Software Installation: Gaming clients permitidos
```

### 🔒 **GPO: Security Policy**
```powershell
# Seguridad base para laboratorio académico
- Password Policy: Complexity enabled
- Account Lockout: 5 failed attempts
- Audit Policy: Logon events, privilege use
- User Rights: Restrict administrative access
- Software Restriction: Only approved applications
```

---

## 💻 **CONFIGURACIÓN TÍPICA DE VM CLIENTE**

### 🖥️ **Windows 10/11 VM (Estudiante)**
```yaml
Propósito: Estación de trabajo académica + gaming
Specs:
  RAM: 4GB
  Storage: 60GB
  vCPUs: 2 cores
  
Software Instalado:
  - Office 365 Education
  - Visual Studio Code  
  - Chrome/Firefox
  - Minecraft Java Edition
  - Steam Client
  - VirtualBox (para sub-virtualization)
  
Network Config:
  - DHCP from Windows Server
  - Domain: academia.local
  - Gaming Access: zenthial server
```

### 🐧 **Ubuntu 22.04 VM (Desarrollo)**  
```yaml
Propósito: Desarrollo de software + Linux gaming
Specs:
  RAM: 3GB
  Storage: 50GB  
  vCPUs: 2 cores
  
Software Instalado:
  - Ubuntu Desktop
  - VS Code, IntelliJ
  - Docker, Git
  - Minecraft Java (OpenJDK)
  - Steam for Linux
  - Development tools
  
Network Config:
  - Static IP or DHCP
  - Gaming Access: zenthial server
  - SSH Access: Enabled
```

---

## 🔧 **FLUJO DE TRABAJO DEL LABORATORIO**

### 📅 **Inicio de Clase (Profesor)**
```bash
# 1. Verificar infraestructura
./vault-helper.sh run main.yml --check

# 2. Verificar Gaming Center  
ssh miguelgod@192.168.164.130 "/data/steam/scripts/steam-manager.sh status"

# 3. Iniciar VMs estudiantes (Windows Server)
Start-VM -Name "Estudiante*"

# 4. Verificar conectividad gaming
Test-NetConnection -ComputerName zenthial -Port 25565
```

### 👨‍🎓 **Durante la Clase (Estudiantes)**
```bash
# Estudiantes acceden a sus VMs asignadas
# Conexión automática vía DHCP del Windows Server
# Acceso directo a gaming center:

# Minecraft desde VM:
minecraft-launcher → zenthial:25565

# Steam games desde VM:  
steam → Connect to zenthial:27015

# Desarrollo en Linux VM:
ssh → ubuntu-vm → gaming development
```

### 🔚 **Fin de Clase (Automático)**
```bash
# Backup automático de progresos
# Snapshot de VMs importantes  
# Logs de actividad gaming
# Cleanup de archivos temporales
```

---

## 🎯 **VENTAJAS DE ESTA CONFIGURACIÓN**

### ✅ **Para el Profesor:**
- **Control centralizado** de todas las VMs desde Windows Server
- **Gaming Center** siempre disponible para clases prácticas  
- **Políticas de grupo** aplicadas automáticamente
- **Monitoring** completo vía Ansible + Windows Admin Center

### ✅ **Para los Estudiantes:**
- **Acceso gaming** inmediato desde cualquier VM
- **Entorno académico** estandarizado y consistente
- **Flexibilidad** Windows + Linux según la clase
- **Experiencia gaming** profesional con servidores dedicados

### ✅ **Para la Institución:**
- **Infraestructura híbrida** máximo aprovechamiento  
- **Seguridad centralizada** vía Active Directory
- **Escalabilidad** fácil añadir más VMs o servicios
- **ROI alto** una inversión, múltiples usos (académico + gaming)

---

## 🚀 **¡LABORATORIO LISTO PARA FUNCIONAR!**

**Con esta configuración tienes:**
- 🎮 **Gaming Center** (Zentyal) listo para estudiantes
- 🏢 **Windows Server** gestionando VMs cliente  
- 💻 **Máquinas virtuales** configuradas automáticamente
- 🔧 **Ansible** automatizando toda la infraestructura

**Comando para configurar todo:**
```bash
./vault-helper.sh run main.yml
```

🎯 **¡Laboratorio académico híbrido con Gaming Center en funcionamiento!** 🎓🎮
# 🎓 Ansible Project - Laboratorio Académico Híbrido

Este proyecto Ansible está diseñado para crear y gestionar un **laboratorio académico completo** con:
- 🎮 **Gaming Center** (Zentyal Server con Steam y servidores de juegos)  
- 🏢 **Windows Server** (gestión de máquinas virtuales cliente para laboratorio)
- 💻 **Administración automática** de máquinas virtuales cliente

## 🎯 **Propósito del Proyecto**
Automatizar completamente la configuración de un laboratorio académico híbrido donde:
- **Estudiantes** acceden a VMs gestionadas por Windows Server
- **Gaming sessions** utilizan el Zentyal Gaming Center  
- **Administración centralizada** vía Ansible para ambos servidores

## 🏗️ Estructura del Proyecto

```
ansible-project/
├── ansible.cfg                 # Configuración principal de Ansible
├── inventory/                  # Inventarios organizados por entorno
│   └── production/
│       ├── hosts.yml          # Definición de hosts
│       └── group_vars/        # Variables por grupos
├── roles/                     # Roles unificados multi-plataforma
│   ├── base/                 # Configuración base del sistema
│   │   ├── tasks/
│   │   │   ├── main.yml      # Distribuidor principal
│   │   │   ├── linux/        # Tareas específicas Linux
│   │   │   └── windows/      # Tareas específicas Windows
│   │   ├── defaults/
│   │   └── handlers/
│   ├── services/             # Gestión de servicios
│   ├── users/                # Gestión de usuarios
│   ├── storage/              # Configuración de almacenamiento
│   ├── gaming/               # Gaming Center (Steam, etc.)
│   └── audit/                # Auditoría y monitoreo
└── unified_playbooks/         # Playbooks unificados
    ├── base.yml              # Configuración base
    ├── gaming.yml            # Gaming Center completo
    ├── services.yml          # Servicios
    └── complete.yml          # Configuración completa
```

## 🎯 Características Principales

### ✅ Estructura Unificada
- **Sin redundancia**: Un solo rol por función (base, services, users, etc.)
- **Multi-plataforma**: Cada rol funciona tanto en Linux como Windows
- **Organizado**: Subdirectorios `linux/` y `windows/` dentro de cada rol

### 🎮 Gaming Center
- **Steam Integration**: Instalación y configuración automática de SteamCMD
- **Multi-servidor**: Soporte para múltiples servidores de juegos
- **Monitoreo**: Auditoría y logs de gaming servers

### 🔧 Configuración Inteligente
- **Detección automática**: Ejecuta tareas según la plataforma detectada
- **Variables centralizadas**: Configuración en `group_vars/`
- **Inventarios flexibles**: Soporte para múltiples entornos

## 🚀 Uso Rápido

### 🔐 CONFIGURACIÓN INICIAL DE SECRETS
```bash
# 1. Configurar contraseñas (editar secrets.yml)
./vault-helper.sh edit

# 2. Cifrar el archivo de secrets
./vault-helper.sh encrypt

# 3. Ejecutar configuración completa
./vault-helper.sh run main.yml
```

### ⭐ COMANDO PRINCIPAL - Configura TODO
```bash
# Con vault:
./vault-helper.sh run main.yml

# Sin helper (solicita password):
ansible-playbook main.yml --ask-vault-pass
```

### Comandos Específicos
```bash
# Configuración base
ansible-playbook unified_playbooks/base.yml

# Gaming Center completo
ansible-playbook unified_playbooks/gaming.yml

# Configuración completa (alternativo)
ansible-playbook unified_playbooks/complete.yml
```

### Por Tags (usando main.yml)
```bash
# Solo gaming
ansible-playbook main.yml --tags gaming

# Solo usuarios  
ansible-playbook main.yml --tags users

# Solo configuración base
ansible-playbook main.yml --tags base

# Solo servicios
ansible-playbook main.yml --tags services
```

## 📋 Inventario

### Grupos Disponibles
- `linux_servers`: Servidores Linux (Ubuntu, CentOS, etc.)
- `windows_servers`: Servidores Windows
- `gaming_servers`: Servidores dedicados a gaming

### Variables por Grupo
- `group_vars/all.yml`: Variables globales
- `group_vars/linux_servers.yml`: Específicas para Linux
- `group_vars/windows_servers.yml`: Específicas para Windows

## 🎮 Gaming Center

El Gaming Center está diseñado para convertir servidores en centros de gaming completos:

### Características
- **SteamCMD**: Instalación automática
- **Usuario Steam**: Configuración de usuario dedicado
- **Storage**: Configuración de almacenamiento para juegos
- **Firewall**: Apertura de puertos necesarios
- **Monitoreo**: Logs y auditoría de gaming

### Servidores Soportados
- **Zentyal Server**: Configuración principal probada
- **Ubuntu Server**: Soporte completo
- **Windows Server**: En desarrollo

## 🔒 Seguridad

### 🔐 Gestión de Contraseñas con Ansible Vault
- **Archivo centralizado**: `secrets.yml` contiene todas las contraseñas
- **Cifrado seguro**: Ansible Vault con AES256
- **Script helper**: `./vault-helper.sh` para gestión fácil

### 🛡️ Características de Seguridad
- SSH key-based authentication
- Sudo con permisos limitados (no NOPASSWD:ALL)
- Firewall configurado automáticamente
- Host key checking habilitado
- Validaciones anti-formateo accidental
- Auditoría completa de cambios

## 📦 Requisitos

- Ansible >= 2.9
- Python 3.x
- SSH access to target hosts
- Sudo privileges on target hosts

## 🔄 Migración desde Estructura Anterior

Esta nueva estructura reemplaza:
- `ansible-linux-zenthial/` → `roles/*/tasks/linux/`
- `ansible-windows-2022/` → `roles/*/tasks/windows/`
- Playbooks separados → `unified_playbooks/`

## � Gestión de Secrets con Vault

### 🆔 Configuración Inicial
```bash
# Editar contraseñas por primera vez:
./vault-helper.sh edit

# Cifrar el archivo:
./vault-helper.sh encrypt

# Crear password automático (opcional):
./vault-helper.sh create-password
```

### 📋 Comandos Útiles del Vault
```bash
# Ver estado del vault:
./vault-helper.sh status

# Ver contraseñas (requiere password):
./vault-helper.sh view

# Cambiar password del vault:
./vault-helper.sh rekey

# Ejecutar con tags específicos:
./vault-helper.sh run main.yml --tags gaming
```

### 🔒 Archivo de Contraseñas (secrets.yml)
- **Todas las contraseñas** en un solo archivo
- **Cifrado AES256** con Ansible Vault  
- **Organizado por categorías**: usuarios, servicios, gaming, etc.
- **Fácil mantenimiento** con el script helper

## �🐛 Troubleshooting

### Conexión SSH
```bash
# Verificar conectividad
ansible all -m ping

# Debug de conexión
ansible-playbook main.yml -vvv --ask-vault-pass
```

### Problemas con Vault
```bash
# Si olvidas la contraseña:
# No hay recuperación - necesitas recrear secrets.yml

# Verificar si está cifrado:
./vault-helper.sh status

# Cifrar archivo sin cifrar:
./vault-helper.sh encrypt
```

### Gaming Center
```bash
# Solo verificar gaming con vault:
./vault-helper.sh run main.yml --check --tags gaming
```

---

## 🛡️ Recomendaciones de Buenas Prácticas y Endurecimiento

1. **WinRM en Windows**: Para producción, configura WinRM sobre HTTPS y valida los certificados. Evita AllowUnencrypted y BasicAuth en entornos reales.
2. **Sudoers y NOPASSWD**: Limita el uso de NOPASSWD solo a comandos y usuarios estrictamente necesarios. No uses NOPASSWD:ALL.
3. **Gestión de Secrets**: Usa siempre Ansible Vault para cualquier dato sensible. Nunca almacenes contraseñas en texto plano.
4. **Handlers y Notificaciones**: Separa handlers y usa notify para reinicios y cambios de estado.
5. **Idempotencia**: Todos los roles y tareas deben ser idempotentes (no causar cambios innecesarios si ya están aplicados).
6. **Firewall y Seguridad**: Configura firewalld/ufw automáticamente y revisa puertos abiertos.
7. **Auditoría**: Mantén logs y reportes de auditoría para cambios críticos.
8. **Documentación**: Mantén este README y los archivos de guía actualizados con las mejores prácticas.

---

✅ **Estructura validada y probada**
🎮 **Gaming Center funcional**  
📁 **Sin redundancias**  
🔧 **Multi-plataforma**
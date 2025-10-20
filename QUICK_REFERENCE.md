# 🚀 GUÍA RÁPIDA DE REFERENCIA

## ⚡ COMANDOS ESENCIALES

### 🔐 Gestión de Contraseñas
```bash
./vault-helper.sh edit      # Configurar contraseñas
./vault-helper.sh encrypt   # Cifrar archivo
./vault-helper.sh view      # Ver contraseñas
```

### 🎮 Ejecución Principal
```bash
# Gaming Center Completo:
./vault-helper.sh run main.yml

# Solo verificar (sin cambios):
./vault-helper.sh run main.yml --check

# Solo Gaming:
./vault-helper.sh run main.yml --tags gaming
```

## 🎯 ESTRUCTURA RÁPIDA

```
📁 ansible-project/
├── main.yml           # ← EJECUTAR AQUÍ
├── secrets.yml        # ← CONTRASEÑAS (cifrado)
├── vault-helper.sh    # ← SCRIPT PRINCIPAL
├── inventory/         # ← SERVIDORES
│   └── production/
│       ├── hosts.yml  # zenthial: 192.168.164.130
│       └── group_vars/
└── roles/             # ← FUNCIONALIDADES
    ├── base/         # Sistema base
    ├── users/        # Usuarios + SSH
    ├── services/     # Servicios críticos
    ├── storage/      # Discos y montajes
    ├── gaming/       # 🎮 GAMING CENTER
    └── audit/        # Monitoreo
```

## 🎮 GAMING CENTER - RESULTADOS

### ✅ Qué se instala:
- **SteamCMD** → `/data/steam/steamcmd/`
- **Usuario Steam** → `steamuser`
- **Juegos** → `/data/games/`
- **Scripts** → `/data/steam/scripts/`
- **Firewall Gaming** → Puertos abiertos
- **Optimizaciones** → Red + Sistema

### 🎯 Puertos Gaming Abiertos:
- **27015-27016** (Steam)
- **25565** (Minecraft Java)
- **19132** (Minecraft Bedrock)
- **2456-2458** (Valheim)
- **7777-7778** (General Gaming)

## 🔧 TROUBLESHOOTING RÁPIDO

### ❌ Error de contraseñas:
```bash
./vault-helper.sh edit    # Configurar passwords
./vault-helper.sh encrypt # Cifrar de nuevo
```

### ❌ Error de conectividad:
```bash
ansible all -m ping      # Probar conexión
ssh miguelgod@192.168.164.130  # Probar SSH manual
```

### ❌ Error de sintaxis:
```bash
ansible-playbook main.yml --syntax-check
```

### 🎮 Gaming Center no funciona:
```bash
# En el servidor destino:
sudo -u steamuser /data/steam/steamcmd/steamcmd.sh +quit
ls -la /data/steam/
/data/steam/scripts/steam-manager.sh status
```

## 🎯 FLUJO TÍPICO DE USO

1. **Configurar contraseñas:**
   ```bash
   ./vault-helper.sh edit
   ```

2. **Cifrar por seguridad:**
   ```bash
   ./vault-helper.sh encrypt
   ```

3. **Ejecutar Gaming Center:**
   ```bash
   ./vault-helper.sh run main.yml
   ```

4. **Verificar en el servidor:**
   ```bash
   ssh miguelgod@192.168.164.130
   sudo -u steamuser /data/steam/steamcmd/steamcmd.sh +quit
   ```

## 📊 ARCHIVOS CLAVE

| Archivo | Propósito | Estado |
|---------|-----------|--------|
| `main.yml` | Playbook principal | ✅ Listo |
| `secrets.yml` | Contraseñas | 🔐 Cifrar antes de usar |
| `vault-helper.sh` | Script helper | ✅ Ejecutable |
| `roles/gaming/` | Gaming Center | 🎮 Core functionality |
| `inventory/production/` | Servidores | ✅ Configurado |

## 🏆 CASOS DE USO

### 🎮 **Gaming Center Completo**
```bash
./vault-helper.sh run main.yml
```
**Resultado:** Zentyal convertido en Gaming Center

### 🏢 **Servidor Empresarial**  
```bash
./vault-helper.sh run main.yml --tags base,users,services,audit
```
**Resultado:** Servidor seguro sin gaming

### 🔧 **Solo configuración base**
```bash
./vault-helper.sh run main.yml --tags base,users
```
**Resultado:** Sistema base + usuarios

---

🎉 **¡En 3 comandos tienes tu Gaming Center listo!** 🎮
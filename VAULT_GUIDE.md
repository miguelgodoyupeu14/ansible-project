# 🔐 GUÍA RÁPIDA: ARCHIVO ÚNICO DE CONTRASEÑAS

## ✅ ¿Qué tienes ahora?

### 📁 **Un solo archivo para TODAS las contraseñas:**
- `secrets.yml` - Contiene todas las contraseñas organizadas
- Usuarios, servicios, gaming, Windows, Linux, APIs, etc.

### 🛠️ **Script helper automático:**
- `./vault-helper.sh` - Maneja todo automáticamente
- Cifrar, editar, ver, ejecutar playbooks

### 🔒 **Seguridad centralizada:**
- Cifrado AES256 con Ansible Vault
- Una sola contraseña para todo
- Fácil backup y gestión

## 🚀 USAR EN 3 PASOS:

### 1️⃣ Configurar tus contraseñas:
```bash
./vault-helper.sh edit
# Edita el archivo con tus contraseñas reales
```

### 2️⃣ Cifrar el archivo:
```bash
./vault-helper.sh encrypt
# Te pide una contraseña para cifrar
```

### 3️⃣ Ejecutar tu proyecto:
```bash
./vault-helper.sh run main.yml
# Te pide la contraseña del vault y ejecuta todo
```

## 📋 COMANDOS ÚTILES:

```bash
# Ver estado del vault:
./vault-helper.sh status

# Ver contraseñas (sin descifrar):
./vault-helper.sh view

# Ejecutar solo gaming:
./vault-helper.sh run main.yml --tags gaming

# Ejecutar solo verificación:
./vault-helper.sh run main.yml --check

# Cambiar contraseña del vault:
./vault-helper.sh rekey

# Password automático (opcional):
./vault-helper.sh create-password
```

## 🎯 VENTAJAS:

✅ **Todas las contraseñas en un lugar**  
✅ **Cifrado seguro automático**  
✅ **Fácil de usar y mantener**  
✅ **Compatible con tu estructura existente**  
✅ **Script helper intuitivo**  
✅ **Respaldo fácil (solo un archivo)**

## ⚠️ IMPORTANTE:

- **NUNCA** comitees `secrets.yml` sin cifrar
- **GUARDA** la contraseña del vault en lugar seguro  
- **RESPALDA** el archivo `secrets.yml` cifrado
- **USA** el script helper para evitar errores

---

🎉 **¡Ahora tienes gestión profesional de contraseñas!** 🔐
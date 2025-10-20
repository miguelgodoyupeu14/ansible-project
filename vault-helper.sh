#!/bin/bash
# Script helper para manejar Ansible Vault
# Ubicación: ./vault-helper.sh

set -e

SECRETS_FILE="secrets.yml"
VAULT_PASSWORD_FILE=".vault_password"

show_help() {
    cat << EOF
🔐 ANSIBLE VAULT HELPER
======================

COMANDOS DISPONIBLES:

🔒 Cifrar el archivo de secrets:
   ./vault-helper.sh encrypt

🔓 Ver las contraseñas (sin descifrar):
   ./vault-helper.sh view

✏️  Editar las contraseñas:
   ./vault-helper.sh edit

🔄 Cambiar la contraseña del vault:
   ./vault-helper.sh rekey

🎯 Ejecutar playbook con vault:
   ./vault-helper.sh run [playbook]

📋 Ver estado del vault:
   ./vault-helper.sh status

🆔 Crear archivo de password automático:
   ./vault-helper.sh create-password

EJEMPLOS:
---------
# Cifrar por primera vez:
./vault-helper.sh encrypt

# Editar contraseñas:
./vault-helper.sh edit

# Ejecutar configuración completa:
./vault-helper.sh run main.yml

# Ejecutar solo gaming:
./vault-helper.sh run main.yml --tags gaming

EOF
}

check_secrets_file() {
    if [ ! -f "$SECRETS_FILE" ]; then
        echo "❌ Error: No se encuentra el archivo $SECRETS_FILE"
        exit 1
    fi
}

is_encrypted() {
    grep -q "\$ANSIBLE_VAULT" "$SECRETS_FILE" 2>/dev/null
}

case "$1" in
    encrypt)
        check_secrets_file
        if is_encrypted; then
            echo "⚠️  El archivo $SECRETS_FILE ya está cifrado"
        else
            echo "🔒 Cifrando $SECRETS_FILE..."
            ansible-vault encrypt "$SECRETS_FILE"
            echo "✅ Archivo cifrado exitosamente"
        fi
        ;;
    
    view)
        check_secrets_file
        if is_encrypted; then
            echo "🔓 Mostrando contenido de $SECRETS_FILE:"
            ansible-vault view "$SECRETS_FILE"
        else
            echo "⚠️  El archivo no está cifrado. Mostrando contenido:"
            cat "$SECRETS_FILE"
        fi
        ;;
    
    edit)
        check_secrets_file
        echo "✏️  Editando $SECRETS_FILE..."
        if is_encrypted; then
            ansible-vault edit "$SECRETS_FILE"
        else
            echo "⚠️  El archivo no está cifrado. ¿Deseas cifrarlo primero? (y/n)"
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]]; then
                ansible-vault encrypt "$SECRETS_FILE"
                ansible-vault edit "$SECRETS_FILE"
            else
                "${EDITOR:-vi}" "$SECRETS_FILE"
            fi
        fi
        ;;
    
    rekey)
        check_secrets_file
        if is_encrypted; then
            echo "🔄 Cambiando contraseña del vault..."
            ansible-vault rekey "$SECRETS_FILE"
            echo "✅ Contraseña cambiada exitosamente"
        else
            echo "❌ El archivo no está cifrado. Usa 'encrypt' primero."
        fi
        ;;
    
    run)
        if [ -z "$2" ]; then
            echo "❌ Especifica un playbook. Ejemplo: ./vault-helper.sh run main.yml"
            exit 1
        fi
        
        playbook="$2"
        shift 2
        args="$*"
        
        if [ ! -f "$playbook" ]; then
            echo "❌ No se encuentra el playbook: $playbook"
            exit 1
        fi
        
        echo "🎯 Ejecutando $playbook con vault..."
        
        if [ -f "$VAULT_PASSWORD_FILE" ]; then
            echo "🔑 Usando archivo de password automático"
            ansible-playbook "$playbook" --vault-password-file "$VAULT_PASSWORD_FILE" $args
        else
            echo "🔑 Solicitando password del vault"
            ansible-playbook "$playbook" --ask-vault-pass $args
        fi
        ;;
    
    status)
        check_secrets_file
        echo "📋 ESTADO DEL VAULT:"
        echo "==================="
        
        if is_encrypted; then
            echo "🔒 Estado: CIFRADO ✅"
        else
            echo "🔓 Estado: SIN CIFRAR ⚠️"
        fi
        
        echo "📁 Archivo: $SECRETS_FILE"
        echo "📏 Tamaño: $(du -h "$SECRETS_FILE" | cut -f1)"
        echo "📅 Modificado: $(stat -c %y "$SECRETS_FILE")"
        
        if [ -f "$VAULT_PASSWORD_FILE" ]; then
            echo "🔑 Password automático: CONFIGURADO ✅"
        else
            echo "🔑 Password automático: NO CONFIGURADO"
        fi
        ;;
    
    create-password)
        echo "🆔 Creando archivo de password automático..."
        echo "Introduce la contraseña del vault:"
        read -s vault_password
        echo "$vault_password" > "$VAULT_PASSWORD_FILE"
        chmod 600 "$VAULT_PASSWORD_FILE"
        echo "✅ Archivo $VAULT_PASSWORD_FILE creado"
        echo "🔐 Ahora puedes usar: ./vault-helper.sh run main.yml"
        ;;
    
    help|--help|-h|"")
        show_help
        ;;
    
    *)
        echo "❌ Comando desconocido: $1"
        echo "Usa './vault-helper.sh help' para ver los comandos disponibles"
        exit 1
        ;;
esac
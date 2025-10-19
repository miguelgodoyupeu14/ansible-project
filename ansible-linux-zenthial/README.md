# Proyecto Ansible para Linux (zenthial)

## Pasos de uso

1. Crea el inventario y host_vars/zenthial.yml
2. Prueba la conexión SSH:
   ```
   ansible -i inventory zenthial -m ping
   ```
3. Ejecuta el playbook base:
   ```
   ansible-playbook -i inventory playbooks/00_base_linux.yml -v
   ```
4. Ejecuta con `--check` antes de cambiar producción:
   ```
   ansible-playbook -i inventory playbooks/00_base_linux.yml --check
   ```

## Seguridad

- Usa **Ansible Vault** para proteger credenciales:
  ```
  ansible-vault create group_vars/vault.yml
  ansible-playbook -i inventory playbooks/02_users_linux.yml --ask-vault-pass
  ```

## Compatibilidad

- Los roles y tareas usan condiciones para soportar Debian/Ubuntu y RHEL/CentOS.
- Prueba tareas de almacenamiento y formateo de discos solo en entornos de laboratorio/VM.

## Estructura

- `roles/` contiene roles reutilizables para administración, servicios, usuarios, tareas programadas, almacenamiento y auditoría.
- `playbooks/` contiene playbooks para cada área administrativa.
- `files/` incluye scripts de ejemplo para backup y limpieza.

## Notas

- Los reportes de auditoría se copian automáticamente al nodo de control en la carpeta `reports/`.

# Proyecto Ansible para Windows Server 2022

## Pasos de uso

1. Instala la colección oficial:
   ```
   ansible-galaxy collection install ansible.windows
   ```

2. Prueba la conexión:
   ```
   ansible -i inventory windows_lab -m win_ping
   ```

3. Ejecuta un playbook de ejemplo:
   ```
   ansible-playbook -i inventory playbooks/00_base_windows.yml -v
   ```

## Seguridad

- Usa **Ansible Vault** para proteger credenciales:
  ```
  ansible-vault encrypt group_vars/vault.yml
  ansible-playbook -i inventory playbooks/02_users_windows.yml --ask-vault-pass
  ```

- En producción, configura WinRM sobre HTTPS y no uses `ansible_winrm_server_cert_validation=ignore`.

- Para habilitar WinRM remoto, ejecuta en el servidor Windows:
  ```
  powershell.exe -File files/ConfigureRemotingForAnsible.ps1
  ```

## Estructura

- `roles/` contiene roles reutilizables para administración, servicios, usuarios, tareas programadas, almacenamiento y auditoría.
- `playbooks/` contiene playbooks para cada área administrativa.
- `files/` incluye scripts y utilidades para copiar al servidor Windows.

## Notas

- Prueba tareas de almacenamiento y formateo de discos solo en entornos de laboratorio.
- Los reportes de auditoría se copian automáticamente al nodo de control en la carpeta `reports/`.

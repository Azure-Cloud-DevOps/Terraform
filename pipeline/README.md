

## 💡 Notes:
  No SSH key is needed if you use az vmss run-command.
  Replace example-vmss and example-resources with your actual values.
  Ensure the service connection has contributor permissions.
  The AzureCLI@2 task allows running direct commands via az CLI.

## 🛡️ Optional: SSH Access via Azure Pipeline
If you must use SSH, do the following:
Store your SSH private key in Azure DevOps Pipeline secrets (as a secure variable or secret file).
Retrieve public IP of Load Balancer via CLI.
Run ssh from the pipeline using the private key.

      - script: |
          echo "$SSH_PRIVATE_KEY" > id_rsa
          chmod 600 id_rsa
          ssh -i id_rsa -p 50000 adminuser@<public-ip> "uptime"
        displayName: 'SSH into VMSS instance'
        env:
          SSH_PRIVATE_KEY: $(sshPrivateKey)


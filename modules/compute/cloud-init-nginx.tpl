#cloud-config
package_update: true
packages:
  - nginx
write_files:
  - path: /var/www/html/index.html
    permissions: "0644"
    owner: root:root
    content: |
      <html>
        <head><title>Auto Healing</title></head>
        <body style="font-family: sans-serif; padding: 2rem;">
          <h1>welcome - this is autohealling page</h1>
          <p>Served by an Azure VMSS instance behind a Standard Load Balancer.</p>
        </body>
      </html>
runcmd:
  - systemctl enable nginx
  - systemctl restart nginx

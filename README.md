# Install Podman on WSL2

```bash
sudo sh ./install-podman-wsl2.sh
```
# Run sample container 

```bash
podman run -dt -p 8080:80 mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine
podman ps
```
Visit **http://localhost:8080**



#!/bin/bash
# inicializacija VM z Dockerjem

set -e

echo "=== Začetek inicializacije VM ==="

# 1. Posodobitev sistema
echo "Posodabljam sistem..."
sudo apt-get update -y
sudo apt-get upgrade -y

# 2. Namestitev potrebnih paketov
for pkg in apt-transport-https ca-certificates curl gnupg lsb-release; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        echo "Namestim paket $pkg..."
        sudo apt-get install -y $pkg
    else
        echo "Paket $pkg je že nameščen."
    fi
done

# 3. Namestitev Dockerja, če še ni nameščen
if ! command -v docker >/dev/null 2>&1; then
    echo "Dodajam Docker repozitorij..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    echo "Posodabljam paketni seznam in nameščam Docker..."
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "Omogočam in zaženi Docker service..."
    sudo systemctl enable docker
    sudo systemctl start docker
else
    echo "Docker je že nameščen."
fi

# 4. Dodaj uporabnika v docker skupino, če še ni
if groups $USER | grep &>/dev/null "\bdocker\b"; then
    echo "Uporabnik $USER je že v docker skupini."
else
    echo "Dodajam uporabnika $USER v docker skupino..."
    sudo usermod -aG docker $USER
    echo "Po koncu inicializacije se odjavi in ponovno prijavi, da bo sprememba veljala."
fi

# 4. Dodaj uporabnika v docker skupino, če še ni
if groups vagrant | grep &>/dev/null "\bdocker\b"; then
    echo "Uporabnik vagrant je že v docker skupini."
else
    echo "Dodajam uporabnika vagrant v docker skupino..."
    sudo usermod -aG docker vagrant
    echo "Po koncu inicializacije se odjavi in ponovno prijavi, da bo sprememba veljala."
fi

# 5. Preverjanje namestitve
echo "Docker verzija:"
docker --version
echo "Docker Compose verzija:"
docker compose version

if ! command -v docker >/dev/null 2>&1; then
    echo "Ne najdem Dockerja."
else

    echo "Prenašam Docker sliko: Portainer"
    docker pull -q portainer/portainer-ce:2.20.2

    echo "Prenašam Docker sliko: Postgresql"
    docker pull -q postgres:18.1

    echo "Prenašam Docker sliko: MySql"
    docker pull -q mysql:9.6.0

    echo "Prenašam Docker sliko: PgAdmin"
    docker pull -q dpage/pgadmin4:9.11

    echo "Prenašam Docker sliko: Sonar Qube"
    docker pull -q sonarqube:26.2.0.119303-community

    echo "Nameščam Portainer"
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.20.2

    echo "Nameščam MySql, Postgresql, PgAdmin4"
    cd /vagrant/docker-compose
    docker compose up -d

    echo "Nameščam SonarQube"
    cd /vagrant/docker-compose-sq
    echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
    docker compose up -d

    echo "Portainer -> https://192.168.56.10:9443/#!/2/docker/containers"
    echo "PgAdmin4 -> http://192.168.56.10:5050 (admin@admin.com, admin)"
    echo "SonarQube -> http://192.168.56.10:9090/ (admin, admin)"  
fi

echo "=== Inicializacija zaključena ==="

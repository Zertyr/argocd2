FROM node:14 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod
# Étape de déploiement
FROM nginx:alpine

# Copier les fichiers de l'étape de construction dans le répertoire NGINX
COPY --from=build /app/dist/argocd2 /usr/share/nginx/html

# Copier la configuration NGINX personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port 80
EXPOSE 80

# Commande pour démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]

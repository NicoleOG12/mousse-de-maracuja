FROM nginx:alpine
COPY . /usr/share/nginx/html
COPY . /usr/share/nginx/css
COPY . /usr/share/nginx/Mousse_de_Maracujá.jpg
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
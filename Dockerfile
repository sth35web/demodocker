FROM nginx:latest
MAINTAINER sthiaux <sthiaux@pagesjaunes.fr>

ENV VERSION=master

RUN apt-get update && apt-get install -y curl && apt-get clean

RUN curl -Ls https://github.com/sth35web/demodocker/raw/${version}/myapp.tar.gz | tar -xz -C /usr/share/nginx/html/


# Add services configuration
#ADD etc /etc

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

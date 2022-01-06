# calibre-web_manage_database
A script that allow calibre-web to manage its database from itself.

## Usage
```
services:
calibre-web:
    image: lscr.io/linuxserver/calibre-web:latest
    container_name: calibre-web
    #tty: true 
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - DOCKER_MODS=linuxserver/calibre-web:calibre #optional
      - OAUTHLIB_RELAX_TOKEN_SCOPE=1 #optional
    volumes:
      - <config/dir>:/config
      - <folder/to/save/database>:/database
      - <folder/with/books>:/books
      - ./calibre_sync_library.sh:/update_library
    ports:
      - 8083:8083
    command: bash -c "./update_library /libri /books"
    #command: watch -n 10000 'calibredb add -r /books --with-library /database'
    restart: unless-stopped
```
FOR /F "delims=: tokens=2" %%a in ('ipconfig ^| find "IPv4"') do set HostIP=%%a
set HostIP=%HostIP: =%
ECHO %HostIP%

CALL docker build -t bean/owt-server:1.0 --no-cache .
CALL docker rm -f owt-server
CALL docker kill owt-server
CALL docker run -it --env DOCKER_HOST=%HostIP% -v %CD%:/tmp/git/owt-docker/owt-server-4.3 -p 3004:3004 -p 3300:3300 -p 8080:8080 -p 60000-60050:60000-60050/udp --name=owt-server --privileged acquojp/owt-server bash -c "./launch.sh && bash"
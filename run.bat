FOR /F "delims=: tokens=2" %%a in ('ipconfig ^| find "IPv4"') do set HostIP=%%a
set HostIP=%HostIP: =%
ECHO HostIP = %HostIP%

REM CALL docker build -t acquojp/owt-server --no-cache .
CALL docker rm -f owt-server
CALL docker kill owt-server
CALL docker run -it --env DOCKER_HOST=%HostIP% -p 3004:3004 -p 3300:3300 -p 8080:8080 -p 60000-60050:60000-60050/udp --name=owt-server --privileged registry.cn-hangzhou.aliyuncs.com/ossrs/owt:config bash -c "cd dist && echo | ./bin/init-all.sh && ./bin/start-all.sh && bash"

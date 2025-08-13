FROM docker://benjaminkirk/ncar-derecho-wrf:latest

SHELL ["/bin/bash", "-c"]

# Compile WRF-CPM
RUN source /container/config_env.sh && \
    rm -rf /container/WRF && \
    git clone https://github.com/YanXiaUci/WRF.git /container/WRF && \
    cd /container/WRF && \
    ./clean -a && \
    echo "34\n1" | ./configure && \
    ./compile -j 8 em_real && \
    test -f ./main/wrf.exe && \
    test -f ./main/real.exe && \
    cp ./main/wrf.exe /container/wrf-4.4.2/ && \
    cp ./main/real.exe /container/wrf-4.4.2/ && \
    # Adjust permissions to allow all users to access
    chmod -R a+rx /container

CMD ["/bin/bash"]
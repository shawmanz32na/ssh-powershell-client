FROM mcr.microsoft.com/powershell:6.1.2-ubuntu-18.04

RUN apt update && \
    apt install -y ssh-client && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p ~/.ssh && \
    echo "Host *\\n\\tStrictHostKeyChecking no\\n\\tForwardAgent yes\\n\\n" > ~/.ssh/config

ADD ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Restore mcr.microsoft.com/powershell's CMD, since it gets overwritten by us setting the ENTRYPOINT
CMD [ "pwsh" ]
